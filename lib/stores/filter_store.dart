import 'package:mobx/mobx.dart';

part 'filter_store.g.dart';

enum OrderBy { RECENT, OLD }

const MANIFESTATION_STATUS_ACTIVE = 1 << 0;
const MANIFESTATION_STATUS_RESOLVED = 1 << 1;

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  @observable
  OrderBy orderBy = OrderBy.RECENT;

  @observable
  int manifestationStatus = MANIFESTATION_STATUS_ACTIVE;

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
}
