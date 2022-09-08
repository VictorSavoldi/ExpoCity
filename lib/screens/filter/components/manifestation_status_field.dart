import 'package:bordered_text/bordered_text.dart';
import 'package:expocity/components/colors.dart';
import 'package:expocity/screens/filter/components/section_title.dart';
import 'package:expocity/stores/filter_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ManifestationStatusField extends StatelessWidget {
  ManifestationStatusField({Key? key, required this.filter}) : super(key: key);

  final FilterStore filter;

  @override
  Widget build(BuildContext context) {
    Widget buildOption(
        {required String title,
        required bool statusType,
        required void Function()? onTap}) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 139),
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: defaultColor),
            color: statusType ? defaultColor : filterButtonColor,
          ),
          child: statusType
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Status da Manifestação'),
        Observer(builder: (_) {
          return Wrap(
            runSpacing: 5,
            children: [
              buildOption(
                title: 'Ativa',
                statusType: filter.isStatusActive,
                onTap: () {
                  if (filter.isStatusActive) {
                    if (filter.isStatusResolved) {
                      filter.resetManifestationStatus(
                          MANIFESTATION_STATUS_ACTIVE);
                    } else {
                      filter.selectManifestationStatus(
                          MANIFESTATION_STATUS_RESOLVED);
                    }
                  } else {
                    filter.setManifestationStatus(MANIFESTATION_STATUS_ACTIVE);
                  }
                },
              ),
              const SizedBox(width: 10),
              buildOption(
                title: 'Resolvida',
                statusType: filter.isStatusResolved,
                onTap: () {
                  if (filter.isStatusResolved) {
                    if (filter.isStatusActive) {
                      filter.resetManifestationStatus(
                          MANIFESTATION_STATUS_RESOLVED);
                    } else {
                      filter.selectManifestationStatus(
                          MANIFESTATION_STATUS_ACTIVE);
                    }
                  } else {
                    filter
                        .setManifestationStatus(MANIFESTATION_STATUS_RESOLVED);
                  }
                },
              ),
            ],
          );
        }),
      ],
    );
  }
}
