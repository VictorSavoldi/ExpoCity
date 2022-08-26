import 'package:expocity/models/category.dart';
import 'package:expocity/repositories/category_repository.dart';
import 'package:mobx/mobx.dart';

part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  _CategoryStore() {
    _loadCategories();
  }

  ObservableList<Category> categoryList = ObservableList<Category>();

  @observable
  String errorText = '';

  @action
  void setError(String value) => errorText = value;

  @action
  void setCategories(List<Category> categories) {
    categoryList.clear();
    categoryList.addAll(categories);
  }

  @computed
  List<Category> get allCategoryList => List.from(categoryList)
    ..insert(0, Category(id: '*', description: 'Todas'));

  Future<void> _loadCategories() async {
    try {
      final categories = await CategoryRepository().getList();

      setCategories(categories);
    } catch (e) {
      setError(e.toString());
    }
  }
}
