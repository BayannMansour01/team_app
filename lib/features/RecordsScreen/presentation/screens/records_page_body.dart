import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:team_app/core/utils/service_locator.dart';
import 'package:team_app/features/RecordsScreen/data/repo/records_repo_impl.dart';
import 'package:team_app/features/RecordsScreen/presentation/manager/cubit/record_cubit.dart';
import 'package:team_app/features/RecordsScreen/presentation/screens/recordDetailsPage.dart';

class RecordsPageBody extends StatelessWidget {
  const RecordsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RecordCubit(getIt.get<RecordsRepoImpl>())..fetchAllIRecords(),
      child: BlocConsumer<RecordCubit, RecordState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<RecordCubit>(context);

          if (state is GetRecordsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetRecordsFailure) {
            return Center(
                child: Text('Failed to fetch records: ${state.errMessage}'));
          } else if (state is GetRecordsSuccess) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "السجلات",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: AnimationLimiter(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  physics:
                      BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  itemCount: cubit.records.length,
                  itemBuilder: (context, index) {
                    final record = cubit.records[index];
                    return InkWell(
                      onTap:() {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecordDetailsPage(record: record),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('اسم المستخدم: ${record.user.name}',
                                        //  style: TextStyle(fontWeight: FontWeight.bold)
                                          ),
                                      Text('الرقم: ${record.user.phone}'),
                                    
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
          } else {
            return Center(child: Text('No records found'));
          }
        },
      ),
    );
  }
}
