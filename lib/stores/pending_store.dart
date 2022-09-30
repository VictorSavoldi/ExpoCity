import 'package:mobx/mobx.dart';

import '../models/manifestation.dart';
import '../repositories/manifestation_repository.dart';

part 'pending_store.g.dart';

class PendingStore = _PendingStore with _$PendingStore;

abstract class _PendingStore with Store {
  @observable
  bool loading = false;

  @observable
  List<Manifestation> allManifestations = [];

  Future<void> _getAllPendingManifestations() async {
    try {
      loading = true;

      allManifestations = await ManifestationRepository().getAllPendingManifestations();

      loading = false;
    } catch (e) {}
  }

  void refresh() => _getAllPendingManifestations();

  @action
  Future<void> resolveManifestation({required Manifestation manifestation}) async {
    loading = true;

    await ManifestationRepository().resolve(manifestation);

    loading = false;
  }

  @action
  Future<void> activeManifestation({required Manifestation manifestation}) async {
    loading = true;

    await ManifestationRepository().active(manifestation);

    loading = false;
  }

  @action
  Future<void> deleteManifestation({required Manifestation manifestation}) async {
    loading = true;

    await ManifestationRepository().delete(manifestation);

    loading = false;
  }
}
