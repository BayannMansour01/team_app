import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:team_app/core/constants.dart';
import 'package:team_app/core/errors/failure.dart';

import 'package:team_app/features/RecordsScreen/data/models/record_model.dart';
import 'package:team_app/core/utils/cache_helper.dart';
import 'package:team_app/core/utils/dio_helper.dart';
import 'package:team_app/features/RecordsScreen/data/repo/records_repo.dart';

class RecordsRepoImpl extends RecordRepo {
  // @override
  // Future<Either<Failure, List<Record>>> fetchrecords() async {
  //   try {
  //     Response data = await DioHelper.getData(
  //         url: AppConstants.fetchAllRecords,
  //         token: CacheHelper.getData(key: 'Token'));
  //     log("records:  $data");
  //     List<Record> records = [];
  //     for (var item in data.data['records']) {
  //       records.add(Record.fromJson(item));
  //     }
  //     return right(records);
  //   } on Exception catch (e) {
  //     if (e is DioException) {
  //       return left(
  //         ServerFailure.fromDioException(e),
  //       );
  //     }
  //     return left(
  //       ServerFailure(
  //         e.toString(),
  //       ),
  //     );
  //   }
  // }
  Future<Either<Failure, List<Record>>> fetchrecords() async {
    try {
      Response data = await DioHelper.getData(
          url: AppConstants.fetchAllRecords,
          token: CacheHelper.getData(key: 'Token'));
      log("records:  $data");

      Map<int, Record> uniqueRecordsMap = {}; // لتخزين السجلات على أساس userId

      for (var item in data.data['records']) {
        Record newRecord = Record.fromJson(item);

        if (uniqueRecordsMap.containsKey(newRecord.userId)) {
          // إذا كان هناك سجل بالفعل لهذا المستخدم، قم بدمج التشخيصات
          Record existingRecord = uniqueRecordsMap[newRecord.userId]!;
          if (newRecord.diagnose != null) {
            existingRecord.diagnose!.addAll(newRecord.diagnose!);
          }
        } else {
          // إذا لم يكن هناك سجل لهذا المستخدم، قم بإضافة السجل إلى الـ Map
          uniqueRecordsMap[newRecord.userId] = newRecord;
        }
      }

      // تحويل الـ Map إلى قائمة من السجلات
      List<Record> records = uniqueRecordsMap.values.toList();

      return right(records);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(
          ServerFailure.fromDioException(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}
