// import 'dart:developer';

// import 'package:easy_stepper/easy_stepper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:team_app/core/constants.dart';
// import 'package:team_app/core/widgets/custom_text_field.dart';
// import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
// import 'package:team_app/features/appointemtsPage/presentation/manager/Appointement_cubit.dart';
// import 'package:team_app/features/appointemtsPage/presentation/manager/Appointements_state.dart';
// import 'package:team_app/features/appointemtsPage/presentation/screen/widgets/appointments_body.dart';

// class CustomStepper extends StatelessWidget {
//   Appointment item;

//   CustomStepper(this.item, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     // String desc;
//     return BlocConsumer<AppointementsCubit, AppointementsState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         final cubit = BlocProvider.of<AppointementsCubit>(context);

//         // final int statusIndex = cubit.statusMap[item.order.state] ?? 0;
//         log(item.order.state);
//         return EasyStepper(
//           lineStyle: const LineStyle(
//             lineLength: 80,
//             lineSpace: 0,
//             lineType: LineType.normal,
//             defaultLineColor: Colors.white,
//             finishedLineColor: Colors.orange,
//           ),
//           activeStep: cubit.status,
//           activeStepTextColor: Colors.black87,
//           finishedStepTextColor: Colors.black87,
//           internalPadding: 0,
//           showLoadingAnimation: false,
//           stepRadius: 8,
//           showStepBorder: false,
//           steps: [
//             EasyStep(
//               customStep: CircleAvatar(
//                 radius: 8,
//                 backgroundColor: Colors.white,
//                 child: CircleAvatar(
//                   radius: 7,
//                   backgroundColor: cubit.statusMap[item.order.state]! >= 0
//                       ? Colors.orange
//                       : Colors.white,
//                 ),
//               ),
//               title: 'قيد الانتظار',
//             ),
//             EasyStep(
//               customStep: CircleAvatar(
//                 radius: 8,
//                 backgroundColor: Colors.white,
//                 child: CircleAvatar(
//                   radius: 7,
//                   backgroundColor: cubit.statusMap[item.order.state]! >= 1
//                       ? Colors.orange
//                       : Colors.white,
//                 ),
//               ),
//               title: 'قيد الكشف',
//               topTitle: true,
//             ),
//             EasyStep(
//               customStep: CircleAvatar(
//                 radius: 8,
//                 backgroundColor: Colors.white,
//                 child: CircleAvatar(
//                   radius: 7,
//                   backgroundColor: cubit.statusMap[item.order.state]! >= 2
//                       ? Colors.orange
//                       : Colors.white,
//                 ),
//               ),
//               title: 'قيد التنفيذ',
//             ),
//             EasyStep(
//               customStep: InkWell(
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) {
//                       return AlertDialog(
//                         actionsOverflowDirection: VerticalDirection.up,
//                         actionsOverflowAlignment: OverflowBarAlignment.end,
//                         title: const Text(' أضف تشخيص و سعر متوقع'),
//                         content: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             CustomTextField(
//                               width: double.infinity,
//                               hintText: "أدخل ملاحظاتك ... ",
//                               labelText: "التشخيص ",
//                               onChanged: (p0) {
//                                 cubit.desc = p0;
//                               },
//                             ),
//                             const SizedBox(
//                               height: 15,
//                             ),
//                             CustomTextField(
//                               width: double.infinity,
//                               keyboardType: TextInputType.number,
//                               onChanged: (p1) {
//                                 cubit.otherPrice = p1;
//                               },
//                               labelText: 'السعر ',
//                               hintText: ' السعر الإضافي .. ',
//                             ),
//                           ],
//                         ),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop(); // إغلاق الحوار
//                             },
//                             child: const Text(
//                               'إلغاء',
//                               style: TextStyle(color: AppConstants.blueColor),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               cubit.makeDone(item.id);
//                               Navigator.of(context).pop(); // إغلاق الحوار
//                             },
//                             child: Text(
//                               'موافق',
//                               style: TextStyle(color: AppConstants.blueColor),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//                 // : null
//                 ,
//                 child: CircleAvatar(
//                   radius: 8,
//                   backgroundColor: Colors.white,
//                   child: CircleAvatar(
//                     radius: 7,
//                     backgroundColor: cubit.statusMap[item.order.state]! >= 3
//                         ? Colors.orange
//                         : Colors.white,
//                   ),
//                 ),
//               ),
//               topTitle: true,
//               title: 'تم الإنجاز',
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
