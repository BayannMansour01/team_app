import 'package:team_app/core/constants.dart';
import 'package:flutter/material.dart';

class CustomDrawerButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? iconColor;
  final void Function() onPressed;
  final double? fontSize;
  const CustomDrawerButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.iconColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        fixedSize: Size(220, 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Icon(
            icon,
            size: 25,
            color: iconColor ?? AppConstants.blueColor,
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize ?? 20,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
