import 'package:expocity/models/category.dart';
import 'package:expocity/models/manifestation.dart';
import 'package:expocity/repositories/manifestation_repository.dart';
import 'package:expocity/stores/filter_store.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore() {
    autorun((_) async {
      try {
        setLoading(true);
        final newManifestations = await ManifestationRepository()
            .getHomeManifestationList(
                filter: filter, search: search, category: category, page: page);
        addNewManifestation(newManifestations);
        setError('');
        setLoading(false);
      } catch (e) {
        setError(e.toString());
      }
    });
  }

  ObservableList<Manifestation> manifestationList =
      ObservableList<Manifestation>();

  @observable
  String errorText = '';

  @observable
  bool loading = false;

  @observable
  String search = '';

  @observable
  Category? category;

  @observable
  FilterStore filter = FilterStore();

  @observable
  int page = 0;

  @observable
  bool lastPage = false;

  FilterStore get clonedFilter => filter.clone();

  @action
  void setSearch(String value) {
    search = value;
    resetPage();
  }

  @action
  void setCategory(Category value) {
    category = value;
    resetPage();
  }

  @action
  void setFilter(FilterStore value) {
    filter = value;
    resetPage();
  }

  @action
  void loadNextPage() {
    page++;
  }

  @action
  void addNewManifestation(List<Manifestation> newManifestation) {
    if (newManifestation.length < 20) {
      lastPage = true;
    }
    manifestationList.addAll(newManifestation);
  }

  @action
  void setError(String value) => errorText = value;
  void setLoading(bool value) => loading = value;

  @computed
  int get itemCount =>
      lastPage ? manifestationList.length : manifestationList.length + 1;

  void resetPage() {
    page = 0;
    manifestationList.clear();
    lastPage = false;
  }

  @computed
  bool get showProgress => loading && manifestationList.isEmpty;
}
