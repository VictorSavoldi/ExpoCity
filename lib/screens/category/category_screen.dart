import 'package:expocity/components/colors.dart';
import 'package:expocity/components/custom_app_bar/custom_app_bar.dart';
import 'package:expocity/components/error_box.dart';
import 'package:expocity/models/category.dart';
import 'package:expocity/stores/category_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key, this.showAll = true, required this.selected})
      : super(key: key);

  final Category? selected;
  final bool showAll;

  final CategoryStore categoryStore = GetIt.I<CategoryStore>();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      appBar: CustomAppBar(title: const Text('Categorias')),
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
            } else if (categoryStore.categoryList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final categories = showAll
                  ? categoryStore.allCategoryList
                  : categoryStore.categoryList;

              return ListView.separated(
                itemCount: categories.length,
                separatorBuilder: (_, __) {
                  return const Divider(
                    height: 0.2,
                    color: Colors.black26,
                  );
                },
                itemBuilder: (_, index) {
                  final category = categories[index];

                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pop(category);
                      node.unfocus();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      color: category.id == selected?.id
                          ? transparentDefaultColor
                          : null,
                      child: Text(
                        category.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: category.id == selected?.id
                              ? Colors.grey[800]
                              : Colors.grey[700],
                          fontWeight: category.id == selected?.id
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
