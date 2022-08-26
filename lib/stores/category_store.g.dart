// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoryStore on _CategoryStore, Store {
  Computed<List<Category>>? _$allCategoryListComputed;

  @override
  List<Category> get allCategoryList => (_$allCategoryListComputed ??=
          Computed<List<Category>>(() => super.allCategoryList,
              name: '_CategoryStore.allCategoryList'))
      .value;

  late final _$errorTextAtom =
      Atom(name: '_CategoryStore.errorText', context: context);

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

  late final _$_CategoryStoreActionController =
      ActionController(name: '_CategoryStore', context: context);

  @override
  void setError(String value) {
    final _$actionInfo = _$_CategoryStoreActionController.startAction(
        name: '_CategoryStore.setError');
    try {
      return super.setError(value);
    } finally {
      _$_CategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCategories(List<Category> categories) {
    final _$actionInfo = _$_CategoryStoreActionController.startAction(
        name: '_CategoryStore.setCategories');
    try {
      return super.setCategories(categories);
    } finally {
      _$_CategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorText: ${errorText},
allCategoryList: ${allCategoryList}
    ''';
  }
}
