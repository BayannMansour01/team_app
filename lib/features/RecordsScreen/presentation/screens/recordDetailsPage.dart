import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:team_app/core/constants.dart';
import 'package:team_app/features/RecordsScreen/data/models/record_model.dart';
class RecordDetailsPage extends StatelessWidget {
  final Record record;

  RecordDetailsPage({required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل السجل',
          style: TextStyle(color: Colors.white),)
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(context, 'المستخدم',),
                _buildUserInfo(context),
                Divider(),
                _buildSectionTitle(context, 'الطلب'),
                _buildOrderInfo(context),
                Divider(),
                _buildSectionTitle(context, 'الموعد'),
                _buildAppointmentInfo(context),
                Divider(),
                _buildSectionTitle(context, 'التشخيص'),
                _buildDiagnoseInfo(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppConstants.blueColor,
            ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('الاسم', record.user.name),
        _buildInfoRow('البريد الإلكتروني', record.user.email),
        _buildInfoRow('رقم الهاتف', record.user.phone),
      ],
    );
  }

  Widget _buildOrderInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('موقع الطلب', record.order.location),
      ],
    );
  }

  Widget _buildAppointmentInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('وقت البدء', DateFormat.yMMMd().format(record.appointment.startTime)),
        _buildInfoRow('وقت الانتهاء', DateFormat.yMMMd().format(record.appointment.endTime)),
       // _buildInfoRow('فريق العمل', record.appointment.teamId.toString()),
      ],
    );
  }

  Widget _buildDiagnoseInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: record.diagnose.map((diag) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Card(
            color: Colors.blue[50],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow('التشخيص', diag.desc),
                  _buildInfoRow('النوع', diag.typeId.toString()),
                  _buildInfoRow('التاريخ', DateFormat.yMMMd().format(diag.date)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
