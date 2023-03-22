import 'package:flutter/material.dart';
import 'package:waiter_app/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const AppIcon({
    Key? key,
    required this.icon,
    this.backgroundColor = const Color(0xFFfcf4e4),
    this.iconColor = const Color(0xFF756d54),
    this.size = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size == 0 ? Dimensions.width40 : size,
      height: size == 0 ? Dimensions.width40 : size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius:
            BorderRadius.circular((size == 0 ? Dimensions.width40 : size) / 2),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: Dimensions.icon16,
      ),
    );
  }
}
