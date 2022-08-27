import 'package:expocity/models/category.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  String search = '';

  @observable
  Category? category;

  @action
  void setSearch(String value) => search = value;
  void setCategory(Category value) => category = value;
}
