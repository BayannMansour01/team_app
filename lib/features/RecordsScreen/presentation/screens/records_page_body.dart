import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:team_app/core/constants.dart';
import 'package:team_app/core/utils/service_locator.dart';
import 'package:team_app/features/RecordsScreen/data/repo/records_repo_impl.dart';
import 'package:team_app/features/RecordsScreen/presentation/manager/cubit/record_cubit.dart';
import 'package:team_app/features/RecordsScreen/presentation/screens/recordDetailsPage.dart';

class RecordsPageBody extends StatelessWidget {
  const RecordsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecordCubit(
        getIt.get<RecordsRepoImpl>(),
      )..fetchAllIRecords(),
      child: BlocConsumer<RecordCubit, RecordState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<RecordCubit>(context);

          if (state is GetRecordsLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: AppConstants.blueColor,
              ),
            );
          } else if (state is GetRecordsFailure) {
            return Center(
              child: Text('فشل في جلب السجلات: ${state.errMessage}'),
            );
          } else if (state is GetRecordsSuccess) {
            final records = cubit.records;
            if (records == null || records.isEmpty) {
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    "السجلات",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: Center(
                  child: Text('لا توجد سجلات لعرضها'),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    "السجلات",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                body: AnimationLimiter(
                  child: ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      final record = records[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RecordDetailsPage(record: record),
                            ),
                          );
                        },
                        child: AnimationConfiguration.staggeredList(
                          position: index,
                          delay: Duration(milliseconds: 100),
                          child: SlideAnimation(
                            duration: Duration(milliseconds: 2500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            horizontalOffset: 30,
                            verticalOffset: 300.0,
                            child: FlipAnimation(
                              duration: Duration(milliseconds: 3000),
                              curve: Curves.fastLinearToSlowEaseIn,
                              flipAxis: FlipAxis.y,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('اسم الزبون   ${record.user.name}',
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            'رقم التواصل ${record.user.phone}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          } else {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "السجلات",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: Center(
                child: CircularProgressIndicator(
                  color: AppConstants.blueColor,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
