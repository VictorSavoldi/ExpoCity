import 'package:expocity/models/city.dart';
import 'package:expocity/models/neighborhood.dart';
import 'package:expocity/stores/home_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'filter_store.g.dart';

enum OrderBy { RECENT, OLD }

const MANIFESTATION_STATUS_ACTIVE = 1 << 0;
const MANIFESTATION_STATUS_RESOLVED = 1 << 1;

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  _FilterStore();

  _FilterStore.cloned({
    required this.orderBy,
    required this.manifestationStatus,
    required this.city,
    required this.neighborhood,
  });

  @observable
  OrderBy orderBy = OrderBy.RECENT;

  @observable
  int manifestationStatus = MANIFESTATION_STATUS_ACTIVE;

  @observable
  City? city;

  @observable
  Neighborhood? neighborhood;

  @action
  void setCity(City value) => city = value;

  @action
  void setNeighborhood(Neighborhood value) => neighborhood = value;

  @action
  void setOrderBy(OrderBy value) => orderBy = value;

  @action
  void selectManifestationStatus(int value) => manifestationStatus = value;

  @action
  void setManifestationStatus(int status) =>
      manifestationStatus = manifestationStatus | status;

  @action
  void resetManifestationStatus(int status) =>
      manifestationStatus = manifestationStatus & ~status;

  @computed
  bool get isStatusActive =>
      (manifestationStatus & MANIFESTATION_STATUS_ACTIVE) != 0;

  @computed
  bool get isStatusResolved =>
      (manifestationStatus & MANIFESTATION_STATUS_RESOLVED) != 0;

  void save() {
    GetIt.I<HomeStore>().setFilter(this as FilterStore);
  }

  FilterStore clone() {
    return FilterStore.cloned(
      orderBy: orderBy,
      manifestationStatus: manifestationStatus,
      city: city,
      neighborhood: neighborhood,
    );
  }
}
