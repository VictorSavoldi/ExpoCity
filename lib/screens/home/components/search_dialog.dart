import 'package:expocity/components/colors.dart';
import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {
  SearchDialog({Key? key, required this.currentSearch})
      : controller = TextEditingController(text: currentSearch),
        super(key: key);

  final String? currentSearch;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 2,
          left: 2,
          right: 2,
          child: Card(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                isDense: true,
                border: InputBorder.none,
                prefixIcon: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: Navigator.of(context).pop,
                  color: defaultColor,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: controller.clear,
                  color: defaultColor,
                ),
              ),
              autofocus: true,
              textInputAction: TextInputAction.search,
              onSubmitted: (text) {
                Navigator.of(context).pop(text);
              },
            ),
          ),
        )
      ],
    );
  }
}
