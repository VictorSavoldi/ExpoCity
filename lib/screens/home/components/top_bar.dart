import 'package:expocity/components/colors.dart';
import 'package:expocity/screens/category/category_screen.dart';
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
      return Row(
        children: [
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
              color: Colors.grey[300],
              border: const Border(
                bottom: BorderSide(color: defaultColor, width: 1.5),
              ),
            ),
          ),
          BarButton(
            label: 'Filtros',
            onTap: () {},
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: const Border(
                bottom: BorderSide(color: defaultColor, width: 1.5),
                left: BorderSide(color: defaultColor, width: 1.5),
              ),
            ),
          ),
        ],
      );
    });
  }
}
