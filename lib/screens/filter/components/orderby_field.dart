import 'package:bordered_text/bordered_text.dart';
import 'package:expocity/components/colors.dart';
import 'package:expocity/screens/filter/components/section_title.dart';
import 'package:expocity/stores/filter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class OrderByField extends StatelessWidget {
  const OrderByField({Key? key, required this.filter}) : super(key: key);

  final FilterStore filter;

  @override
  Widget build(BuildContext context) {
    Widget buildOption({required String title, required OrderBy option}) {
      return GestureDetector(
        onTap: () {
          filter.setOrderBy(option);
        },
        child: Container(
          constraints: const BoxConstraints(maxWidth: 139),
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: defaultColor),
            color: filter.orderBy == option ? defaultColor : filterButtonColor,
          ),
          child: filter.orderBy == option
              ? Text(
                  title,
                  style: (const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  )),
                )
              : BorderedText(
                  strokeWidth: 2.0,
                  strokeColor: Colors.grey[300]!,
                  child: Text(
                    title,
                    style: (const TextStyle(
                      color: defaultColor,
                      fontSize: 15,
                    )),
                  ),
                ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle(title: 'Ordernar por'),
        Observer(builder: (_) {
          return Wrap(
            runSpacing: 5,
            children: [
              buildOption(
                title: 'Mais Recente',
                option: OrderBy.RECENT,
              ),
              const SizedBox(width: 10),
              buildOption(
                title: 'Mais Antiga',
                option: OrderBy.OLD,
              ),
            ],
          );
        }),
      ],
    );
  }
}
