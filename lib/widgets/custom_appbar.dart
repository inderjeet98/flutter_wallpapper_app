import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(text: "Wallpaper", children: [
            TextSpan(text: "App"),
          ])),
    );
  }
}
