import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:team_app/core/constants.dart';
import 'package:team_app/core/utils/cache_helper.dart';
import 'package:team_app/core/utils/size_config.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/chat_screen.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/conversations_screen.dart';
import 'package:team_app/features/homepage/data/models/product_model.dart';
import 'package:team_app/features/homepage/data/models/products_update_body.dart';
import 'package:team_app/features/RecordsScreen/data/models/record_model.dart';
import 'package:team_app/features/homepage/data/models/user_model.dart';
import 'package:team_app/features/homepage/data/repos/home_repo.dart';
import 'package:team_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:team_app/features/homepage/presentation/screens/home_page.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class homepageCubit extends Cubit<homepageState> {
  homepageCubit(this.Repo) : super(homepageInitial());
  bool listining = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int bottomNavigationBarIndex = 1;
  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: 'المحادثات',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.home),
      label: 'الرئيسية',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.archive),
      label: 'السجلات ',
    ),
  ];

  List<Widget> get listOfIcons {
    return [
      Icon(
        Icons.message,
        size: SizeConfig.screenWidth * .076, // تصغير حجم الأيقونات
        color: bottomNavigationBarIndex == 0
            ? AppConstants.blueColor
            : Colors.black26,
      ),
      Icon(
        FontAwesomeIcons.home,
        size: SizeConfig.screenWidth * .076, // تصغير حجم الأيقونات
        color: bottomNavigationBarIndex == 1
            ? AppConstants.blueColor
            : Colors.black26,
      ),
      Icon(
        FontAwesomeIcons.archive,
        size: SizeConfig.screenWidth * .076, // تصغير حجم الأيقونات
        color: bottomNavigationBarIndex == 2
            ? AppConstants.blueColor
            : Colors.black26,
      ),
    ];
  }

  List<String> listOfStrings = [
    'المحادثات',
    'الرئيسية',
    'السجلات',
  ];

  void changeBottomNavigationBarIndex(int index) {
    emit(homepageInitial());
    bottomNavigationBarIndex = index;
    HapticFeedback.lightImpact();
    emit(ChangeBottomNavigationBarIndex());
  }

  final homeRepo Repo;
}
