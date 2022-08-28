import 'package:expocity/components/custom_app_bar/custom_app_bar.dart';
import 'package:expocity/components/custom_buttons/custom_elevated_button.dart';
import 'package:expocity/screens/filter/components/manifestation_status_field.dart';
import 'package:expocity/screens/filter/components/orderby_field.dart';
import 'package:expocity/stores/filter_store.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({Key? key}) : super(key: key);

  final FilterStore filter = FilterStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: const Text('Filtrar Busca')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(32),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OrderByField(filter: filter),
                ManifestationStatusField(filter: filter),
                const SizedBox(height: 10),
                const Divider(color: Colors.black54),
                CustomElevatedButton(
                  edgeInsets: const EdgeInsets.only(top: 10),
                  onPressed: null,
                  containerActionButton: Container(
                    alignment: Alignment.center,
                    child: const Text('FILTRAR'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
