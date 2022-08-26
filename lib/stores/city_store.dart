import 'package:expocity/models/city.dart';
import 'package:expocity/models/neighborhood.dart';
import 'package:expocity/repositories/city_Repository.dart';
import 'package:mobx/mobx.dart';

part 'city_store.g.dart';

class CityStore = _CityStore with _$CityStore;

abstract class _CityStore with Store {
  _CityStore() {
    _loadCities();
    _loadNeighborhoods();
  }

  ObservableList<City> citylist = ObservableList<City>();

  ObservableList<Neighborhood> neighborhoodList =
      ObservableList<Neighborhood>();

  @observable
  String errorText = '';

  @action
  void setError(String value) => errorText = value;

  @action
  void setCities(List<City> cities) {
    citylist.clear();
    citylist.addAll(cities);
  }

  @action
  void setNeighborhoods(List<Neighborhood> neighborhoods) {
    neighborhoodList.clear();
    neighborhoodList.addAll(neighborhoods);
  }

  @computed
  List<City> get allCityList =>
      List.from(citylist)..insert(0, City(id: '*', name: 'Todas'));

  Future<void> _loadCities() async {
    try {
      final cities = await CityRepository().getCityList();

      setCities(cities);
    } catch (e) {
      setError(e.toString());
    }
  }

  @computed
  List<Neighborhood> get allNeighborhoodList => List.from(neighborhoodList)
    ..insert(0, Neighborhood(id: '*', name: 'Todos'));

  Future<void> _loadNeighborhoods() async {
    try {
      final neighborhoods = await CityRepository().getNeighborhoodList();

      setNeighborhoods(neighborhoods);
    } catch (e) {
      setError(e.toString());
    }
  }
}
