import 'dart:developer';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:team_app/core/constants.dart';
import 'package:team_app/core/func/custom_snack_bar.dart';
import 'package:team_app/core/utils/api/apis.dart';
import 'package:team_app/core/utils/app_router.dart';
import 'package:team_app/core/utils/cache_helper.dart';
import 'package:team_app/core/utils/size_config.dart';
import 'package:team_app/core/widgets/custom_image.dart';
import 'package:team_app/features/homepage/presentation/screens/widgets/custom_drawer_button.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/widgets/chat_user.dart';
import 'package:team_app/features/homepage/data/logout_service.dart';
import 'package:team_app/features/homepage/data/models/user_model.dart';

abstract class CustomDrawer {
  static Drawer getCustomDrawer(
    BuildContext context, {
    required GlobalKey<ScaffoldState> scaffoldKey,
    UserModel? userModel,
  }) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      width: 250,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                  color: AppConstants.blueColor),
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.defaultSize * 5),
                  const Center(
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      child: CustomImage(
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                        image: 'assets/images/LOGO.png',
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.defaultSize * 3),
                  if (userModel != null) // Added null check
                    Center(
                      child: Text(
                        userModel.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  SizedBox(height: SizeConfig.defaultSize * 3),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize),
            CustomDrawerButton(
              text: 'السجل الشخصي',
              icon: Icons.account_circle,
              onPressed: () {
                context.push(AppRouter.kProfileView);
              },
            ),
            SizedBox(height: SizeConfig.defaultSize),
            CustomDrawerButton(
              text: 'Logout',
              icon: Icons.logout,
              iconColor: Colors.red,
              onPressed: () async {
                await APIs.auth.signOut().then(
                  (value) async {
                    (await LogOutService.logout(
                      token: await CacheHelper.getData(key: 'Token'),
                    ))
                        .fold(
                      (failure) {
                        CustomSnackBar.showErrorSnackBar(
                          context,
                          message: 'Something Went Wrong, Please Try Again',
                        );
                      },
                      (success) async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('تم تسجيل الخروج بنجاح!')),
                        );

                        await CacheHelper.deletData(key: 'Token');
                        context.pushReplacement(AppRouter.kLoginView);
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(height: SizeConfig.defaultSize),
          ],
        ),
      ),
    );
  }
}
