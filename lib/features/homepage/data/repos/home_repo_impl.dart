import 'dart:developer';

import 'package:team_app/core/constants.dart';
import 'package:team_app/core/errors/failure.dart';
import 'package:team_app/core/utils/cache_helper.dart';
import 'package:team_app/core/utils/dio_helper.dart';
import 'package:team_app/features/appointemtsPage/data/models/response_done.dart';
import 'package:team_app/features/homepage/data/models/products_update_body.dart';

import 'package:team_app/features/RecordsScreen/data/models/record_model.dart';
// import 'package:team_app/features/homepage/data/models/product_model.dart';
// import 'package:team_app/features/homepage/data/models/record_model.dart';
import 'package:team_app/features/homepage/data/models/user_model.dart';
import 'package:team_app/features/homepage/data/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends homeRepo {
  @override
  Future<Either<Failure, UserModel>> fetchuserinfo() async {
    try {
      Response data = await DioHelper.getData(
          url: AppConstants.me, token: CacheHelper.getData(key: 'Token'));
      log("data:  $data");

      UserModel user = UserModel.fromJson(data.data);
      return right(user);
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

  // @override
  // Future<Either<Failure, LogoutResponse>> Loguot(
  //     {required String token}) async {
  //   try {
  //     var response = await DioHelper.getData(
  //       url: 'auth/logout',
  //       token: token,
  //     );
  //     log(response.toString());

  //     return right(LogoutResponse.fromJson(response.data));
  //   } catch (ex) {
  //     log('\nException: there is an error in logout method');
  //     log('\n$ex');
  //     if (ex is DioException) {
  //       return left(ServerFailure.fromDioException(ex));
  //     }
  //     return left(ServerFailure(ex.toString()));
  //   }
  // }
}
