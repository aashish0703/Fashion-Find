import 'package:flutter/material.dart';

class CustomSnackBar {

  static void show(BuildContext context, String text, [SnackBarAction? action]) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(text, style: Theme.of(context).textTheme.bodyMedium),
            backgroundColor: const Color.fromRGBO(213, 172, 121, 1),
            behavior: SnackBarBehavior.floating,
            elevation: 30,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            action: action
        )
    );
  }
}