import 'package:expocity/components/colors.dart';
import 'package:expocity/screens/category/category_screen.dart';
import 'package:expocity/screens/filter/filter_screen.dart';
import 'package:expocity/screens/home/components/bar_button.dart';
import 'package:expocity/stores/home_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class TopBar extends StatelessWidget {
  TopBar({Key? key}) : super(key: key);

  final HomeStore homeStore = GetIt.I<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            const SizedBox(width: 10),
            BarButton(
              label: homeStore.category?.description ?? 'Categorias',
              onTap: () async {
                final category = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CategoryScreen(
                      selected: homeStore.category,
                      showAll: true,
                    ),
                  ),
                );
                if (category != null) {
                  homeStore.setCategory(category);
                }
              },
              decoration: BoxDecoration(
                color: filterButtonColor,
                border: Border.all(color: defaultColor, width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 10),
            BarButton(
              label: 'Filtros',
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => FilterScreen()));
              },
              decoration: BoxDecoration(
                color: filterButtonColor,
                border: Border.all(color: defaultColor, width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
      );
    });
  }
}
