import 'package:dartz/dartz.dart';
import 'package:team_app/core/errors/failure.dart';

import 'package:team_app/features/RecordsScreen/data/models/record_model.dart';

abstract class RecordRepo {
  Future<Either<Failure, List<Record>>> fetchrecords();
}
