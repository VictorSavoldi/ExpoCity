// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PendingStore on _PendingStore, Store {
  late final _$loadingAtom =
      Atom(name: '_PendingStore.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$allManifestationsAtom =
      Atom(name: '_PendingStore.allManifestations', context: context);

  @override
  List<Manifestation> get allManifestations {
    _$allManifestationsAtom.reportRead();
    return super.allManifestations;
  }

  @override
  set allManifestations(List<Manifestation> value) {
    _$allManifestationsAtom.reportWrite(value, super.allManifestations, () {
      super.allManifestations = value;
    });
  }

  late final _$resolveManifestationAsyncAction =
      AsyncAction('_PendingStore.resolveManifestation', context: context);

  @override
  Future<void> resolveManifestation({required Manifestation manifestation}) {
    return _$resolveManifestationAsyncAction
        .run(() => super.resolveManifestation(manifestation: manifestation));
  }

  late final _$activeManifestationAsyncAction =
      AsyncAction('_PendingStore.activeManifestation', context: context);

  @override
  Future<void> activeManifestation({required Manifestation manifestation}) {
    return _$activeManifestationAsyncAction
        .run(() => super.activeManifestation(manifestation: manifestation));
  }

  late final _$deleteManifestationAsyncAction =
      AsyncAction('_PendingStore.deleteManifestation', context: context);

  @override
  Future<void> deleteManifestation({required Manifestation manifestation}) {
    return _$deleteManifestationAsyncAction
        .run(() => super.deleteManifestation(manifestation: manifestation));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
allManifestations: ${allManifestations}
    ''';
  }
}
