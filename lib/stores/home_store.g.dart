// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$searchAtom = Atom(name: '_HomeStore.search', context: context);

  @override
  String get search {
    _$searchAtom.reportRead();
    return super.search;
  }

  @override
  set search(String value) {
    _$searchAtom.reportWrite(value, super.search, () {
      super.search = value;
    });
  }

  late final _$categoryAtom =
      Atom(name: '_HomeStore.category', context: context);

  @override
  Category? get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(Category? value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  late final _$_HomeStoreActionController =
      ActionController(name: '_HomeStore', context: context);

  @override
  void setSearch(String value) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.setSearch');
    try {
      return super.setSearch(value);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
search: ${search},
category: ${category}
    ''';
  }
}