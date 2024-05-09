import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final Color backgroundColor;
  final Function() onPressed;
  final IconData? icon;
  final String? caption;
  const CircularButton({
    super.key,
    required this.backgroundColor,
    required this.onPressed,
    this.icon,
    this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Builder(builder: (context) {
          if (icon != null) {
            return Icon(
              icon,
              color: Colors.white,
            );
          }
          return Text(
            caption ?? "",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              fontFamily: "Roboto",
            ),
          );
        }),
      ),
    );
  }
}
