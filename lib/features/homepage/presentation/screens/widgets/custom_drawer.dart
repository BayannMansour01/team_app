import 'dart:developer';

import 'package:team_app/core/constants.dart';
import 'package:team_app/core/utils/api/apis.dart';
import 'package:team_app/core/utils/app_router.dart';
import 'package:team_app/core/widgets/custom_image.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/chat_screen.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/widgets/chat_user.dart';
import 'package:team_app/features/homepage/data/models/user_model.dart';
import 'package:team_app/features/homepage/presentation/screens/widgets/custom_drawer_button.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class CustomDrawer {
  static Drawer getCustomDrawer(
    BuildContext context, {
    required GlobalKey<ScaffoldState> scaffoldKey,
    // required PropertiesCubit propertiesCubit,
    required UserModel userModel,
  }) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      width: 250,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
              color: AppConstants.blueColor,
            ),
            child: Column(
              children: [
                SizedBox(height: 40),
                Center(
                  child: CustomImage(
                    height: 90,
                    width: 100,
                    image: 'assets/images/LOGO.jpg',
                    // backgroundColor: Colors.transparent,
                    color: Colors.transparent,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    '${userModel.name}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
          SizedBox(height: 30),
          CustomDrawerButton(
            text: 'السجل الشخصي',
            icon: Icons.account_circle,
            onPressed: () {
              context.push(AppRouter.kProfileView);
            },
          ),
          SizedBox(height: 15),
          CustomDrawerButton(
            text: 'المفضلة',
            icon: Icons.favorite,
            onPressed: () {},
          ),
          SizedBox(height: 15),
          CustomDrawerButton(
            text: '! اسأل سؤالاً',
            icon: Icons.chat,
            // onPressed: () {
            //   context.push(
            //     AppRouter.kChatUserView,
            //     extra:
            //         ChatUser.factory(APIs.getCompany() as Map<String, dynamic>),
            //   );

            //   // context.push(AppRouter.kChatView);
            // },
            onPressed: () async {
              // ChatUser? user = await APIs.getCompany();
              // log("user ${user?.id}");
              // if (user != null) {
              //   context.push(
              //     AppRouter.kChatUserView,
              //     extra: user,
              //   );
              // } else {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(content: Text('User not found')),
              //   );
              // }
            },
          ),
          SizedBox(height: 15),
          CustomDrawerButton(
            text: 'مواعيدي',
            fontSize: 18,
            icon: FontAwesomeIcons.ad,
            onPressed: () {
              // Navigator.pushNamed(context, MyAdvertisementsView.route,
              //     arguments: {
              //       'propertiesCubit': propertiesCubit,
              //       'userModel': userModel,
              //     });
            },
          ),
          SizedBox(height: 15),
          const Expanded(child: SizedBox(height: 10)),
          CustomDrawerButton(
            text: 'Logout',
            icon: Icons.logout,
            iconColor: Colors.red,
            onPressed: () async {
              // await propertiesCubit.logOut(context);
            },
          ),
          const SizedBox(height: 20),
          SizedBox(height: 25),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
