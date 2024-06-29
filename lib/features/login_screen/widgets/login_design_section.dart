import 'package:flutter/material.dart';
import 'package:team_app/core/constants.dart';

class LoginDesignSection extends StatelessWidget {
  const LoginDesignSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: .500,
          height: .80,
        ),
        // const CustomImage(
        //   image: AppAssets.logo,
        //   backgroundColor: Colors.transparent,
        // ),
        const SizedBox(height: 10),
        Text(
          'Welcome To alternative helper',
          style: TextStyle(
            color: AppConstants.yellowColor,
            fontSize: .27,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'helping you to find the best choice',
          style: TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
