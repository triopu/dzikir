import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  final String caption;
  final Function() onTap;
  final String imageUrl;
  const OptionWidget({super.key, required this.caption, required this.onTap, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
            Image.asset(
              imageUrl,
              width: 100,
              height: 100,
            ),
            Text(
              caption,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto",
              ),
            )
          ]),
        ),
      ),
    );
  }
}
