import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:team_app/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_app/core/utils/app_router.dart';
import 'package:team_app/core/utils/service_locator.dart';
import 'package:team_app/core/utils/size_config.dart';
import 'package:team_app/core/widgets/custom_text_field.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/appointemtsPage/data/repos/appointements_repo_impl.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointement_cubit.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointements_state.dart';
import 'package:team_app/features/appointemtsPage/presentation/screen/widgets/prouducts_list.dart';
import 'package:team_app/features/homepage/data/models/products_update_body.dart';
import 'package:team_app/features/homepage/presentation/screens/widgets/deatiles_product.dart';

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
            ..fetchUser(appointement.user.uId)
            ..fetchallproducts();
        },
        child: BlocConsumer<AppointementsCubit, AppointementsState>(
          listener: (context, state) {
            if (state is AppointementsStateChangeTocomplete) {
              log("state ${state.state}");
              appointement.statusId = state.state;
            }
            if (state is OrderUpdateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم التعديل بنجاح !')),
              );
              appointement.statusId = 3;
            }
            if (state is MakeDoneState) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم تعديل حالة المهمة بنجاح !   ')),
              );
            }
          },
          builder: (context, state) {
            final cubit = BlocProvider.of<AppointementsCubit>(context);

            if (state is MakeDoneState) {
              cubit.setToCompleted(appointement);
            }
            if (state is OrderAmountChanged) {
              log("OrderAmountChangeds ${state.quantity}");
            }
            return Scaffold(
              floatingActionButton: InkWell(
                onTap: () {
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
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: SizeConfig.screenHeight,
                  child: SingleChildScrollView(
                    child: Column(
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
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2025),
                                ).then((value) {
                                  if (value != null) {
                                    if (appointement.typeId == 1) {
                                      cubit.updateProducts(
                                        appointement,
                                        '${value.year}-${value.month}-${value.day}',
                                      );
                                    }
                                    cubit.setDate(value);
                                  } else {
                                    return null;
                                  }
                                });
                              },
                              icon: Icon(Icons.calendar_month_outlined),
                              iconSize: 35,
                              color: AppConstants.backgroundColor,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          appointement.endTime != null ||
                                  state is! setDateTimeState
                              ? '${cubit.date.year}-${cubit.date.month}-${cubit.date.day}'
                              : state is setDateTimeState
                                  ? '${state.date.year}-${state.date.month}-${state.date.day}'
                                  : "لم يتم تحديد تاريخ انتهاء بعد ! ",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Row(
                          children: [
                            Text(
                              'حالة المهمة ',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        // EasyStepper(
                        //   lineStyle: LineStyle(
                        //     lineLength: 80,
                        //     lineSpace: 0,
                        //     lineType: LineType.normal,
                        //     defaultLineColor: Colors.white,
                        //     finishedLineColor: appointement.statusId > 1
                        //         ? Colors.orange
                        //         : Colors
                        //             .white, // تلوين الخط حتى قيد الكشف عند statusId > 1
                        //   ),
                        //   activeStep: appointement.statusId > 2
                        //       ? 2
                        //       : appointement.statusId - 1,
                        //   activeStepTextColor: Colors.black87,
                        //   finishedStepTextColor: Colors.black87,
                        //   internalPadding: 0,
                        //   showLoadingAnimation: false,
                        //   stepRadius: 8,
                        //   showStepBorder: false,
                        //   steps: [
                        //     EasyStep(
                        //       customStep: CircleAvatar(
                        //         radius: 8,
                        //         backgroundColor: Colors.white,
                        //         child: CircleAvatar(
                        //           radius: 7,
                        //           backgroundColor: appointement.statusId >= 0
                        //               ? Colors.orange
                        //               : Colors.white,
                        //         ),
                        //       ),
                        //       title: 'قيد الانتظار',
                        //     ),
                        //     EasyStep(
                        //       customStep: CircleAvatar(
                        //         radius: 8,
                        //         backgroundColor: Colors.white,
                        //         child: CircleAvatar(
                        //           radius: 7,
                        //           backgroundColor: appointement.statusId > 1 &&
                        //                   (!cubit.isAppointmentInFuture(
                        //                           appointement.startTime) ||
                        //                       appointement.statusId > 2)
                        //               ? Colors.orange
                        //               : Colors.white,
                        //         ),
                        //       ),
                        //       title: 'قيد الكشف',
                        //       topTitle: true,
                        //     ),
                        //     EasyStep(
                        //       customStep: CircleAvatar(
                        //         radius: 8,
                        //         backgroundColor: Colors.white,
                        //         child: CircleAvatar(
                        //           radius: 7,
                        //           backgroundColor: appointement.statusId > 2
                        //               ? Colors.orange
                        //               : Colors.white,
                        //         ),
                        //       ),
                        //       title: 'قيد التنفيذ',
                        //     ),
                        //     EasyStep(
                        //       customStep: InkWell(
                        //         onTap: () {
                        //           showDialog(
                        //             context: context,
                        //             builder: (context) {
                        //               return AlertDialog(
                        //                 actionsOverflowDirection:
                        //                     VerticalDirection.up,
                        //                 actionsOverflowAlignment:
                        //                     OverflowBarAlignment.end,
                        //                 title: const Text(
                        //                     ' أضف تشخيص و سعر متوقع'),
                        //                 content: Column(
                        //                   mainAxisSize: MainAxisSize.min,
                        //                   children: [
                        //                     CustomTextField(
                        //                       width: double.infinity,
                        //                       hintText: "أدخل ملاحظاتك ... ",
                        //                       labelText: "التشخيص ",
                        //                       onChanged: (p0) {
                        //                         cubit.desc = p0;
                        //                       },
                        //                     ),
                        //                     const SizedBox(height: 15),
                        //                     CustomTextField(
                        //                       width: double.infinity,
                        //                       keyboardType:
                        //                           TextInputType.number,
                        //                       onChanged: (p1) {
                        //                         cubit.otherPrice =
                        //                             int.tryParse(p1) ?? 0;
                        //                         log('${int.tryParse(p1)}');
                        //                       },
                        //                       labelText: 'السعر ',
                        //                       hintText: ' السعر الإضافي .. ',
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 actions: [
                        //                   TextButton(
                        //                     onPressed: () {
                        //                       Navigator.of(context)
                        //                           .pop(); // إغلاق الحوار
                        //                     },
                        //                     child: const Text(
                        //                       'إلغاء',
                        //                       style: TextStyle(
                        //                           color:
                        //                               AppConstants.blueColor),
                        //                     ),
                        //                   ),
                        //                   TextButton(
                        //                     onPressed: () async {
                        //                       cubit.makeDone(appointement);
                        //                     },
                        //                     child: Text(
                        //                       'موافق',
                        //                       style: TextStyle(
                        //                           color:
                        //                               AppConstants.blueColor),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               );
                        //             },
                        //           );
                        //         },
                        //         child: CircleAvatar(
                        //           radius: 8,
                        //           backgroundColor: Colors.white,
                        //           child: CircleAvatar(
                        //             radius: 7,
                        //             backgroundColor: appointement.statusId > 3
                        //                 ? Colors.orange
                        //                 : Colors.white,
                        //           ),
                        //         ),
                        //       ),
                        //       topTitle: true,
                        //       title: 'تم الإنجاز',
                        //     ),
                        //   ],
                        // ),
                        EasyStepper(
                          lineStyle: LineStyle(
                            lineLength: 80,
                            lineSpace: 0,
                            lineType: LineType.normal,
                            defaultLineColor: Colors.white,
                            finishedLineColor: appointement.statusId > 2
                                ? Colors.orange
                                : Colors
                                    .white, // تلوين الخط حتى قيد الكشف عند statusId > 1
                          ),
                          activeStep: appointement.statusId - 1,
                          activeStepTextColor: Colors.black87,
                          finishedStepTextColor: Colors.black87,
                          internalPadding: 0,
                          showLoadingAnimation: false,
                          stepRadius: 8,
                          showStepBorder: false,
                          steps: [
                            EasyStep(
                              customStep: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 7,
                                  backgroundColor: appointement.statusId >= 0
                                      ? Colors.orange
                                      : Colors.white,
                                ),
                              ),
                              title: 'قيد الانتظار',
                            ),
                            EasyStep(
                              customStep: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 7,
                                  backgroundColor: appointement.statusId > 1 &&
                                          !cubit.isAppointmentInFuture(
                                              appointement.startTime)
                                      ? Colors.orange
                                      : Colors.white,
                                ),
                              ),
                              title: 'قيد الكشف',
                              topTitle: true,
                            ),
                            EasyStep(
                              customStep: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 7,
                                  backgroundColor: appointement.statusId > 2
                                      ? Colors.orange
                                      : Colors.white,
                                ),
                              ),
                              title: 'قيد التنفيذ',
                            ),
                            EasyStep(
                              customStep: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        actionsOverflowDirection:
                                            VerticalDirection.up,
                                        actionsOverflowAlignment:
                                            OverflowBarAlignment.end,
                                        title: const Text(
                                            ' أضف تشخيص و سعر متوقع'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomTextField(
                                              width: double.infinity,
                                              hintText: "أدخل ملاحظاتك ... ",
                                              labelText: "التشخيص ",
                                              onChanged: (p0) {
                                                cubit.desc = p0;
                                              },
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            CustomTextField(
                                              width: double.infinity,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (p1) {
                                                cubit.otherPrice =
                                                    int.tryParse(p1) ?? 0;
                                                log('${int.tryParse(p1)}');
                                              },
                                              labelText: 'السعر ',
                                              hintText: ' السعر الإضافي .. ',
                                            ),
                                          ],
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
                                                  color:
                                                      AppConstants.blueColor),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              cubit.makeDone(appointement);
                                            },
                                            child: Text(
                                              'موافق',
                                              style: TextStyle(
                                                  color:
                                                      AppConstants.blueColor),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                // : null
                                ,
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 7,
                                    backgroundColor: appointement.statusId > 3
                                        ? Colors.orange
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              topTitle: true,
                              title: 'تم الإنجاز',
                            ),
                          ],
                        ),

                        appointement.typeId == 2
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            title:
                                                Text('اختر المنتجات المناسبة'),
                                            content: SingleChildScrollView(
                                              child: Container(
                                                height: 500,
                                                width: double.maxFinite,
                                                child: GridView.builder(
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      cubit.productsshow.length,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 8.0,
                                                    mainAxisSpacing: 8.0,
                                                    childAspectRatio: 0.6,
                                                  ),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProductDetailsPage(
                                                              product: cubit
                                                                      .productsshow[
                                                                  index],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 2,
                                                              blurRadius: 5,
                                                              offset:
                                                                  Offset(0, 3),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            Image.network(
                                                              "http://${AppConstants.ip}:8000/${cubit.productsshow[index].image}",
                                                              height: SizeConfig
                                                                      .defaultSize *
                                                                  10,
                                                              width: double
                                                                  .infinity,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                              child: Text(
                                                                cubit
                                                                    .productsshow[
                                                                        index]
                                                                    .name,
                                                                style:
                                                                    TextStyle(
                                                                  color: AppConstants
                                                                      .orangeColor,
                                                                  fontSize:
                                                                      SizeConfig
                                                                          .defaultSize,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                maxLines: 1,
                                                              ),
                                                            ),
                                                            SizedBox(height: 1),
                                                            Text(
                                                              '${cubit.productsshow[index].price} ل.س',
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: SizeConfig
                                                                    .defaultSize,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(height: 1),
                                                            Container(
                                                              height: SizeConfig
                                                                      .defaultSize *
                                                                  4,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      cubit
                                                                          .decreaseQuantity(
                                                                        cubit
                                                                            .productsshow[index]
                                                                            .id,
                                                                      );
                                                                    },
                                                                    icon: Icon(
                                                                        Icons
                                                                            .remove,
                                                                        size:
                                                                            12),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            3.0),
                                                                    child: Text(
                                                                      '${cubit.getQuantity(cubit.productsshow[index].id)}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10),
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      cubit.increaseQuantity(cubit
                                                                          .productsshow[
                                                                              index]
                                                                          .id);
                                                                    },
                                                                    icon: Icon(
                                                                        Icons
                                                                            .add,
                                                                        size:
                                                                            12),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(height: 1),
                                                            Flexible(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  cubit
                                                                      .addToupdatedProduct(
                                                                    ProductUpdate(
                                                                      id: cubit
                                                                          .productsshow[
                                                                              index]
                                                                          .id,
                                                                      amount: cubit.getQuantity(cubit
                                                                          .productsshow[
                                                                              index]
                                                                          .id),
                                                                    ),
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppConstants
                                                                        .orangeColor,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .vertical(
                                                                      bottom: Radius
                                                                          .circular(
                                                                              12),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            8.0),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        'إضافة',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // إغلاق الحوار
                                                },
                                                child: Text('إلغاء'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  cubit.updateProducts(
                                                    appointement,
                                                    '${cubit.date.year}-${cubit.date.month}-${cubit.date.day}',
                                                  );
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
                                    icon: Icon(Icons.edit),
                                  ),
                                ],
                              )
                            : Container(),
                        const SizedBox(
                          height: 3,
                        ),
                        appointement.typeId == 2
                            ? productGridView(
                                count: appointement.order.products.length,
                                product: appointement.order.products,
                              )
                            : Image.network(
                                "http://${AppConstants.ip}:8000/${appointement.order.image}", // Ensure the image URL is accessible
                                height: SizeConfig.screenHeight * .5,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
                        // EasyStepper(
                        //   lineStyle: const LineStyle(
                        //     lineLength: 80,
                        //     lineSpace: 0,
                        //     lineType: LineType.normal,
                        //     defaultLineColor: Colors.white,
                        //     finishedLineColor: Colors.orange,
                        //   ),
                        //   activeStep: appointement.statusId - 1,
                        //   activeStepTextColor: Colors.black87,
                        //   finishedStepTextColor: Colors.black87,
                        //   internalPadding: 0,
                        //   showLoadingAnimation: false,
                        //   stepRadius: 8,
                        //   showStepBorder: false,
                        //   steps: [
                        //     EasyStep(
                        //       customStep: CircleAvatar(
                        //         radius: 8,
                        //         backgroundColor: Colors.white,
                        //         child: CircleAvatar(
                        //           radius: 7,
                        //           backgroundColor: appointement.statusId >= 0
                        //               ? Colors.orange
                        //               : Colors.white,
                        //         ),
                        //       ),
                        //       title: 'قيد الانتظار',
                        //     ),
                        //     EasyStep(
                        //       customStep: CircleAvatar(
                        //         radius: 8,
                        //         backgroundColor: Colors.white,
                        //         child: CircleAvatar(
                        //           radius: 7,
                        //           backgroundColor: appointement.statusId > 1
                        //               // &&
                        //               //         !cubit.isAppointmentInFuture(
                        //               //             appointement.startTime)
                        //               ? Colors.orange
                        //               : Colors.white,
                        //         ),
                        //       ),
                        //       title: 'قيد الكشف',
                        //       topTitle: true,
                        //     ),
                        //     EasyStep(
                        //       customStep: CircleAvatar(
                        //         radius: 8,
                        //         backgroundColor: Colors.white,
                        //         child: CircleAvatar(
                        //           radius: 7,
                        //           backgroundColor: appointement.statusId > 2
                        //               ? Colors.orange
                        //               : Colors.white,
                        //         ),
                        //       ),
                        //       title: 'قيد التنفيذ',
                        //     ),
                        //     EasyStep(
                        //       customStep: InkWell(
                        //         onTap: () {
                        //           showDialog(
                        //             context: context,
                        //             builder: (context) {
                        //               return AlertDialog(
                        //                 actionsOverflowDirection:
                        //                     VerticalDirection.up,
                        //                 actionsOverflowAlignment:
                        //                     OverflowBarAlignment.end,
                        //                 title: const Text(
                        //                     ' أضف تشخيص و سعر متوقع'),
                        //                 content: Column(
                        //                   mainAxisSize: MainAxisSize.min,
                        //                   children: [
                        //                     CustomTextField(
                        //                       width: double.infinity,
                        //                       hintText: "أدخل ملاحظاتك ... ",
                        //                       labelText: "التشخيص ",
                        //                       onChanged: (p0) {
                        //                         cubit.desc = p0;
                        //                       },
                        //                     ),
                        //                     const SizedBox(
                        //                       height: 15,
                        //                     ),
                        //                     CustomTextField(
                        //                       width: double.infinity,
                        //                       keyboardType:
                        //                           TextInputType.number,
                        //                       onChanged: (p1) {
                        //                         cubit.otherPrice =
                        //                             int.tryParse(p1) ?? 0;
                        //                         log('${int.tryParse(p1)}');
                        //                       },
                        //                       labelText: 'السعر ',
                        //                       hintText: ' السعر الإضافي .. ',
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 actions: [
                        //                   TextButton(
                        //                     onPressed: () {
                        //                       Navigator.of(context)
                        //                           .pop(); // إغلاق الحوار
                        //                     },
                        //                     child: const Text(
                        //                       'إلغاء',
                        //                       style: TextStyle(
                        //                           color:
                        //                               AppConstants.blueColor),
                        //                     ),
                        //                   ),
                        //                   TextButton(
                        //                     onPressed: () async {
                        //                       cubit.makeDone(appointement);
                        //                     },
                        //                     child: Text(
                        //                       'موافق',
                        //                       style: TextStyle(
                        //                           color:
                        //                               AppConstants.blueColor),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               );
                        //             },
                        //           );
                        //         }
                        //         // : null
                        //         ,
                        //         child: CircleAvatar(
                        //           radius: 8,
                        //           backgroundColor: Colors.white,
                        //           child: CircleAvatar(
                        //             radius: 7,
                        //             backgroundColor: appointement.statusId > 3
                        //                 ? Colors.orange
                        //                 : Colors.white,
                        //           ),
                        //         ),
                        //       ),
                        //       topTitle: true,
                        //       title: 'تم الإنجاز',
                        //     ),
                        //   ],
                        // ),




                                  // IconButton(
                                  //     onPressed: () {
                                  //       showDialog(
                                  //         context: context,
                                  //         builder: (context) {
                                  //           return AlertDialog(
                                  //             title: Text(
                                  //                 'اختر المنتجات المناسبة '),
                                  //             content: SingleChildScrollView(
                                  //               child: Container(
                                  //                 height: 500,
                                  //                 width: double.maxFinite,
                                  //                 child: SingleChildScrollView(
                                  //                   child: GridView.builder(
                                  //                     shrinkWrap: true,
                                  //                     physics:
                                  //                         NeverScrollableScrollPhysics(),
                                  //                     itemCount: cubit
                                  //                         .productsshow.length,
                                  //                     gridDelegate:
                                  //                         SliverGridDelegateWithFixedCrossAxisCount(
                                  //                       crossAxisCount: 2,
                                  //                       crossAxisSpacing: 8.0,
                                  //                       mainAxisSpacing: 8.0,
                                  //                       childAspectRatio: 0.6,
                                  //                     ),
                                  //                     itemBuilder:
                                  //                         (context, index) {
                                  //                       return InkWell(
                                  //                         onTap: () {
                                  //                           Navigator.push(
                                  //                             context,
                                  //                             MaterialPageRoute(
                                  //                               builder: (context) =>
                                  //                                   ProductDetailsPage(
                                  //                                       product:
                                  //                                           cubit.productsshow[index]),
                                  //                             ),
                                  //                           );
                                  //                         },
                                  //                         child: Container(
                                  //                           decoration:
                                  //                               BoxDecoration(
                                  //                             borderRadius:
                                  //                                 BorderRadius
                                  //                                     .circular(
                                  //                                         12),
                                  //                             color:
                                  //                                 Colors.white,
                                  //                             boxShadow: [
                                  //                               BoxShadow(
                                  //                                 color: Colors
                                  //                                     .grey
                                  //                                     .withOpacity(
                                  //                                         0.5),
                                  //                                 spreadRadius:
                                  //                                     2,
                                  //                                 blurRadius: 5,
                                  //                                 offset: Offset(
                                  //                                     0,
                                  //                                     3), // changes position of shadow
                                  //                               ),
                                  //                             ],
                                  //                           ),
                                  //                           child: Expanded(
                                  //                             child: Column(
                                  //                               children: [
                                  //                                 Image.network(
                                  //                                   "http://${AppConstants.ip}:8000/${cubit.productsshow[index].image}",
                                  //                                   height:
                                  //                                       SizeConfig.defaultSize *
                                  //                                           10,
                                  //                                   width: double
                                  //                                       .infinity,
                                  //                                   fit: BoxFit
                                  //                                       .contain,
                                  //                                 ),
                                  //                                 Padding(
                                  //                                   padding: const EdgeInsets
                                  //                                       .symmetric(
                                  //                                       horizontal:
                                  //                                           10),
                                  //                                   child: Text(
                                  //                                     cubit
                                  //                                         .productsshow[
                                  //                                             index]
                                  //                                         .name,
                                  //                                     style:
                                  //                                         TextStyle(
                                  //                                       color: AppConstants
                                  //                                           .orangeColor,
                                  //                                       fontSize:
                                  //                                           SizeConfig.defaultSize,
                                  //                                       fontWeight:
                                  //                                           FontWeight.bold,
                                  //                                       overflow:
                                  //                                           TextOverflow.ellipsis, // Overflow handling
                                  //                                     ),
                                  //                                     maxLines:
                                  //                                         1, // Limiting to one line
                                  //                                   ),
                                  //                                 ),
                                  //                                 SizedBox(
                                  //                                     height:
                                  //                                         1),
                                  //                                 Text(
                                  //                                   '${cubit.productsshow[index].price} ل.س',
                                  //                                   style:
                                  //                                       TextStyle(
                                  //                                     color: Colors
                                  //                                         .grey,
                                  //                                     fontSize:
                                  //                                         SizeConfig
                                  //                                             .defaultSize,
                                  //                                     fontWeight:
                                  //                                         FontWeight
                                  //                                             .bold,
                                  //                                   ),
                                  //                                 ),
                                  //                                 SizedBox(
                                  //                                     height:
                                  //                                         1),
                                  //                                 Container(
                                  //                                   height:
                                  //                                       SizeConfig.defaultSize *
                                  //                                           4,
                                  //                                   child: Row(
                                  //                                     mainAxisAlignment:
                                  //                                         MainAxisAlignment
                                  //                                             .center,
                                  //                                     children: [
                                  //                                       IconButton(
                                  //                                         onPressed:
                                  //                                             () {
                                  //                                           cubit.decreaseQuantity(cubit.productsshow[index].id);
                                  //                                         },
                                  //                                         icon: Icon(
                                  //                                             Icons.remove,
                                  //                                             size: 12),
                                  //                                       ),
                                  //                                       Padding(
                                  //                                         padding: const EdgeInsets
                                  //                                             .all(
                                  //                                             8.0),
                                  //                                         child:
                                  //                                             Text(
                                  //                                           '${cubit.getQuantity(cubit.productsshow[index].id)}',
                                  //                                           style:
                                  //                                               TextStyle(fontSize: 10),
                                  //                                         ),
                                  //                                       ),
                                  //                                       IconButton(
                                  //                                         onPressed:
                                  //                                             () {
                                  //                                           cubit.increaseQuantity(
                                  //                                             cubit.productsshow[index].id,
                                  //                                           );
                                  //                                         },
                                  //                                         icon: Icon(
                                  //                                             Icons.add,
                                  //                                             size: 12),
                                  //                                       ),
                                  //                                     ],
                                  //                                   ),
                                  //                                 ),
                                  //                                 SizedBox(
                                  //                                     height:
                                  //                                         1),
                                  //                                 Expanded(
                                  //                                   child:
                                  //                                       InkWell(
                                  //                                     onTap:
                                  //                                         () {
                                  //                                       cubit
                                  //                                           .addToupdatedProduct(
                                  //                                         ProductUpdate(
                                  //                                           id: cubit.productsshow[index].id,
                                  //                                           amount:
                                  //                                               cubit.getQuantity(cubit.productsshow[index].id),
                                  //                                         ),
                                  //                                       );
                                  //                                     },
                                  //                                     child:
                                  //                                         Container(
                                  //                                       width: double
                                  //                                           .infinity,
                                  //                                       decoration:
                                  //                                           BoxDecoration(
                                  //                                         color:
                                  //                                             AppConstants.orangeColor,
                                  //                                         borderRadius:
                                  //                                             BorderRadius.vertical(
                                  //                                           bottom:
                                  //                                               Radius.circular(12),
                                  //                                         ),
                                  //                                       ),
                                  //                                       child:
                                  //                                           Padding(
                                  //                                         padding: const EdgeInsets
                                  //                                             .symmetric(
                                  //                                             vertical: 8.0),
                                  //                                         child:
                                  //                                             Center(
                                  //                                           child:
                                  //                                               Text(
                                  //                                             'إضافة ',
                                  //                                             style: TextStyle(color: Colors.white),
                                  //                                           ),
                                  //                                         ),
                                  //                                       ),
                                  //                                     ),
                                  //                                   ),
                                  //                                 ),
                                  //                               ],
                                  //                             ),
                                  //                           ),
                                  //                         ),
                                  //                       );
                                  //                     },
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             actions: [
                                  //               TextButton(
                                  //                 onPressed: () {
                                  //                   Navigator.of(context)
                                  //                       .pop(); // إغلاق الحوار
                                  //                 },
                                  //                 child: Text('إلغاء'),
                                  //               ),
                                  //               TextButton(
                                  //                 onPressed: () {
                                  //                   cubit.updateProducts(
                                  //                       appointement,
                                  //                       '${cubit.date.year}-${cubit.date.month}-${cubit.date.day}');
                                  //                   Navigator.of(context)
                                  //                       .pop(); // إغلاق الحوار
                                  //                 },
                                  //                 child: Text('موافق'),
                                  //               ),
                                  //             ],
                                  //           );
                                  //         },
                                  //       );
                                  //     },
                                  //     icon: Icon(Icons.edit)),
                       