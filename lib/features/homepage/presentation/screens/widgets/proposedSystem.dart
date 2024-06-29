import 'package:team_app/core/constants.dart';
import 'package:flutter/material.dart';

Widget ReadyMadeSystemItem(
  BuildContext context,
) {
  //Product product = productList[index];
  return SizedBox(
    width: 200,
    height: 200,
    child: Card(
      color: AppConstants.orangeColor.withOpacity(0.9),
      elevation: 12,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Column(
          children: [
            Image.asset(
              'assets/images/LOGO.jpg',
              fit: BoxFit.cover,
              // width: 150,
              // height: 150,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "{proposedSystem.name}",
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              "{proposedSystem.desc}",
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    ),
  );
}
