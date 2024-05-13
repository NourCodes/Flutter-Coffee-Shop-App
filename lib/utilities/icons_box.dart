import 'package:flutter/material.dart';

class IconsBox extends StatelessWidget {
  final String text;
  final String image;
  const IconsBox({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Image.asset(
            image,
            color: Colors.white,
            height: 20,
            width: 30,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 8),
          )
        ],
      ),
    );
  }
}
