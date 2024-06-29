import 'package:dartz/dartz.dart';
import 'package:team_app/core/errors/failure.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/homepage/data/models/user_model.dart';
import 'package:team_app/features/homepage/data/models/record_model.dart';

abstract class homeRepo {
  Future<Either<Failure, UserModel>> fetchuserinfo();
  Future<Either<Failure, List<Record>>> fetchrecords();
}
