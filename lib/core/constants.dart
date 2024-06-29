import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

abstract class AppConstants {
  // static const String ip = "192.168.105.95";
  static const String ip = "192.168.43.50";
  static const String baseUrl = 'http://${ip}:8000/api/';
  static const String register = 'auth/register';
  static const String login = 'auth/login';
  static const String logout = 'auth/logout';
  static const String me = 'auth/me';
  static const String getAllProposedSystem = 'ProposedSystem/showAll';
  static const String showAllPrevJobs = 'PreviousJobs/showAll';
  static const String searchByTitlePrevJobs = 'PreviousJobs/searchByTitle';
  static const String showDetailesPrevJobs = 'PreviousJobs/show';
  static const String showAllProducts = 'Products/showAll';
  static const String searchProductById = 'Products/search';
  static const String detailesProduct = 'Products/show';
  static const String fetchApointemnt = 'appointments/teamApp/';

  static const String fetchAllProduct = 'Products/showAll';
  static const String fetchAllRecords = "records/showAll";
  static const String makeComplete = 'appointments/done/';
  static const Color backgroundColor = Color.fromRGBO(24, 24, 32, 1);
  static const Color whiteColor = Colors.white;

  // static Color blueColor = hexToColor('#044586');
  static const blueColor = Color(0xff044586); //rgba(4, 69, 134, 1)
  static const orangeColor = Color(0xfff39709);
  static const yellowColor = Color(0xfffee205);
  //static Color blueColorColor = colorFromHex(blueColor as String);
  static Color colorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  static Color hexToColor(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor =
          "FF" + hexColor; // 8-char with full opacity if only 6-char provided
    }
    return Color.fromRGBO(
      int.parse(hexColor.substring(2, 4), radix: 16),
      int.parse(hexColor.substring(4, 6), radix: 16),
      int.parse(hexColor.substring(6, 8), radix: 16),
      int.parse(hexColor.substring(0, 2), radix: 16) / 255.0,
    );
  }
}
