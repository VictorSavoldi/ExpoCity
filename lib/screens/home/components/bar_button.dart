import 'package:bordered_text/bordered_text.dart';
import 'package:expocity/components/colors.dart';
import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  const BarButton(
      {Key? key,
      required this.decoration,
      required this.label,
      required this.onTap})
      : super(key: key);

  final BoxDecoration decoration;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          decoration: decoration,
          height: 55,
          child: BorderedText(
            strokeWidth: 2.0,
            strokeColor: Colors.grey[300]!,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: defaultColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
