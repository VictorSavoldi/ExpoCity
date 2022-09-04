import 'package:expocity/models/category.dart';
import 'package:expocity/models/city.dart';
import 'package:expocity/models/neighborhood.dart';
import 'package:expocity/models/user.dart';
import 'package:expocity/repositories/table_keys.dart';
import 'package:expocity/repositories/user_repository.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

enum ManifestationStatus { ACTIVE, RESOLVED, DELETED }

class Manifestation {
  Manifestation();

  Manifestation.fromParse(ParseObject object) {
    id = object.objectId!;
    title = object.get<String>(keyManifestationTitle)!;
    description = object.get<String>(keyManifestationDescription)!;

    images =
        object.get<List>(keyManifestationImages)!.map((e) => e.url).toList();

    hidName = object.get<bool>(keyManifestationHideName)!;
    createdAt = object.createdAt!;

    status =
        ManifestationStatus.values[object.get<int>(keyManifestationStatus)!];

    user = UserRepository().mapParseToUserManifestation(
        object.get<ParseUser>(keyManifestationOwner)!);

    category =
        Category.fromParse(object.get<ParseObject>(keyManifestationCategory)!);
    city = City.fromParse(object.get<ParseObject>(keyManifestationCity)!);
    neighborhood = Neighborhood.fromParse(
        object.get<ParseObject>(keyManifestationNeighborhood)!);
    street = object.get<String>(keyManifestationStreet)!;
  }

  late List images;

  late String id;
  late String title;
  late String description;
  late String street;

  late Category category;
  late City city;
  late Neighborhood neighborhood;

  bool hidName = false;

  ManifestationStatus status = ManifestationStatus.ACTIVE;

  late DateTime createdAt;
  late User user;
}
