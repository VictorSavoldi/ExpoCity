import 'package:expocity/models/category.dart';
import 'package:expocity/repositories/parse_errors.dart';
import 'package:expocity/repositories/table_keys.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CategoryRepository {
  Future<List<Category>> getList() async {
    final queryBuilder = QueryBuilder(ParseObject(keyCategoryTable))
      ..orderByAscending(keyCategoryDescription);

    final response = await queryBuilder.query();

    if (response.success) {
      return response.results!.map((p) => Category.fromParse(p)).toList();
    } else {
      throw ParseErrors.getDescription(response.error!.code).toString();
    }
  }
}
