import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_app/core/utils/service_locator.dart';
import 'package:team_app/features/homepage/data/repos/home_repo_impl.dart';
import 'package:team_app/features/homepage/presentation/manager/cubit/home_page_cubit.dart';
import 'package:team_app/features/homepage/presentation/manager/cubit/home_page_state.dart';

class RecordsPageBody extends StatelessWidget {
  const RecordsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          homepageCubit(getIt.get<HomeRepoImpl>())..fetchAllIRecords(),
      child: BlocConsumer<homepageCubit, homepageState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<homepageCubit>(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "السجلات",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  child: Text('{cubit.records[index]}'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
