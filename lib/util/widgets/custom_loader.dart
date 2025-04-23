import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key, required this.opacity, required this.dismissible, required this.color, required this.loadingTxt});

  final double opacity;
  final bool dismissible;
  final Color color;
  final String loadingTxt;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: opacity,
          child: ModalBarrier(dismissible: dismissible, color: color),
        ),
        Center(
          child: Text(loadingTxt, style: const TextStyle(color: Colors.white, fontSize: 15),),
        )
      ],
    );
  }
}
