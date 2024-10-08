import 'dart:developer';

import 'package:team_app/core/constants.dart';
import 'package:team_app/core/utils/size_config.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/widgets/chat_user.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/widgets/chat_user_card.dart';
import 'package:team_app/core/utils/api/apis.dart';
import 'package:team_app/features/chatScreen/presentation/manager/helper/dialogs.dart';
import 'package:team_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

//home screen -- where all available contacts are shown
class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  // for storing all users
  List<ChatUser> _list = [];

  // for storing searched items
  final List<ChatUser> _searchList = [];
  // for storing search status
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();

    //for updating user active status according to lifecycle events
    //resume -- active or online
    //pause  -- inactive or offline
    SystemChannels.lifecycle.setMessageHandler((message) {
      log('Message: $message');

      if (APIs.auth.currentUser != null) {
        if (message.toString().contains('resume')) {
          APIs.updateActiveStatus(true);
        }
        if (message.toString().contains('pause')) {
          APIs.updateActiveStatus(false);
        }
      }

      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //for hiding keyboard when a tap is detected on screen
      onTap: FocusScope.of(context).unfocus,
      child: PopScope(
        // onWillPop: () {
        //   if (_isSearching) {
        //     setState(() {
        //       _isSearching = !_isSearching;
        //     });
        //     return Future.value(false);
        //   } else {
        //     return Future.value(true);
        //   }
        // },

        //if search is on & back button is pressed then close search
        //or else simple close current screen on back button click
        canPop: !_isSearching,
        onPopInvoked: (_) async {
          if (_isSearching) {
            setState(() => _isSearching = !_isSearching);
          } else {
            context.pop();
          }
        },

        //
        child: Scaffold(
          //app bar
          appBar: AppBar(
            leading: const Icon(CupertinoIcons.home),
            title: _isSearching
                ? TextField(
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: 'Name, Email, ...'),
                    autofocus: true,
                    style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
                    //when search text changes then updated search list
                    onChanged: (val) {
                      //search logic
                      _searchList.clear();

                      for (var i in _list) {
                        if (i.name.toLowerCase().contains(val.toLowerCase()) ||
                            i.email.toLowerCase().contains(val.toLowerCase())) {
                          _searchList.add(i);
                          setState(() {
                            _searchList;
                          });
                        }
                      }
                    },
                  )
                : const Text(
                    'المحادثات مع الزبائن ',
                    style: TextStyle(color: Colors.white),
                  ),
            actions: [
              //search user button
              IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                  icon: Icon(_isSearching
                      ? CupertinoIcons.clear_circled_solid
                      : Icons.search)),

              //more features button
              // IconButton(
              //     onPressed: () {
              //       // Navigator.push(
              //       //     context,
              //       //     MaterialPageRoute(
              //       //         builder: (_) => ProfileScreen(user: APIs.me)));
              //     },
              //     icon: const Icon(Icons.more_vert))
            ],
          ),

          //floating button to add new user
          // floatingActionButton: Padding(
          //   padding: const EdgeInsets.only(bottom: 10),
          //   child: FloatingActionButton(
          //       onPressed: () {
          //         _addChatUserDialog();
          //       },
          //       child: const Icon(Icons.add_comment_rounded)),
          // ),
          body: StreamBuilder(
            stream: APIs.getMyUsersId(),
            //get id of only known users
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                //if data is loading
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppConstants.blueColor,
                  ));

                //if some or all data is loaded then show it
                case ConnectionState.active:
                case ConnectionState.done:
                  log("getchatusers ${snapshot.data?.docs.map((e) => e.id).toList()}");
                  return StreamBuilder(
                    stream: APIs.getChatUsers(snapshot.data?.docs.map((e) {
                          return e.id;
                        }).toList() ??
                        []),
                    //get only those user, who's ids are provided
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        //if data is loading
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                        // return const Center(
                        //     child: CircularProgressIndicator());

                        //if some or all data is loaded then show it
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data = snapshot.data?.docs;
                          _list = data?.map((e) {
                                return ChatUser.fromJson(e.data());
                              }).toList() ??
                              [];

                          if (_list.isNotEmpty) {
                            return ListView.builder(
                                itemCount: _isSearching
                                    ? _searchList.length
                                    : _list.length,
                                padding: EdgeInsets.only(
                                    top: SizeConfig.screenHeight * .01),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ChatUserCard(
                                      user: _isSearching
                                          ? _searchList[index]
                                          : _list[index]);
                                });
                          } else {
                            return const Center(
                              child: Text('لا يوجد محادثات بعد!',
                                  style: TextStyle(fontSize: 20)),
                            );
                          }
                      }
                    },
                  );
              }
            },
          ),
        ),
      ),
    );
  }

  // for adding new chat user
  void _addChatUserDialog() {
    String email = '';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),

              //title
              title: const Row(
                children: [
                  Icon(
                    Icons.person_add,
                    color: Colors.blue,
                    size: 28,
                  ),
                  Text('  Add User')
                ],
              ),

              //content
              content: TextFormField(
                maxLines: null,
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                    hintText: 'Email Id',
                    prefixIcon: const Icon(Icons.email, color: Colors.blue),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15))),
              ),

              //actions
              actions: [
                //cancel button
                MaterialButton(
                    onPressed: () {
                      //hide alert dialog
                      context.pop();
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.blue, fontSize: 16))),

                //add button
                MaterialButton(
                    onPressed: () async {
                      //hide alert dialog
                      context.pop();
                      // if (email.isNotEmpty) {
                      //   await APIs.addChatUser(email).then((value) {
                      //     if (!value) {
                      //       Dialogs.showSnackbar(
                      //           context, 'User does not Exists!');
                      //     }
                      //   });
                      // }
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ))
              ],
            ));
  }
}
