import 'dart:developer';
import 'dart:ffi';

import 'package:http/http.dart';
import 'package:team_app/core/constants.dart';
import 'package:team_app/core/func/custom_progress_indicator.dart';
import 'package:team_app/core/func/custom_snack_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_app/core/utils/api/apis.dart';
import 'package:team_app/core/utils/app_router.dart';
import 'package:team_app/core/utils/service_locator.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/appointemtsPage/data/repos/appointements_repo_impl.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointement_cubit.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointements_state.dart';
import 'package:team_app/features/appointemtsPage/presentation/screen/widgets/appointments_body.dart';
import 'package:team_app/features/appointemtsPage/presentation/screen/widgets/custom_stepper.dart';
import 'package:team_app/features/appointemtsPage/presentation/screen/widgets/date_picker.dart';
import 'package:team_app/features/appointemtsPage/presentation/screen/widgets/prouducts_list.dart';
import 'package:team_app/features/homepage/data/models/product_model.dart';
import 'package:team_app/features/homepage/presentation/screens/widgets/home_page_body.dart';
import 'package:team_app/features/homepage/presentation/screens/widgets/productgridViewForShow.dart';

class AppointementDetailsScreen extends StatelessWidget {
  Appointment appointement;

  AppointementDetailsScreen({
    required this.appointement,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return AppointementsCubit(getIt.get<AppointementsRepoImpl>())
           // ..fetchUser(appointement.user.uid)
            ..fetchallproducts();
        },
        child: BlocConsumer<AppointementsCubit, AppointementsState>(
          listener: (context, state) {
            if (state is AppointementsStateChangeTocomplete) {
              log("state ${state.state}");
              appointement.statusId = state.state;
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            final cubit = BlocProvider.of<AppointementsCubit>(context);

            return Scaffold(
              // floatingActionButton: InkWell(
              //   onTap: () {
              //     context.push(AppRouter.kChatUserView, extra: cubit.userByuid);
              //   },
              //   child: const CircleAvatar(
              //     radius: 30,
              //     backgroundColor: AppConstants.orangeColor,
              //     child: Icon(
              //       Icons.chat,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              // backgroundColor: Color.fromARGB(255, 232, 243, 248),
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "تفاصيل الموعد",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              body: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "اسم الزبون ",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            '${appointement.user.name}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "رقم الزبون ",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            '${appointement.user.phone}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'تاريخ بداية الإنجاز ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '${appointement.startTime}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'تاريخ نهاية الإنجاز ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // showDatePicker(
                          //         //  barrierColor: AppConstants.orangeColor,
                          //         context: context,
                          //         // initialDate: DateTime.now(),
                          //         firstDate: DateTime(2024),
                          //         lastDate: DateTime(2025))
                          //     .then((value) {
                          //   value != null ? cubit.setDate(value) : null;
                          // });
                        },
                        icon: Icon(Icons.calendar_month_outlined),
                        iconSize: 35,
                        color: AppConstants.backgroundColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    appointement.endTime != null
                        ? '${appointement.endTime}'
                        : "لم يتم تحديد تاريخ انتهاء بعد ! ",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Row(
                    children: [
                      Text(
                        'حالة الطلب ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CustomStepper(appointement),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' المنتجات المطلوبة',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                             onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('اختر المنتجات المناسبة '),
                                  content: SingleChildScrollView(
                                    child: productGridViewforshow(

                                        count: cubit.productsshow.length,
                                        product: cubit.productsshow),

                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('إلغاء'),
                                    ),
                                    TextButton(
                                      onPressed: () {

                                        // cubit.submitUpdate()
                                        Navigator.of(context)
                                            .pop(); // إغلاق الحوار

                                      },
                                      child: Text('موافق'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.edit)),
                    ],
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  productGridView(
                    count: appointement.order.products.length,
                    product: appointement.order.products,
                  )
                ],
              ),
            );
          },
        ));
  }
}
