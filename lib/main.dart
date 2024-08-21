import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_app/core/constants.dart';
import 'package:team_app/core/utils/app_router.dart';
import 'package:team_app/core/utils/cache_helper.dart';
import 'package:team_app/core/utils/dio_helper.dart';
import 'package:team_app/core/utils/service_locator.dart';
import 'package:team_app/core/utils/size_config.dart';
import 'package:team_app/firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  DioHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  CacheHelper.init();
  runApp(TeamApp());
}

class TeamApp extends StatelessWidget {
  const TeamApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColorLight: AppConstants.blueColor,
        primaryColor: AppConstants.blueColor,
        colorScheme: ColorScheme.fromSeed(seedColor: AppConstants.blueColor),
        primaryColorDark: AppConstants.blueColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: AppConstants.blueColor,
            selectedIconTheme: IconThemeData(size: 30)),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          actionsIconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppConstants.blueColor,
        ),
        scaffoldBackgroundColor: AppConstants.whiteColor,
        textTheme: GoogleFonts.notoKufiArabicTextTheme(
                Theme.of(context).textTheme.copyWith())
            .apply(
          bodyColor: Colors.black,
        ),
      ),
      routerConfig: AppRouter.router,
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}
