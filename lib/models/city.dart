import 'package:expocity/repositories/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class City {
  City({required this.id, required this.name});

  City.fromParse(ParseObject parseObject)
      : id = parseObject.objectId!,
        name = parseObject.get(keyCityName);

  final String id;
  final String name;

  @override
  String toString() {
    return 'Category{id: $id, description: $name}';
  }
}
