import 'package:expocity/models/category.dart';
import 'package:expocity/stores/filter_store.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  String search = '';

  @observable
  Category? category;

  @observable
  FilterStore filter = FilterStore();

  FilterStore get clonedFilter => filter.clone();

  @action
  void setSearch(String value) => search = value;
  void setCategory(Category value) => category = value;

  @action
  void setFilter(FilterStore value) => filter = value;
}
