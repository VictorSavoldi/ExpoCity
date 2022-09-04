import 'package:expocity/components/colors.dart';
import 'package:expocity/components/custom_app_bar/custom_app_bar.dart';
import 'package:expocity/components/error_box.dart';
import 'package:expocity/models/city.dart';
import 'package:expocity/stores/city_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class CityScreen extends StatelessWidget {
  CityScreen({Key? key, this.showAll = true, required this.selected})
      : super(key: key);

  final City? selected;
  final bool showAll;

  final CityStore cityStore = GetIt.I<CityStore>();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      appBar: CustomAppBar(title: const Text('Cidades')),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Observer(builder: (_) {
                      if (cityStore.errorText.isNotEmpty) {
                        return ErrorBox(message: cityStore.errorText);
                      } else if (cityStore.citylist.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        final cities = showAll
                            ? cityStore.allCityList
                            : cityStore.citylist;

                        return Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: cities.length,
                            separatorBuilder: (_, __) {
                              return const Divider(
                                height: 0.2,
                                color: Colors.black26,
                              );
                            },
                            itemBuilder: (_, index) {
                              final city = cities[index];

                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).pop(city);
                                  node.unfocus();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  color: city.id == selected?.id
                                      ? transparentDefaultColor
                                      : null,
                                  child: Text(
                                    city.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: city.id == selected?.id
                                          ? Colors.grey[800]
                                          : Colors.grey[700],
                                      fontWeight: city.id == selected?.id
                                          ? FontWeight.bold
                                          : null,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
