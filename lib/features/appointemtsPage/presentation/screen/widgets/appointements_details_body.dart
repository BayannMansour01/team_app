import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:team_app/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_app/core/utils/app_router.dart';
import 'package:team_app/core/utils/service_locator.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/appointemtsPage/data/repos/appointements_repo_impl.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointement_cubit.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointements_state.dart';
import 'package:team_app/features/appointemtsPage/presentation/screen/widgets/custom_stepper.dart';
import 'package:team_app/features/appointemtsPage/presentation/screen/widgets/prouducts_list.dart';
import 'package:team_app/features/appointemtsPage/presentation/screen/productgridViewForShow.dart';

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
            ..fetchUser(appointement.user.uid)
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
              floatingActionButton: InkWell(
                onTap: () {
                  log("${cubit.userByuid}");
                  context.push(AppRouter.kChatUserView, extra: cubit.userByuid);
                },
                child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: AppConstants.orangeColor,
                  child: Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                ),
              ),
              backgroundColor: Color.fromARGB(255, 232, 243, 248),
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "تفاصيل الموعد",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        cubit.date != null
                            ? '${cubit.date.year}-${cubit.date.month}-${cubit.date.day}'
                            : "لم يتم تحديد تاريخ انتهاء بعد ! ",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      const Row(
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
                      Container(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
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
                                          child: Column(children: [
                                            productGridViewforshow(
                                                count:
                                                    cubit.productsshow.length,
                                                product: cubit.productsshow),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'تاريخ نهاية الإنجاز ',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    showDatePicker(
                                                            //  barrierColor: AppConstants.orangeColor,
                                                            context: context,
                                                            // initialDate: DateTime.now(),
                                                            firstDate:
                                                                DateTime(2024),
                                                            lastDate:
                                                                DateTime(2025))
                                                        .then((value) {
                                                      value != null
                                                          ? cubit.setDate(value)
                                                          : null;
                                                    });
                                                  },
                                                  icon: const Icon(Icons
                                                      .calendar_month_outlined),
                                                  iconSize: 35,
                                                  color: AppConstants
                                                      .backgroundColor,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8.0,
                                            ),
                                            Text(
                                              cubit.date != null
                                                  ? '${cubit.date.year}-${cubit.date.month}-${cubit.date.day}'
                                                  : "لم يتم تحديد تاريخ انتهاء بعد ! ",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 18.0,
                                            ),
                                          ]),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // إغلاق الحوار
                                            },
                                            child: const Text(
                                              'إلغاء',
                                              style: TextStyle(
                                                color: AppConstants.blueColor,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              cubit.updateProducts(
                                                appointement.id,
                                                '${cubit.date.year}-${cubit.date.month}-${cubit.date.day}',
                                              );
                                              Navigator.of(context)
                                                  .pop(); // إغلاق الحوار
                                            },
                                            child: const Text(
                                              'موافق',
                                              style: TextStyle(
                                                color: AppConstants.blueColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.edit)),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      productGridView(
                        count: appointement.order.products.length,
                        product: appointement.order.products,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
