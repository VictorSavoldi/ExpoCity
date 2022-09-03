import 'package:expocity/components/colors.dart';
import 'package:expocity/screens/city/city_screen.dart';
import 'package:expocity/screens/filter/components/section_title.dart';
import 'package:expocity/stores/filter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CityFilterField extends StatelessWidget {
  const CityFilterField({Key? key, required this.filter}) : super(key: key);

  final FilterStore filter;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle(title: 'Cidade'),
        Observer(builder: (_) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: defaultColor),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              title: filter.city == null
                  ? const Text(
                      'Selecione',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.black38,
                        fontSize: 15,
                      ),
                    )
                  : Text(
                      filter.city!.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
              trailing: const Icon(Icons.keyboard_arrow_down),
              onTap: () async {
                final city = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CityScreen(
                      selected: filter.city,
                      showAll: false,
                    ),
                  ),
                );
                if (city != null) {
                  filter.setCity(city);
                }
              },
            ),
          );
        }),
      ],
    );
  }
}
