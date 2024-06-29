import 'dart:developer';

import 'package:team_app/core/constants.dart';
import 'package:team_app/core/errors/failure.dart';
import 'package:team_app/core/utils/cache_helper.dart';
import 'package:team_app/core/utils/dio_helper.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:team_app/core/errors/failure.dart';
import 'package:team_app/features/appointemtsPage/data/models/allProductResponse.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/appointemtsPage/data/models/response_done.dart';
import 'package:team_app/features/appointemtsPage/data/repos/appointements_repo.dart';

class AppointementsRepoImpl extends AppointementRepo {
  Future<Either<Failure, List<Appointment>>> fetchApointements(
      String id) async {
    try {
      Response data = await DioHelper.getData(
          url: "${AppConstants.fetchApointemnt}$id",
          token: CacheHelper.getData(key: 'Token'));
      log("data:  $data");
      List<Appointment> appointments = [];
      for (var item in data.data['Appointments:']) {
        appointments.add(Appointment.fromJson(item));
      }
      return right(appointments);
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

  @override
  Future<Either<Failure, BasicResponse>> makeDone(int id, String desc) async {
    try {
      log("${desc}");
      final data = await DioHelper.postData(
        url: "${AppConstants.makeComplete}$id",
        token: CacheHelper.getData(key: 'Token'),
        body: {
          "desc": "$desc",
        },
      );
      log("makedone:  $data");
      return right(BasicResponse.fromJson(data.data));
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

  @override
  Future<Either<Failure, List<Productforshow>>> fetchAllproduct() async {
    try {
      Response data = await DioHelper.getData(
          url: "${AppConstants.fetchAllProduct}",
          token: CacheHelper.getData(key: 'Token'));
      log("data:  $data");
      List<Productforshow> appointments = [];
      for (var item in data.data['products']) {
        appointments.add(Productforshow.fromJson(item));
      }
      return right(appointments);
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
