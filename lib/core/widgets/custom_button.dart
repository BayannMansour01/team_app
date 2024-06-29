import 'package:flutter/material.dart';
import 'package:team_app/core/utils/size_config.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final double? width;
  final String text;
  final double? borderRadius;
  final Color? color;
  const CustomButton({
    super.key,
    this.onTap,
    this.width,
    required this.text,
    this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? SizeConfig.defaultSize * 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(26, 128, 223, 0.767),
            Color.fromARGB(255, 44, 52, 163)
          ],
        ),
      ),
      child: Material(
        color: const Color.fromRGBO(0, 0, 0, 0),
        shadowColor: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
          onTap: onTap,
          child: SizedBox(
            width: width ?? SizeConfig.defaultSize * 30,
            height: SizeConfig.defaultSize * 4,
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontSize: SizeConfig.defaultSize * 2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
