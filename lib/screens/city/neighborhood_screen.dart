import 'package:expocity/components/colors.dart';
import 'package:expocity/components/custom_app_bar/custom_app_bar.dart';
import 'package:expocity/components/error_box.dart';
import 'package:expocity/models/neighborhood.dart';
import 'package:expocity/stores/city_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class NeighborhoodScreen extends StatelessWidget {
  NeighborhoodScreen({Key? key, this.showAll = true, required this.selected})
      : super(key: key);

  final Neighborhood? selected;
  final bool showAll;

  final CityStore categoryStore = GetIt.I<CityStore>();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      appBar: CustomAppBar(title: const Text('Bairros')),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          margin: const EdgeInsets.all(32),
          clipBehavior: Clip.antiAlias,
          child: Observer(builder: (_) {
            if (categoryStore.errorText.isNotEmpty) {
              return ErrorBox(message: categoryStore.errorText);
            } else if (categoryStore.neighborhoodList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final neighborhoods = showAll
                  ? categoryStore.allNeighborhoodList
                  : categoryStore.neighborhoodList;

              return ListView.separated(
                itemCount: neighborhoods.length,
                separatorBuilder: (_, __) {
                  return const Divider(
                    height: 0.2,
                    color: Colors.black26,
                  );
                },
                itemBuilder: (_, index) {
                  final neighborhood = neighborhoods[index];

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pop(neighborhood);
                      node.unfocus();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      color: neighborhood.id == selected?.id
                          ? transparentDefaultColor
                          : null,
                      child: Text(
                        neighborhood.name,
                        style: TextStyle(
                          fontSize: 16,
                          color: neighborhood.id == selected?.id
                              ? Colors.grey[800]
                              : Colors.grey[700],
                          fontWeight: neighborhood.id == selected?.id
                              ? FontWeight.bold
                              : null,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
        ),
      ),
    );
  }
}
