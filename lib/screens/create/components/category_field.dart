import 'package:expocity/components/colors.dart';
import 'package:expocity/screens/category/category_screen.dart';
import 'package:expocity/stores/create_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CategoryField extends StatelessWidget {
  const CategoryField({Key? key, required this.createStore}) : super(key: key);

  final CreateStore createStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(builder: (_) {
          return Container(
            decoration: BoxDecoration(
              border: createStore.categoryError == null
                  ? Border.all(color: defaultColor)
                  : Border.all(color: flutterErrorColor),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              title: createStore.category == null
                  ? const Text(
                      'Categoria',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.black38,
                        fontSize: 15,
                      ),
                    )
                  : Text(
                      createStore.category!.description,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
              trailing: const Icon(Icons.keyboard_arrow_down),
              onTap: !createStore.loading
                  ? () async {
                      final category = await showDialog(
                        context: context,
                        builder: (_) => CategoryScreen(
                          showAll: false,
                          selected: createStore.category,
                        ),
                      );
                      if (category != null) {
                        createStore.setCategory(category);
                      }
                    }
                  : null,
            ),
          );
        }),
        Observer(builder: (_) {
          if (createStore.categoryError != null) {
            return Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      Text(
                        createStore.categoryError!,
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
