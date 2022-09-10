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

  @override
  String toString() {
    return '''
allManifestations: ${allManifestations},
activeManifestations: ${activeManifestations},
resolvedManifestations: ${resolvedManifestations}
    ''';
  }
}
