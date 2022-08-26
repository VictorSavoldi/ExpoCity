import 'package:expocity/components/colors.dart';
import 'package:expocity/screens/city/city_screen.dart';
import 'package:expocity/stores/create_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CityField extends StatelessWidget {
  const CityField({Key? key, required this.createStore}) : super(key: key);

  final CreateStore createStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(builder: (_) {
          return Container(
            decoration: BoxDecoration(
              border: createStore.cityError == null
                  ? Border.all(color: defaultColor)
                  : Border.all(color: flutterErrorColor),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              title: createStore.city == null
                  ? const Text(
                      'Cidade',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.black38,
                        fontSize: 15,
                      ),
                    )
                  : Text(
                      createStore.city!.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
              trailing: const Icon(Icons.keyboard_arrow_down),
              onTap: !createStore.loading
                  ? () async {
                      final city = await showDialog(
                        context: context,
                        builder: (_) => CityScreen(
                          showAll: false,
                          selected: createStore.city,
                        ),
                      );
                      if (city != null) {
                        createStore.setCity(city);
                      }
                    }
                  : null,
            ),
          );
        }),
        Observer(builder: (_) {
          if (createStore.cityError != null) {
            return Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      Text(
                        createStore.cityError!,
                        style: const TextStyle(
                            color: flutterErrorColor, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        }),
      ],
    );
  }
}
