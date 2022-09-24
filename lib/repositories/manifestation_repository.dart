import 'dart:io';

import 'package:expocity/models/category.dart';
import 'package:expocity/models/manifestation.dart';
import 'package:expocity/models/user.dart';
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
    required int page,
  }) async {
    final queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(keyManifestationTable))
          ..includeObject([
            keyManifestationOwner,
            keyManifestationCity,
            keyManifestationCategory,
            keyManifestationNeighborhood,
          ])
          ..setAmountToSkip(page * 20)
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

    if (filter.neighborhood != null && filter.neighborhood!.id != '*') {
      queryBuilder.whereEqualTo(
          keyManifestationNeighborhood,
          (ParseObject(keyNeighborhoodTable)
                ..set(keyNeighborhoodId, filter.neighborhood!.id))
              .toPointer());
    }

    switch (filter.orderBy) {
      case OrderBy.OLD:
        queryBuilder.orderByAscending(keyManifestationCreatedAt);
        break;
      case OrderBy.RECENT:
      default:
        queryBuilder.orderByDescending(keyManifestationCreatedAt);
        break;
    }

    if (filter.manifestationStatus == MANIFESTATION_STATUS_ACTIVE) {
      queryBuilder.whereEqualTo(
          keyManifestationStatus, ManifestationStatus.ACTIVE.index);
    }

    if (filter.manifestationStatus == MANIFESTATION_STATUS_RESOLVED) {
      queryBuilder.whereEqualTo(
          keyManifestationStatus, ManifestationStatus.RESOLVED.index);
    }

    if (filter.manifestationStatus ==
        (MANIFESTATION_STATUS_ACTIVE | MANIFESTATION_STATUS_RESOLVED)) {
      queryBuilder.whereNotEqualTo(
          keyManifestationStatus, ManifestationStatus.DELETED.index);
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

      if (manifestation.id != null) {
        manifestationObject.set<String>(keyManifestationId, manifestation.id!);
      }

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
            ..set(keyCategoryId, manifestation.category!.id));

      manifestationObject.set<ParseObject>(keyManifestationCity,
          ParseObject(keyCityTable)..set(keyCityId, manifestation.city!.id));

      manifestationObject.set<ParseObject>(
          keyManifestationNeighborhood,
          ParseObject(keyNeighborhoodTable)
            ..set(keyNeighborhoodId, manifestation.neighborhood!.id));

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
        if (image is String) {
          final parseFile = ParseFile(File(path.basename(image)));
          parseFile.name = path.basename(image);
          parseFile.url = image;
          parseImages.add(parseFile);
        } else {
          final parseFile = ParseFile(image, name: path.basename(image.path));
          final response = await parseFile.save();
          if (!response.success) {
            return Future.error(
                ParseErrors.getDescription(response.error!.code).toString());
          }
          parseImages.add(parseFile);
        }
      }

      return parseImages;
    } catch (e) {
      return Future.error('Falha ao salvar imagens.');
    }
  }

  Future<List<Manifestation>> getMyManifestations(User user) async {
    final currentUser = ParseUser('', '', '')..set(keyUserId, user.id);
    final queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(keyManifestationTable))
          ..setLimit(150)
          ..orderByDescending(keyManifestationCreatedAt)
          ..whereEqualTo(keyManifestationOwner, currentUser.toPointer())
          ..includeObject([
            keyManifestationOwner,
            keyManifestationCity,
            keyManifestationCategory,
            keyManifestationNeighborhood,
          ]);

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

  Future<List<Manifestation>> getAllPendingManifestations() async {
    final queryBuilder = QueryBuilder<ParseObject>(
        ParseObject(keyManifestationTable))
      ..setLimit(250)
      ..orderByDescending(keyManifestationCreatedAt)
      ..whereEqualTo(keyManifestationStatus, ManifestationStatus.PENDING.index)
      ..includeObject([
        keyManifestationOwner,
        keyManifestationCity,
        keyManifestationCategory,
        keyManifestationNeighborhood,
      ]);

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

  Future<void> resolve(Manifestation manifestation) async {
    final parseObject = ParseObject(keyManifestationTable)
      ..set(keyManifestationId, manifestation.id)
      ..set(keyManifestationStatus, ManifestationStatus.RESOLVED.index);

    final response = await parseObject.save();

    if (!response.success) {
      return Future.error(
          ParseErrors.getDescription(response.error!.code).toString());
    }
  }

  Future<void> active(Manifestation manifestation) async {
    final parseObject = ParseObject(keyManifestationTable)
      ..set(keyManifestationId, manifestation.id)
      ..set(keyManifestationStatus, ManifestationStatus.ACTIVE.index);

    final response = await parseObject.save();

    if (!response.success) {
      return Future.error(
          ParseErrors.getDescription(response.error!.code).toString());
    }
  }

  Future<void> delete(Manifestation manifestation) async {
    final parseObject = ParseObject(keyManifestationTable)
      ..set(keyManifestationId, manifestation.id)
      ..set(keyManifestationStatus, ManifestationStatus.DELETED.index);

    final response = await parseObject.save();

    if (!response.success) {
      return Future.error(
          ParseErrors.getDescription(response.error!.code).toString());
    }
  }
}
