import 'package:expocity/models/category.dart';
import 'package:expocity/models/city.dart';
import 'package:expocity/models/manifestation.dart';
import 'package:expocity/models/neighborhood.dart';
import 'package:expocity/repositories/manifestation_repository.dart';
import 'package:expocity/stores/user_manager_store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'create_store.g.dart';

class CreateStore = _CreateStore with _$CreateStore;

abstract class _CreateStore with Store {
  ObservableList images = ObservableList();

  @observable
  Category? category;

  @observable
  String title = '';

  @observable
  City? city;

  @observable
  Neighborhood? neighborhood;

  @observable
  bool? hideName = false;

  @observable
  String description = '';

  @observable
  String street = '';

  @observable
  bool loading = false;

  @observable
  bool _required = false;

  @observable
  String errorText = '';

  @observable
  bool savedManifestation = false;

  @action
  void setTitle(String value) => title = value;
  void setDescription(String value) => description = value;
  void setStreet(String value) => street = value;
  void setHideName(bool? value) => hideName = value;
  void setNeighborhood(Neighborhood? value) => neighborhood = value;
  void setCity(City value) => city = value;
  void setCategory(Category value) => category = value;

  @computed
  bool get _imagesValid => images.isNotEmpty;
  bool get _titleValid => title.length >= 6;
  bool get _streetValid => street.isNotEmpty;
  bool get _descriptionValid => description.length >= 10;
  bool get _categoryValid => category != null;
  bool get _cityValid => city != null;
  bool get _neighborhoodValid => neighborhood != null;
  Future<void> Function()? get sendPressed => (!loading) ? _send : null;

  bool get _isformValid =>
      _imagesValid &&
      _titleValid &&
      _streetValid &&
      _descriptionValid &&
      _categoryValid &&
      _cityValid &&
      _neighborhoodValid;

  @computed
  String? get imagesError {
    if (!_imagesValid && _required) {
      return 'Insira pelo menos uma imagem';
    } else {
      return null;
    }
  }

  @computed
  String? get titleError {
    if (!_titleValid && title.isNotEmpty) {
      return 'Título muito curto';
    } else if (title.isEmpty && _required) {
      return 'Campo obrigatório';
    } else {
      return null;
    }
  }

  @computed
  String? get streetError {
    if (!_streetValid && _required) {
      return 'Campo obrigatório';
    } else {
      return null;
    }
  }

  @computed
  String? get descriptionError {
    if (!_descriptionValid && description.isNotEmpty) {
      return 'Descrição muito curta';
    } else if (description.isEmpty && _required) {
      return 'Campo obrigatório';
    } else {
      return null;
    }
  }

  @computed
  String? get categoryError {
    if (!_categoryValid && _required) {
      return 'Campo obrigatório';
    } else {
      return null;
    }
  }

  @computed
  String? get cityError {
    if (!_cityValid && _required) {
      return 'Campo obrigatório';
    } else {
      return null;
    }
  }

  @computed
  String? get neighborhoodError {
    if (!_neighborhoodValid && _required) {
      return 'Campo obrigatório';
    } else {
      return null;
    }
  }

  @action
  Future<void> _send() async {
    if (!_isformValid) {
      _required = true;
      return;
    }

    loading = true;

    try {
      final manifestation = Manifestation();

      manifestation.title = title;
      manifestation.description = description;
      manifestation.street = street;

      manifestation.category = category!;
      manifestation.city = city!;
      manifestation.neighborhood = neighborhood!;

      manifestation.hidName = hideName!;

      manifestation.images = images;
      manifestation.user = GetIt.I<UserManagerStore>().user!;

      await ManifestationRepository().save(manifestation);

      savedManifestation = true;

      errorText = '';

      loading = false;
    } catch (e) {
      errorText = e.toString();
    }
  }
}
