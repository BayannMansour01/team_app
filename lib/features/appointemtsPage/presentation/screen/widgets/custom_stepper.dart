import 'dart:developer';

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_app/core/widgets/custom_text_field.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointement_cubit.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointements_state.dart';
import 'package:team_app/features/appointemtsPage/presentation/screen/widgets/appointments_body.dart';

class CustomStepper extends StatelessWidget {
  // AppointementsCubit cubit;
  Appointment item;
  // int statusID;
  CustomStepper(this.item, {super.key});
  // int activeStep = 0;
  // // int activeStep2 = 0;
  // // int reachedStep = 0;
  // // int upperBound = 5;
  // // double progress = 0.2;
  // Set<int> reachedSteps = <int>{0, 2, 4, 5};
// خريطة لتحويل النصوص إلى مؤشرات رقمية
  Map<String, int> statusMap = {
    "waiting": 0,
    "Detect": 1,
    "Execute": 2,
    "Done": 3,
  };

  @override
  Widget build(BuildContext context) {
    // String desc;
    final int statusIndex = statusMap[item.order.state] ?? 0;

    final cubit = BlocProvider.of<AppointementsCubit>(context);
    return BlocConsumer<AppointementsCubit, AppointementsState>(
      listener: (context, state) {},
      builder: (context, state) {
        return EasyStepper(
          lineStyle: LineStyle(
            lineLength: 80,
            lineSpace: 0,
            lineType: LineType.normal,
            defaultLineColor: Colors.white,
            finishedLineColor: Colors.orange,
          ),
          activeStep: statusIndex,
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
                  backgroundColor:
                      statusIndex >= 0 ? Colors.orange : Colors.white,
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
                  backgroundColor:
                      statusIndex >= 1 ? Colors.orange : Colors.white,
                ),
              ),
              title: 'قيد التحقق',
              topTitle: true,
            ),
            EasyStep(
              customStep: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 7,
                  backgroundColor:
                      statusIndex >= 2 ? Colors.orange : Colors.white,
                ),
              ),
              title: 'قيد التنفيذ',
            ),
            EasyStep(
              customStep: InkWell(
                onTap:
                    // statusIndex == 2
                    //     ?
                    () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(' أضف تشخيص و سعر متوقع'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextField(
                              onChanged: (p0) {
                                cubit.desc = p0;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              keyboardType: TextInputType.number,
                              onChanged: (p1) {
                                cubit.otherPrice = p1;
                              },
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // إغلاق الحوار
                            },
                            child: Text('إلغاء'),
                          ),
                          TextButton(
                            onPressed: () {
                              log("item id ${item.id}");
                              cubit.makeDone(item.id);
                              Navigator.of(context).pop(); // إغلاق الحوار
                            },
                            child: Text('موافق'),
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
                    backgroundColor:
                        statusIndex >= 3 ? Colors.orange : Colors.white,
                  ),
                ),
              ),
              topTitle: true,
              title: 'تم الإنجاز',
            ),
          ],
        );
      },
    );
  }
}
