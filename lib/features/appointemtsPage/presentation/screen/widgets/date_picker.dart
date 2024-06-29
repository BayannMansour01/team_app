import 'package:flutter/material.dart';

import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

class customDatePicker extends StatefulWidget {
  customDatePicker({super.key});
  @override
  State<customDatePicker> createState() => _customDatePickerState();
}

class _customDatePickerState extends State<customDatePicker> {
  DateTime _selectedDate = DateTime.now();
  DateTime _firstDate = DateTime(2020);
  DatePeriod _selectedPeriod = DatePeriod(DateTime.now(), DateTime.now());
  final DateTime _lastDate = DateTime(2023);
  @override
  Widget build(BuildContext context) {
    if (_selectedDate.isBefore(_firstDate) ||
        _selectedDate.isAfter(_lastDate)) {
      _selectedDate = _firstDate;
    }
    return Container(
        child: dp.DayPicker.single(
      selectedDate: _selectedDate,
      onChanged: (date) {
        setState(() {
          _selectedDate = date;
        });
      },
      firstDate: _firstDate,
      lastDate: _lastDate,
      datePickerStyles: dp.DatePickerRangeStyles(
        selectedSingleDateDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        defaultDateTextStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        currentDateStyle: TextStyle(color: Colors.orange),
      ),
      datePickerLayoutSettings: dp.DatePickerLayoutSettings(
        maxDayPickerRowCount: 1,
        showPrevMonthEnd: true,
        showNextMonthStart: true,
      ),
    ));
  }
}
