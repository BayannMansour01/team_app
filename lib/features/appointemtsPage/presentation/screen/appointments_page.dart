import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_app/core/utils/cache_helper.dart';
import 'package:team_app/core/utils/service_locator.dart';
import 'package:team_app/features/appointemtsPage/data/repos/appointements_repo_impl.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointement_cubit.dart';

import 'widgets/appointments_body.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return AppointementsCubit(getIt.get<AppointementsRepoImpl>())
          ..fetchAllappointements('${CacheHelper.getData(key: "UserID")}');
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "المواعيد",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: AppointementsBody(),
      ),
    );
  }
}
