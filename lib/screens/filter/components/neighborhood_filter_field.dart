import 'package:expocity/components/colors.dart';
import 'package:expocity/screens/city/neighborhood_screen.dart';
import 'package:expocity/screens/filter/components/section_title.dart';
import 'package:expocity/stores/filter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NeighborhoodFilterField extends StatelessWidget {
  const NeighborhoodFilterField({Key? key, required this.filter})
      : super(key: key);

  final FilterStore filter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle(title: 'Bairro'),
        Observer(builder: (_) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: defaultColor),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              title: filter.neighborhood == null
                  ? filter.city != null
                      ? const Text(
                          'Selecione o bairro',
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
                      filter.neighborhood!.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
              trailing: const Icon(Icons.keyboard_arrow_down),
              enabled: filter.city != null,
              onTap: () async {
                final neighborhood = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => NeighborhoodScreen(
                      selected: filter.neighborhood,
                      showAll: true,
                    ),
                  ),
                );
                if (neighborhood != null) {
                  filter.setNeighborhood(neighborhood);
                }
              },
            ),
          );
        }),
      ],
    );
  }
}
