import 'package:flutter/material.dart';

import '../utils/global_variables.dart';

class GenderCard extends StatelessWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onTap;
  final bool isSelected;

  const GenderCard({
    Key? key,
    required this.text,
    required this.iconData,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        height: size.height * 0.1,
        width: size.width * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.black12 : Colors.transparent,
        ),
        child: Column(
          children: [
            Icon(
              iconData,
              color: blueColor,
              size: 26,
            ),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? blueColor : Colors.black,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
