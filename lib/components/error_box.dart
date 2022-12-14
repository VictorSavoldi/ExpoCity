import 'package:flutter/material.dart';

import 'colors.dart';

class ErrorBox extends StatelessWidget {
  const ErrorBox({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    if (message.isEmpty) {
      return Container();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: errorColor,
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
