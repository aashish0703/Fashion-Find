import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.width,
    required this.text,
  });

  final VoidCallback onTap;
  final double width;
  final String text;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(213, 172, 121, 1),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge
        ),
      ),
    );
  }
}