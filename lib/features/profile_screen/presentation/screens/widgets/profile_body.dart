import 'package:team_app/core/constants.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/widgets/chat_user.dart';
import 'package:team_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:team_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class profileBody extends StatelessWidget {
  // final ChatUser user;

  const profileBody({
    super.key,
    // required this.user
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<homepageCubit>(context);
    return BlocConsumer<homepageCubit, homepageState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetUserInfoSuccess) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Center(
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppConstants.blueColor,
                          Colors.blue,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 4,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 100 / 2,
                      // backgroundImage: NetworkImage(imageUrl),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    state.UserInfo.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    state.UserInfo.email,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                SizedBox(height: 20),
                Divider(),
                ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('الهاتف'),
                  subtitle: Text(state.UserInfo.phone),
                ),
                // ListTile(
                //   leading: Icon(Icons.calendar_today),
                //   title: Text('Account Created'),
                //   subtitle: Text(
                //       '{cubit.userInfo?.createdAt.year}-{cubit.userInfo?.createdAt.month}-{cubit.userInfo?.createdAt.day}'),
                // ),
                // ListTile(
                //   leading: Icon(Icons.calendar_today),
                //   title: Text('Last Updated'),
                //   subtitle: Text(
                //       '{cubit.userInfo?.updatedAt.year}-{cubit.userInfo?.updatedAt.month}-{cubit.userInfo?.updatedAt.day}'),
                // ),
                // if (cubit.userInfo?.emailVerifiedAt != null)
                //   ListTile(
                //     leading: Icon(Icons.verified),
                //     title: Text('Email Verified At'),
                //     subtitle: Text(cubit.userInfo!.emailVerifiedAt!),
                //   ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
