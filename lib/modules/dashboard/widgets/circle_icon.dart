import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double size;
  final Color borderColor;
  final Color backgroundColor;
  final double borderWidth;

  const CircleIconButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.size = 40,
    this.borderColor = const Color(0xFFE5E7EB), // example neutral
    this.backgroundColor = Colors.white,
    this.borderWidth = .8,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // keep parent background
      child: InkWell(
        onTap: onPressed,
        customBorder: CircleBorder(),
        borderRadius: BorderRadius.circular(size / 2),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: borderWidth),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
