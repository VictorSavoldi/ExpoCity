import 'package:expocity/repositories/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Neighborhood {
  Neighborhood({required this.id, required this.name});

  Neighborhood.fromParse(ParseObject parseObject)
      : id = parseObject.objectId!,
        name = parseObject.get(keyNeighborhoodName);

  final String id;
  final String name;

  @override
  String toString() {
    return 'Neighborhood{id: $id, name: $name}';
  }
}
