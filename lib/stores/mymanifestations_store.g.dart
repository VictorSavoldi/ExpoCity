// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mymanifestations_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MymanifestationsStore on _MymanifestationsStore, Store {
  Computed<List<Manifestation>>? _$activeManifestationsComputed;

  @override
  List<Manifestation> get activeManifestations =>
      (_$activeManifestationsComputed ??= Computed<List<Manifestation>>(
              () => super.activeManifestations,
              name: '_MymanifestationsStore.activeManifestations'))
          .value;
  Computed<List<Manifestation>>? _$resolvedManifestationsComputed;

  @override
  List<Manifestation> get resolvedManifestations =>
      (_$resolvedManifestationsComputed ??= Computed<List<Manifestation>>(
              () => super.resolvedManifestations,
              name: '_MymanifestationsStore.resolvedManifestations'))
          .value;
  Computed<List<Manifestation>>? _$pendingManifestationsComputed;

  @override
  List<Manifestation> get pendingManifestations =>
      (_$pendingManifestationsComputed ??= Computed<List<Manifestation>>(
              () => super.pendingManifestations,
              name: '_MymanifestationsStore.pendingManifestations'))
          .value;

  late final _$loadingAtom =
      Atom(name: '_MymanifestationsStore.loading', context: context);

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
      Atom(name: '_MymanifestationsStore.allManifestations', context: context);

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

  late final _$resolveManifestationAsyncAction = AsyncAction(
      '_MymanifestationsStore.resolveManifestation',
      context: context);

  @override
  Future<void> resolveManifestation({required Manifestation manifestation}) {
    return _$resolveManifestationAsyncAction
        .run(() => super.resolveManifestation(manifestation: manifestation));
  }

  late final _$activeManifestationAsyncAction = AsyncAction(
      '_MymanifestationsStore.activeManifestation',
      context: context);

  @override
  Future<void> activeManifestation({required Manifestation manifestation}) {
    return _$activeManifestationAsyncAction
        .run(() => super.activeManifestation(manifestation: manifestation));
  }

  late final _$deleteManifestationAsyncAction = AsyncAction(
      '_MymanifestationsStore.deleteManifestation',
      context: context);

  @override
  Future<void> deleteManifestation({required Manifestation manifestation}) {
    return _$deleteManifestationAsyncAction
        .run(() => super.deleteManifestation(manifestation: manifestation));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
allManifestations: ${allManifestations},
activeManifestations: ${activeManifestations},
resolvedManifestations: ${resolvedManifestations},
pendingManifestations: ${pendingManifestations}
    ''';
  }
}
