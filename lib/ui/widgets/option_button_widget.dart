import 'package:flutter/material.dart';

class OptionButtonWidget extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final bool visible;
  final IconData iconData;
  final Color iconDataColor;

  const OptionButtonWidget({
    super.key,
    required this.text,
    required this.backgroundColor,
    this.onTap,
    required this.visible,
    required this.iconData,
    this.iconDataColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
              if (visible) // Ensure this condition is correct for visibility
                Icon(
                  iconData, // Display the icon here
                  color: iconDataColor,
                  size: 32,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
