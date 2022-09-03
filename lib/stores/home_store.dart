import 'package:expocity/models/category.dart';
import 'package:expocity/repositories/manifestation_repository.dart';
import 'package:expocity/stores/filter_store.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore() {
    autorun((_) async {
      final newManifestations =
          await ManifestationRepository().getHomeManifestationList(
        filter: filter,
        search: search,
        category: category,
      );
      print(newManifestations);
    });
  }

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
  void setFilter(FilterStore value) => filter = value;
}
