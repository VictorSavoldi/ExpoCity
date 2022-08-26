// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CityStore on _CityStore, Store {
  Computed<List<City>>? _$allCityListComputed;

  @override
  List<City> get allCityList =>
      (_$allCityListComputed ??= Computed<List<City>>(() => super.allCityList,
              name: '_CityStore.allCityList'))
          .value;
  Computed<List<Neighborhood>>? _$allNeighborhoodListComputed;

  @override
  List<Neighborhood> get allNeighborhoodList =>
      (_$allNeighborhoodListComputed ??= Computed<List<Neighborhood>>(
              () => super.allNeighborhoodList,
              name: '_CityStore.allNeighborhoodList'))
          .value;

  late final _$errorTextAtom =
      Atom(name: '_CityStore.errorText', context: context);

  @override
  String get errorText {
    _$errorTextAtom.reportRead();
    return super.errorText;
  }

  @override
  set errorText(String value) {
    _$errorTextAtom.reportWrite(value, super.errorText, () {
      super.errorText = value;
    });
  }

  late final _$_CityStoreActionController =
      ActionController(name: '_CityStore', context: context);

  @override
  void setError(String value) {
    final _$actionInfo =
        _$_CityStoreActionController.startAction(name: '_CityStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_CityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCities(List<City> cities) {
    final _$actionInfo =
        _$_CityStoreActionController.startAction(name: '_CityStore.setCities');
    try {
      return super.setCities(cities);
    } finally {
      _$_CityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNeighborhoods(List<Neighborhood> neighborhoods) {
    final _$actionInfo = _$_CityStoreActionController.startAction(
        name: '_CityStore.setNeighborhoods');
    try {
      return super.setNeighborhoods(neighborhoods);
    } finally {
      _$_CityStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorText: ${errorText},
allCityList: ${allCityList},
allNeighborhoodList: ${allNeighborhoodList}
    ''';
  }
}
