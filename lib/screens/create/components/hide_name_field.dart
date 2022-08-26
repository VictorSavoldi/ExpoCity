import 'package:expocity/components/colors.dart';
import 'package:expocity/stores/create_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HideNameField extends StatelessWidget {
  const HideNameField({Key? key, required this.createStore}) : super(key: key);

  final CreateStore createStore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Observer(
          builder: (_) {
            return Checkbox(
              activeColor: defaultColor,
              value: createStore.hideName,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              onChanged: !createStore.loading ? createStore.setHideName : null,
            );
          },
        ),
        const Text(
          'Manifestação anônima',
          style: TextStyle(
              fontSize: 16, color: defaultColor, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 20)
      ],
    );
  }
}
