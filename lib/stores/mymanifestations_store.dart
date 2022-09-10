import 'package:expocity/models/manifestation.dart';
import 'package:expocity/repositories/manifestation_repository.dart';
import 'package:expocity/stores/user_manager_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'mymanifestations_store.g.dart';

class MymanifestationsStore = _MymanifestationsStore
    with _$MymanifestationsStore;

abstract class _MymanifestationsStore with Store {
  _MymanifestationsStore() {
    _getMyManifestations();
  }

  @observable
  List<Manifestation> allManifestations = [];

  @computed
  List<Manifestation> get activeManifestations => allManifestations
      .where(
          (manifestation) => manifestation.status == ManifestationStatus.ACTIVE)
      .toList();

  @computed
  List<Manifestation> get resolvedManifestations => allManifestations
      .where((manifestation) =>
          manifestation.status == ManifestationStatus.RESOLVED)
      .toList();

  Future<void> _getMyManifestations() async {
    final user = GetIt.I<UserManagerStore>().user;

    try {
      allManifestations =
          await ManifestationRepository().getMyManifestations(user!);
    } catch (e) {}
  }
}
