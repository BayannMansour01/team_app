import 'package:easy_stepper/easy_stepper.dart';
import 'package:team_app/core/constants.dart';
import 'package:team_app/core/func/custom_progress_indicator.dart';
import 'package:team_app/core/func/custom_snack_bar.dart';
import 'package:team_app/core/utils/api/apis.dart';
import 'package:team_app/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_app/core/utils/cache_helper.dart';
import 'package:team_app/core/utils/size_config.dart';
import 'package:team_app/core/widgets/custom_text_field.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointement_cubit.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointements_state.dart';
import 'package:team_app/features/homepage/data/models/user_model.dart';
import 'package:team_app/features/homepage/presentation/manager/cubit/home_page_state.dart';
import 'package:team_app/features/homepage/presentation/screens/widgets/custom_drawer.dart';
import 'package:team_app/features/appointemtsPage/presentation/screen/widgets/custom_stepper.dart';
import 'package:team_app/features/homepage/data/logout_service.dart';
import 'package:team_app/features/homepage/presentation/screens/widgets/custom_drawer.dart';

class AppointementsBody extends StatelessWidget {
  const AppointementsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppointementsCubit>(context);
    return BlocConsumer<AppointementsCubit, AppointementsState>(
      listener: (context, state) async {},
      builder: (context, state) {
        return Scaffold(
            drawer: cubit.userInfo != null
                ? CustomDrawer.getCustomDrawer(
                    userModel: cubit.userInfo!,
                    context,
                    scaffoldKey: cubit.scaffoldKey,
                  )
                : null,
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () async {
                      // CustomDialog.showProgressBar(context);
                      // await APIs.updateActiveStatus(false);
                      await APIs.auth.signOut().then(
                        (value) async {
                          (await LogOutService.logout(
                            token: await CacheHelper.getData(key: 'Token'),
                          ))
                              .fold(
                            (failure) {
                              CustomSnackBar.showErrorSnackBar(
                                context,
                                message:
                                    'Something Went Wrong, Please Try Again',
                              );
                            },
                            (success) async {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('تم تسجيل الخروج بنجاح!')),
                              );

                              await CacheHelper.deletData(key: 'Token');
                              context.pushReplacement(AppRouter.kLoginView);
                              //  Navigator.popAndPushNamed(context, LoginView.route);
                            },
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.exit_to_app_sharp))
              ],
              centerTitle: true,
              title: Text(
                "المواعيد",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: state is! AppointementsLoading
                ? cubit.appointements.length == 0
                    ? Center(
                        child: Text("لا يوجد مواعيد مسندة لك !"),
                      )
                    : ListView.builder(
                        itemCount: cubit.appointements
                            .where((appointment) => appointment.statusId != 4)
                            .length,
                        itemBuilder: (context, index) {
                          var filteredAppointments = cubit.appointements
                              .where((appointment) => appointment.statusId != 4)
                              .toList();

                          return filteredAppointments.length > 0
                              ? AppointementItem(
                                  cubit,
                                  Appointement: filteredAppointments[index],
                                )
                              : Center(
                                  child: Text("لا يوجد مواعيد مسندة لك !"),
                                );
                        },
                      )
                : Center(child: CircularProgressIndicator()));
      },
    );
  }
}

class AppointementItem extends StatelessWidget {
  final Appointment Appointement;
  AppointementsCubit cubit;
  AppointementItem(
    this.cubit, {
    super.key,
    required this.Appointement,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(
          AppRouter.kAppointemntsDetailesView,
          extra: Appointement,
        );
      },
      child: Card(
        color: Color.fromARGB(255, 232, 243, 248),
        margin: EdgeInsets.all(10.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Appointement.typeId == 1
                        ? 'صيانة منظومة '
                        : "تركيب منظومة ",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.blueColor),
                  ),
                  Text(" بداية التنفيذ ${Appointement.startTime}"),
                ],
              ),
              SizedBox(height: 5.0),
              EasyStepper(
                lineStyle: LineStyle(
                  lineLength: 80,
                  lineSpace: 0,
                  lineType: LineType.normal,
                  defaultLineColor: Colors.white,
                  finishedLineColor: Appointement.statusId > 2
                      ? Colors.orange
                      : Colors
                          .white, // تلوين الخط حتى قيد الكشف عند statusId > 1
                ),
                activeStep: Appointement.statusId - 1,
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
                        backgroundColor: Appointement.statusId >= 0
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
                        backgroundColor: Appointement.statusId > 1 &&
                                !cubit.isAppointmentInFuture(
                                    Appointement.startTime)
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
                        backgroundColor: Appointement.statusId > 2
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
                              actionsOverflowDirection: VerticalDirection.up,
                              actionsOverflowAlignment:
                                  OverflowBarAlignment.end,
                              title: const Text(' أضف تشخيص و سعر متوقع'),
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
                                    keyboardType: TextInputType.number,
                                    onChanged: (p1) {
                                      cubit.otherPrice = int.tryParse(p1) ?? 0;
                                      // log('${int.tryParse(p1)}');
                                    },
                                    labelText: 'السعر ',
                                    hintText: ' السعر الإضافي .. ',
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // إغلاق الحوار
                                  },
                                  child: const Text(
                                    'إلغاء',
                                    style: TextStyle(
                                        color: AppConstants.blueColor),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    cubit.makeDone(Appointement);
                                  },
                                  child: Text(
                                    'موافق',
                                    style: TextStyle(
                                        color: AppConstants.blueColor),
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
                          backgroundColor: Appointement.statusId > 3
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
            ],
          ),
        ),
      ),
    );
  }
}
