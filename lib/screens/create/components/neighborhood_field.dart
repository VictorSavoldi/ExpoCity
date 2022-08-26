import 'package:expocity/components/colors.dart';
import 'package:expocity/screens/city/neighborhood_screen.dart';
import 'package:expocity/stores/create_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NeighborhoodField extends StatelessWidget {
  const NeighborhoodField({Key? key, required this.createStore})
      : super(key: key);

  final CreateStore createStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(builder: (_) {
          return Container(
            decoration: BoxDecoration(
              border: createStore.neighborhoodError == null
                  ? Border.all(color: defaultColor)
                  : Border.all(color: flutterErrorColor),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              title: createStore.neighborhood == null
                  ? createStore.city != null
                      ? const Text(
                          'Bairro',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black38,
                            fontSize: 15,
                          ),
                        )
                      : const Text(
                          'Bairro (selecione a cidade)',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.black38,
                            fontSize: 15,
                          ),
                        )
                  : Text(
                      createStore.neighborhood!.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
              trailing: const Icon(Icons.keyboard_arrow_down),
              enabled: createStore.city != null,
              onTap: !createStore.loading
                  ? () async {
                      final neighborhood = await showDialog(
                        context: context,
                        builder: (_) => NeighborhoodScreen(
                          showAll: false,
                          selected: createStore.neighborhood,
                        ),
                      );
                      if (neighborhood != null) {
                        createStore.setNeighborhood(neighborhood);
                      }
                    }
                  : null,
            ),
          );
        }),
        Observer(builder: (_) {
          if (createStore.neighborhoodError != null) {
            return Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      Text(
                        createStore.neighborhoodError!,
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
