import 'dart:developer';

import 'package:team_app/core/constants.dart';
// <<<<<<< Bayan
import 'package:team_app/core/func/custom_progress_indicator.dart';
import 'package:team_app/core/func/custom_snack_bar.dart';
import 'package:team_app/core/utils/app_router.dart';
import 'package:team_app/core/utils/size_config.dart';
import 'package:team_app/core/widgets/custom_button.dart';
import 'package:team_app/features/RecordsScreen/presentation/screens/records_page_body.dart';
import 'package:team_app/features/RecordsScreen/presentation/screens/recordDetailsPage.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/appointemtsPage/presentation/screen/appointments_page.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/conversations_screen.dart';
import 'package:team_app/features/RecordsScreen/data/models/record_model.dart';
import 'package:team_app/features/homepage/data/models/user_model.dart';
import 'package:team_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:team_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:team_app/features/homepage/presentation/screens/widgets/custom_drawer.dart';
import 'package:team_app/features/homepage/presentation/screens/widgets/proposedSystem.dart';
import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:team_app/features/RecordsScreen/presentation/screens/records_page_body.dart';
import 'product_item.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<homepageCubit>(context);

    return BlocConsumer<homepageCubit, homepageState>(
      listener: (context, state) {
        cubit.listining = true;
      },
      builder: (context, state) {
        return Scaffold(
            // bottomNavigationBar: BottomNavigationBar(
            //   items: cubit.bottomNavigationBarItems,
            //   onTap: (index) {
            //     cubit.changeBottomNavigationBarIndex(index);
            //   },
            //   cubit.bottomNavigationBarIndex: cubit.bottomNavigationBarIndex,
            // ),
            bottomNavigationBar: Container(
              margin: EdgeInsets.all(SizeConfig.screenWidth * .05),
              height: SizeConfig.screenWidth * .155,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * .02),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    cubit.changeBottomNavigationBarIndex(index);
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == cubit.bottomNavigationBarIndex
                            ? SizeConfig.screenWidth * .50
                            : SizeConfig.screenWidth * .18,
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height: index == cubit.bottomNavigationBarIndex
                              ? SizeConfig.screenWidth * .12
                              : 0,
                          width: index == cubit.bottomNavigationBarIndex
                              ? SizeConfig.screenWidth * .50
                              : 0,
                          decoration: BoxDecoration(
                            color: index == cubit.bottomNavigationBarIndex
                                ? Colors.blueAccent.withOpacity(.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == cubit.bottomNavigationBarIndex
                            ? SizeConfig.screenWidth * .31
                            : SizeConfig.screenWidth * .18,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == cubit.bottomNavigationBarIndex
                                      ? SizeConfig.screenWidth * .13
                                      : 0,
                                ),
                                AnimatedOpacity(
                                  opacity:
                                      index == cubit.bottomNavigationBarIndex
                                          ? 1
                                          : 0,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: Text(
                                    index == cubit.bottomNavigationBarIndex
                                        ? '${cubit.listOfStrings[index]}'
                                        : '',
                                    style: TextStyle(
                                      color: AppConstants.blueColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width: index == cubit.bottomNavigationBarIndex
                                      ? SizeConfig.screenWidth * .03
                                      : 20,
                                ),
                                cubit.listOfIcons[index],
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: cubit.bottomNavigationBarIndex == 0
                ? ConversationsScreen()
                : cubit.bottomNavigationBarIndex == 1
                    ? AppointmentsScreen()
                    : RecordsPageBody());
      },
    );
  }
}

// class homeBodyBody extends StatelessWidget {
//   const homeBodyBody({
//     super.key,
//     required this.cubit,
//   });
//   final homepageCubit cubit;
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<homepageCubit, homepageState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         return Scaffold(
//           drawer: cubit.userInfo != null
//               ? CustomDrawer.getCustomDrawer(
//                   userModel: cubit.userInfo!,
//                   context,
//                   scaffoldKey: cubit.scaffoldKey,
//                 )
//               : null,
//           appBar: AppBar(
//             centerTitle: true,
//             title: Text(
//               'الصفحة الرئيسية',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           body: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 250,
//                   child: ScrollSnapList(
//                     curve: Curves.ease,
//                     initialIndex: 2.0,
//                     allowAnotherDirection: true,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) {
//                       return ReadyMadeSystemItem(
//                         context,
//                       );
//                     },
//                     itemCount: 10,
//                     itemSize: 200,
//                     onItemFocus: (p0) {},
//                     dynamicItemSize: true,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 7,
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
//                   child: Text(
//                     "المنتجات الشائعة",
//                     style: TextStyle(
//                       color: Colors.black54,
//                       fontSize: 18,
//                     ),
//                     textAlign: TextAlign.start,
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     CategoryItem(
//                       onTap: () {
//                         // cubit.fetchAllProducts();
//                       },
//                       icon: Icons.all_out_sharp,
//                       text: "الكل",
//                     ),
//                     // SizedBox(width: 5),
//                     CategoryItem(
//                       onTap: () {
//                         //  cubit.fetchAllPanales();
//                       },
//                       icon: Icons.admin_panel_settings_sharp,
//                       text: "الألواح",
//                     ),
//                     // SizedBox(width: 5),
//                     CategoryItem(
//                       onTap: () {
//                         // cubit.fetchAllBAtteries();
//                       },
//                       icon: Icons.battery_5_bar,
//                       text: "البطاريات",
//                     ),
//                     // SizedBox(width: 5),
//                     CategoryItem(
//                       onTap: () {
//                         // cubit.fetchAllInverters();
//                       },
//                       icon: Icons.device_hub,
//                       text: "الإنفيرترات",
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 7,
//                 ),
//                 state is GetProductsSuccess
//                     ? productGridView(
//                         count: cubit.products.length,
//                         product: cubit.products,
//                       )
//                     : state is GetPanalesSuccess
//                         ? productGridView(
//                             count: cubit.panales.length,
//                             product: cubit.panales,
//                           )
//                         : state is GetBatteriesSuccess
//                             ? productGridView(
//                                 count: cubit.batteries.length,
//                                 product: cubit.batteries,
//                               )
//                             : state is GetInvertersSuccess
//                                 ? productGridView(
//                                     count: cubit.inverters.length,
//                                     product: cubit.inverters,
//                                   )
//                                 : Container()
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class productGridView extends StatelessWidget {
//   const productGridView({
//     super.key,
//     required this.count,
//     required this.product,
//   });

//   final int count;
//   final List<Product> product;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: 2,
//       child: GridView.builder(
//         itemCount: count,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 8.0,
//           mainAxisSpacing: 8.0,
//           childAspectRatio: 0.6,
//         ),
//         itemBuilder: (context, index) {
//           return ProductItem(
//             product: product[index],
//           );
//         },
//       ),
//     );
//   }
// }

class CategoryItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;
  const CategoryItem({
    super.key,
    required this.text,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.amber,
      autofocus: true,
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CircleAvatar(
              child: Icon(
                icon,
                color: Colors.white,
              ),
              backgroundColor: AppConstants.blueColor,
              radius: 30,
            ),
          ),
          Text(
            "$text",
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }
}
