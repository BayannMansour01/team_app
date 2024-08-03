import 'package:dartz/dartz.dart';
import 'package:team_app/core/errors/failure.dart';
import 'package:team_app/features/appointemtsPage/data/models/allProductResponse.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/appointemtsPage/data/models/response_done.dart';
import 'package:team_app/features/homepage/data/message_model.dart';
import 'package:team_app/features/homepage/data/models/products_update_body.dart';
import 'package:team_app/features/homepage/data/models/user_model.dart';
import 'package:team_app/features/RecordsScreen/data/models/record_model.dart';

abstract class homeRepo {
  Future<Either<Failure, UserModel>> fetchuserinfo();

}
