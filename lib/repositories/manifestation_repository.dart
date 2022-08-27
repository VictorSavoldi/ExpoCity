import 'dart:io';

import 'package:expocity/models/manifestation.dart';
import 'package:expocity/repositories/parse_errors.dart';
import 'package:expocity/repositories/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:path/path.dart' as path;

class ManifestationRepository {
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
