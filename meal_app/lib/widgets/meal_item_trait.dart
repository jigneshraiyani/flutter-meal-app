import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({super.key, required this.iconData, required this.lable});

  final IconData iconData;
  final String lable;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Icon(
          iconData,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(width: 6),
        Text(
          lable,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
