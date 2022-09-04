// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FilterStore on _FilterStore, Store {
  Computed<bool>? _$isStatusActiveComputed;

  @override
  bool get isStatusActive =>
      (_$isStatusActiveComputed ??= Computed<bool>(() => super.isStatusActive,
              name: '_FilterStore.isStatusActive'))
          .value;

  late final _$orderByAtom =
      Atom(name: '_FilterStore.orderBy', context: context);

  @override
  OrderBy get orderBy {
    _$orderByAtom.reportRead();
    return super.orderBy;
  }

  @override
  set orderBy(OrderBy value) {
    _$orderByAtom.reportWrite(value, super.orderBy, () {
      super.orderBy = value;
    });
  }

  late final _$manifestationStatusAtom =
      Atom(name: '_FilterStore.manifestationStatus', context: context);

  @override
  int get manifestationStatus {
    _$manifestationStatusAtom.reportRead();
    return super.manifestationStatus;
  }

  @override
  set manifestationStatus(int value) {
    _$manifestationStatusAtom.reportWrite(value, super.manifestationStatus, () {
      super.manifestationStatus = value;
    });
  }

  late final _$cityAtom = Atom(name: '_FilterStore.city', context: context);

  @override
  City? get city {
    _$cityAtom.reportRead();
    return super.city;
  }

  @override
  set city(City? value) {
    _$cityAtom.reportWrite(value, super.city, () {
      super.city = value;
    });
  }

  late final _$neighborhoodAtom =
      Atom(name: '_FilterStore.neighborhood', context: context);

  @override
  Neighborhood? get neighborhood {
    _$neighborhoodAtom.reportRead();
    return super.neighborhood;
  }

  @override
  set neighborhood(Neighborhood? value) {
    _$neighborhoodAtom.reportWrite(value, super.neighborhood, () {
      super.neighborhood = value;
    });
  }

  late final _$_FilterStoreActionController =
      ActionController(name: '_FilterStore', context: context);

  @override
  void setCity(City value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setCity');
    try {
      return super.setCity(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
orderBy: ${orderBy},
manifestationStatus: ${manifestationStatus},
city: ${city},
neighborhood: ${neighborhood},
isStatusActive: ${isStatusActive}
    ''';
  }
}
