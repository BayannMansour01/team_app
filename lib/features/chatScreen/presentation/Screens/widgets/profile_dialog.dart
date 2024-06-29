// import 'package:alternative_energy_user_app/core/utils/size_config.dart';
// import 'package:alternative_energy_user_app/features/chatScreen/presentation/Screens/widgets/chat_user.dart';
// import 'package:alternative_energy_user_app/main.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class ProfileDialog extends StatelessWidget {
//   const ProfileDialog({super.key, required this.user});

//   final ChatUser user;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       contentPadding: EdgeInsets.zero,
//       backgroundColor: Colors.white.withOpacity(.9),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       content: SizedBox(
//           width: SizeConfig.screenWidth * .6,
//           height: SizeConfig.screenHeight * .35,
//           child: Stack(
//             children: [
//               //user profile picture
//               Positioned(
//                 top: SizeConfig.screenHeight * .075,
//                 left: SizeConfig.screenWidth * .1,
//                 child: ClipRRect(
//                   borderRadius:
//                       BorderRadius.circular(SizeConfig.screenHeight * .25),
//                   child: CachedNetworkImage(
//                     width: SizeConfig.screenWidth * .5,
//                     height: SizeConfig.screenWidth * .5,
//                     fit: BoxFit.cover,
//                     imageUrl: user.image,
//                     errorWidget: (context, url, error) =>
//                         const CircleAvatar(child: Icon(CupertinoIcons.person)),
//                   ),
//                 ),
//               ),

//               //user name
//               Positioned(
//                 left: SizeConfig.screenWidth * .04,
//                 top: SizeConfig.screenHeight * .02,
//                 width: SizeConfig.screenWidth * .55,
//                 child: Text(user.name,
//                     style: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.w500)),
//               ),

//               //info button
//               Positioned(
//                   right: 8,
//                   top: 6,
//                   child: MaterialButton(
//                     onPressed: () {
//                       //for hiding image dialog
//                       Navigator.pop(context);

//                       //move to view profile screen
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //         builder: (_) => ViewProfileScreen(user: user)));
//                     },
//                     minWidth: 0,
//                     padding: const EdgeInsets.all(0),
//                     shape: const CircleBorder(),
//                     child: const Icon(Icons.info_outline,
//                         color: Colors.blue, size: 30),
//                   ))
//             ],
//           )),
//     );
//   }
// }
