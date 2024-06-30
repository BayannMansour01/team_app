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

          if (state is GetRecordsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GetRecordsFailure) {
            return Center(child: Text('Failed to fetch records: ${state.errMessage}'));
          } else if (state is GetRecordsSuccess) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "السجلات",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: ListView.builder(
                itemCount: cubit.records.length,
                itemBuilder: (context, index) {
                  final record = cubit.records[index];
                
                  if (record.order.state != "done") {
                    return Container(); 
           
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('اسم المستخدم: ${record.user.name}', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('رقم المستخدم: ${record.user.phone}'),
                            SizedBox(height: 8),
                            Text('الطلب:', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('الصورى: ${record.order.image ?? 'No Image'}'),
                            Text('الوصف: ${record.order.desc ?? 'No Description'}'),
                            // Text('Total Voltage: ${record.order.totalVoltage ?? 'N/A'}'),
                            // Text('Charge Hours: ${record.order.chargeHours ?? 'N/A'}'),
                            Text('الموقع: ${record.order.location}'),
                            Text('حالة الطلب : ${record.order.state}'),
                            // Text('Type ID: ${record.order.typeId}'),
                            // Text('User ID: ${record.order.userId}'),
                            // Text('Created At: ${record.order.createdAt}'),
                            // Text('Updated At: ${record.order.updatedAt}'),
                            SizedBox(height: 8),
                            Text('الحجز:', style: TextStyle(fontWeight: FontWeight.bold)),
                            // Text('Start Time: ${record.appointment.startTime}'),
                            Text('تاريخ الانتهاء: ${record.appointment?.endTime ?? 'No End Time'}'),
                            // Text('Team ID: ${record.appointment.teamId}'),
                            // Text('Order ID: ${record.appointment.orderId}'),
                            // Text('User ID: ${record.appointment.userId}'),
                            // Text('Type ID: ${record.appointment.typeId}'),
                            // Text('Status ID: ${record.appointment.statusId}'),
                            // Text('Created At: ${record.appointment.createdAt}'),
                            // Text('Updated At: ${record.appointment.updatedAt}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
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
