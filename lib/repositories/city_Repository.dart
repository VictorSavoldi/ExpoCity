import 'package:expocity/models/city.dart';
import 'package:expocity/models/neighborhood.dart';
import 'package:expocity/repositories/parse_errors.dart';
import 'package:expocity/repositories/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CityRepository {
  Future<List<City>> getCityList() async {
    final queryBuilder = QueryBuilder(ParseObject(keyCityTable))
      ..orderByAscending(keyCityName);

    final response = await queryBuilder.query();

    if (response.success) {
      return response.results!.map((p) => City.fromParse(p)).toList();
    } else {
      throw ParseErrors.getDescription(response.error!.code).toString();
    }
  }

  Future<List<Neighborhood>> getNeighborhoodList() async {
    City city = City(id: 'AO77GuzsYG', name: 'Bebedouro');

    final queryBuilder = QueryBuilder(ParseObject(keyNeighborhoodTable))
      ..whereContains(keyNeighborhoodCity, city.id)
      ..orderByAscending(keyNeighborhoodName);

    final response = await queryBuilder.query();

    if (response.success) {
      return response.results!.map((p) => Neighborhood.fromParse(p)).toList();
    } else {
      throw ParseErrors.getDescription(response.error!.code).toString();
    }
  }
}
