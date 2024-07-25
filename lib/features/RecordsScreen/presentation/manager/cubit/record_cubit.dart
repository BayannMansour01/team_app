import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:team_app/features/RecordsScreen/data/repo/records_repo.dart';

import 'package:team_app/features/RecordsScreen/data/models/record_model.dart';
part 'record_state.dart';

class RecordCubit extends Cubit<RecordState> {
  final RecordRepo Repo;
  RecordCubit(this.Repo) : super(RecordInitial());

  List<Record> records = [];
  Future<void> fetchAllIRecords() async {
    var result = await Repo.fetchrecords();
    result.fold((failure) {
      emit(GetRecordsFailure((((failure.errorMessege)))));
    }, (data) {
      records = data;
      emit(GetRecordsSuccess(records));
    });
  }
}
