import 'package:dartz/dartz.dart';
import 'package:team_app/core/errors/failure.dart';
import 'package:team_app/features/appointemtsPage/data/models/allProductResponse.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/appointemtsPage/data/models/response_done.dart';
import 'package:team_app/features/homepage/data/models/products_update_body.dart';
import 'package:team_app/features/homepage/data/models/user_model.dart';

abstract class AppointementRepo {
  Future<Either<Failure, UserModel>> fetchuserinfo();

  Future<Either<Failure, List<Appointment>>> fetchApointements(String id);
  Future<Either<Failure, List<Productforshow>>> fetchAllproduct();
  Future<Either<Failure, BasicResponse>> makeDone(
      int id, String desc, int otherPrice);
  Future<Either<Failure, BasicResponse>> updateProducts(
    int appointmentId,
    List<ProductUpdate> products,
    String endTime,
  );
}
