import 'package:team_app/core/constants.dart';
import 'package:team_app/core/func/custom_progress_indicator.dart';
import 'package:team_app/core/func/custom_snack_bar.dart';
import 'package:team_app/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointement_cubit.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointements_state.dart';
import 'package:team_app/features/appointemtsPage/presentation/screen/widgets/custom_stepper.dart';

class AppointementsBody extends StatelessWidget {
  const AppointementsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AppointementsCubit>(context);

    return BlocConsumer<AppointementsCubit, AppointementsState>(
      listener: (context, state) async {
        // if (state is! AppointementsSuccess) {
        //   CustomProgressIndicator.showProgressIndicator(context);
        // }
        //else {
        //   if (CustomProgressIndicator.isOpen) {
        //     context.pop();
        //   }
        //   if (state is AppointementsFailure) {
        //     CustomSnackBar.showErrorSnackBar(context, message: "error");
        //   }
        // }
      },
      builder: (context, state) {
        return ListView.builder(
          itemCount: cubit.appointements.length,
          itemBuilder: (context, index) {
            return AppointementItem(cubit,
                Appointement: cubit.appointements[index]);
          },
        );
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
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Appointement.typeId == '1'
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
              CustomStepper(Appointement),
            ],
          ),
        ),
      ),
    );
  }
}
