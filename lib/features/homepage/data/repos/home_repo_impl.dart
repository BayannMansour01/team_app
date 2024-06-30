import 'dart:developer';

import 'package:team_app/core/constants.dart';
import 'package:team_app/core/errors/failure.dart';
import 'package:team_app/core/utils/cache_helper.dart';
import 'package:team_app/core/utils/dio_helper.dart';
import 'package:team_app/features/appointemtsPage/data/models/allProductResponse.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/homepage/data/models/product_update_response.dart';
import 'package:team_app/features/homepage/data/models/products_update_body.dart';

import 'package:team_app/features/homepage/data/models/record_model.dart';
import 'package:team_app/features/homepage/data/models/logout_message_model.dart';
// import 'package:team_app/features/homepage/data/models/product_model.dart';
// import 'package:team_app/features/homepage/data/models/record_model.dart';
import 'package:team_app/features/homepage/data/models/user_model.dart';
import 'package:team_app/features/homepage/data/repos/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl extends homeRepo {
  @override
  // @override
  // Future<Either<Failure, List<System>>> fetchProposedSystems() async {
  //   try {
  //     Response data = await DioHelper.getData(
  //         url: AppConstants.getAllProposedSystem,
  //         token: CacheHelper.getData(key: 'Token'));
  //     log("data:  $data");
  //     List<System> proposedSystem = [];
  //     for (var item in data.data['systems']) {
  //       proposedSystem.add(System.fromJson(item));
  //     }
  //     return right(proposedSystem);
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

  // @override
  // Future<Either<Failure, List<Product>>> fetchPanales() async {
  //   try {
  //     Response data = await DioHelper.getData(
  //         url: AppConstants.showAllPanales,
  //         token: CacheHelper.getData(key: 'Token'));
  //     log("data:  $data");
  //     List<Product> Products = [];
  //     for (var item in data.data['products']) {
  //       Products.add(Product.fromJson(item));
  //     }
  //     return right(Products);
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

  // @override
  // Future<Either<Failure, List<Product>>> fetchbatteries() async {
  //   try {
  //     Response data = await DioHelper.getData(
  //         url: AppConstants.showAllbatteries,
  //         token: CacheHelper.getData(key: 'Token'));
  //     log("data:  $data");
  //     List<Product> Products = [];
  //     for (var item in data.data['products']) {
  //       Products.add(Product.fromJson(item));
  //     }
  //     return right(Products);
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

  // @override
  // Future<Either<Failure, List<Product>>> fetchInverters() async {
  //   try {
  //     Response data = await DioHelper.getData(
  //         url: AppConstants.showAllInverters,
  //         token: CacheHelper.getData(key: 'Token'));
  //     log("data:  $data");
  //     List<Product> Products = [];
  //     for (var item in data.data['products']) {
  //       Products.add(Product.fromJson(item));
  //     }
  //     return right(Products);
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

  // Future<Either<Failure, List<Product>>> fetchProducts() async {
  //   try {
  //     Response data = await DioHelper.getData(
  //         url: AppConstants.showAllProducts,
  //         token: CacheHelper.getData(key: 'Token'));
  //     log("data:  $data");
  //     List<Product> Products = [];
  //     for (var item in data.data['products']) {
  //       Products.add(Product.fromJson(item));
  //     }
  //     return right(Products);
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

  @override
  Future<Either<Failure, List<Record>>> fetchrecords() async {
    try {
      Response data = await DioHelper.getData(
          url: AppConstants.fetchAllRecords,
          token: CacheHelper.getData(key: 'Token'));
      log("recor:  $data");
      List<Record> records = [];
      for (var item in data.data['records']) {
        records.add(Record.fromJson(item));
      }
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

  @override
  Future<Either<Failure, List<ProductForResponse>>> updateProducts(
      ProductsResponsebody body) async {
    try {
      final data = await DioHelper.postData(
        url: "${AppConstants.updateProduct}$id",
        token: CacheHelper.getData(key: 'Token'),
        body: body.toJson(),
      );
      List<ProductForResponse> list = [];
      for (var item in data.data["Order updated successfully"]["products"]) {
        list.add(ProductForResponse.fromJson(item));
      }
      return right(list);
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
