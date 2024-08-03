import 'dart:developer';

import 'package:team_app/core/utils/cache_helper.dart';
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
  List<Widget> screens = [
    // PreviousJobsBody(
    //   token: CacheHelper.getData(key: 'Token'),
    // ),
    HomePage(
      token: CacheHelper.getData(key: 'Token'),
    ),

    HomePage(
      token: CacheHelper.getData(key: 'Token'),
    ),
    ConversationsScreen()
  ];

  void changeBottomNavigationBarIndex(int index) {
    emit(homepageInitial());
    bottomNavigationBarIndex = index;
    emit(ChangeBottomNavigationBarIndex());
  }

  final homeRepo Repo;
  // String groupname = '';
  // List<System> proposedSystem = [];

  UserModel? userInfo;
  Future<void> fetchUserInfo() async {
    emit(GetUserInfoLoading());
    var result = await Repo.fetchuserinfo();
    result.fold((failure) {
      emit(GetUserInfoFailure(((failure.errorMessege))));
    }, (data) {
      userInfo = data;
      CacheHelper.saveData(key: 'UserID', value: userInfo?.id);
      log("message${CacheHelper.saveData(key: 'UserID', value: userInfo?.id)}");
      emit(GetUserInfoSuccess(data));
    });
  }
}
  // Future<void> logout() async {
  //   emit(LogoutLoading());
  //   var result = await Repo.Loguot(token: CacheHelper.getData(key: 'Token'));
  //   result.fold((failure) {
  //     emit(LogoutFailure(((failure.errorMessege))));
  //   }, (data) {
  //     emit(LogoutSuccess((data)));
  //   });
  // }
