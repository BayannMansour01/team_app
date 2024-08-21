import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_app/core/func/custom_snack_bar.dart';
import 'package:team_app/core/utils/api/apis.dart';
import 'package:team_app/core/utils/app_router.dart';
import 'package:team_app/core/utils/cache_helper.dart';
import 'package:team_app/core/utils/service_locator.dart';
import 'package:team_app/features/appointemtsPage/data/repos/appointements_repo_impl.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointement_cubit.dart';
import 'package:team_app/features/homepage/data/logout_service.dart';
import 'package:team_app/features/homepage/presentation/screens/widgets/custom_drawer.dart';

import 'widgets/appointments_body.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // final cubit = BlocProvider.of<AppointementsCubit>(context);
    return BlocProvider(
        create: (context) {
          return AppointementsCubit(getIt.get<AppointementsRepoImpl>())
            ..fetchUserInfo()
            ..fetchAllappointements('${CacheHelper.getData(key: "UserID")}');
        },
        child: AppointementsBody());
  }
}
