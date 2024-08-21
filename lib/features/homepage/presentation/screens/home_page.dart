import 'package:team_app/core/utils/service_locator.dart';
import 'package:team_app/features/homepage/data/repos/home_repo_impl.dart';
import 'package:team_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:team_app/features/homepage/presentation/screens/widgets/home_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homepageCubit(
        getIt.get<HomeRepoImpl>(),
      ),
      child: HomePageBody(),
    );
  }
}
