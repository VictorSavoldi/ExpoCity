import 'dart:io';

import 'package:expocity/models/category.dart';
import 'package:expocity/models/manifestation.dart';
import 'package:expocity/repositories/parse_errors.dart';
import 'package:expocity/repositories/table_keys.dart';
import 'package:expocity/stores/filter_store.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart' as path;

class ManifestationRepository {
  Future<List<Manifestation>> getHomeManifestationList({
    FilterStore? filter,
    String? search,
    Category? category,
  }) async {
    final queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(keyManifestationTable))
          ..includeObject([
            keyManifestationOwner,
            keyManifestationCity,
            keyManifestationCategory,
            keyManifestationNeighborhood,
          ])
          ..setLimit(20);

    if (filter!.city != null) {
      queryBuilder.whereEqualTo(
          keyManifestationCity,
          (ParseObject(keyCityTable)..set(keyCityId, filter.city!.id))
              .toPointer());
    }

    if (search != null && search.trim().isNotEmpty) {
      queryBuilder.whereContains(keyManifestationTitle, search,
          caseSensitive: false);
    }

    if (category != null && category.id != '*') {
      queryBuilder.whereEqualTo(
          keyManifestationCategory,
          (ParseObject(keyCategoryTable)..set(keyCategoryId, category.id))
              .toPointer());
    }

    switch (filter.orderBy) {
      case OrderBy.OLD:
        queryBuilder.orderByDescending(keyManifestationCreatedAt);
        break;
      case OrderBy.RECENT:
      default:
        queryBuilder.orderByAscending(keyManifestationCreatedAt);
        break;
    }

    if (filter.manifestationStatus > 0 &&
        filter.manifestationStatus <
            (MANIFESTATION_STATUS_RESOLVED | MANIFESTATION_STATUS_ACTIVE)) {
      if (filter.manifestationStatus == MANIFESTATION_STATUS_ACTIVE) {
        queryBuilder.whereEqualTo(
            keyManifestationStatus, ManifestationStatus.ACTIVE.index);
      }
      if (filter.manifestationStatus == MANIFESTATION_STATUS_RESOLVED) {
        queryBuilder.whereEqualTo(
            keyManifestationStatus, ManifestationStatus.RESOLVED.index);
      }
    }

    final response = await queryBuilder.query();
    if (response.success && response.results == null) {
      return [];
    } else if (response.success) {
      return response.results!
          .map((po) => Manifestation.fromParse(po))
          .toList();
    } else {
      return Future.error(
          ParseErrors.getDescription(response.error!.code).toString());
    }
  }

  Future<void> save(Manifestation manifestation) async {
    try {
      final parseUser = await ParseUser.currentUser();

      final parseImages = await saveImages(manifestation.images);

      final manifestationObject = ParseObject(keyManifestationTable);

      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);
      manifestationObject.setACL(parseAcl);

      manifestationObject.set<String>(
          keyManifestationTitle, manifestation.title);

      manifestationObject.set<String>(
          keyManifestationDescription, manifestation.description);

      manifestationObject.set<String>(
          keyManifestationStreet, manifestation.street);

      manifestationObject.set<bool>(
          keyManifestationHideName, manifestation.hidName);

      manifestationObject.set<int>(
          keyManifestationStatus, manifestation.status.index);

      manifestationObject.set<List<ParseFile>>(
          keyManifestationImages, parseImages);

      manifestationObject.set<ParseUser>(keyManifestationOwner, parseUser);

      manifestationObject.set<ParseObject>(
          keyManifestationCategory,
          ParseObject(keyCategoryTable)
            ..set(keyCategoryId, manifestation.category.id));

      manifestationObject.set<ParseObject>(keyManifestationCity,
          ParseObject(keyCityTable)..set(keyCityId, manifestation.city.id));

      manifestationObject.set<ParseObject>(
          keyManifestationNeighborhood,
          ParseObject(keyNeighborhoodTable)
            ..set(keyNeighborhoodId, manifestation.neighborhood.id));

      final response = await manifestationObject.save();

      if (!response.success) {
        Future.error(
            ParseErrors.getDescription(response.error!.code).toString());
      }
    } catch (e) {
      return Future.error('Falha ao salvar anúncio');
    }
  }

  Future<List<ParseFile>> saveImages(List images) async {
    final parseImages = <ParseFile>[];

    try {
      for (final image in images) {
        if (image is File) {
          final parseFile = ParseFile(image, name: path.basename(image.path));

          final response = await parseFile.save();

          if (!response.success) {
            return Future.error(
                ParseErrors.getDescription(response.error!.code).toString());
          }

          parseImages.add(parseFile);
        } else {
          final parseFile = ParseFile(null);

          parseFile.name = path.basename(image);
          parseFile.url = image;
          parseImages.add(parseFile);
        }
      }

      return parseImages;
    } catch (e) {
      return Future.error('Falha ao salvar imagens.');
    }
  }
}
