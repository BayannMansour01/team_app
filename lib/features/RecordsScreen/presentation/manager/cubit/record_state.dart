part of 'record_cubit.dart';

sealed class RecordState extends Equatable {
  const RecordState();

  @override
  List<Object> get props => [];
}

final class RecordInitial extends RecordState {}

class GetRecordsLoading extends RecordState {}

class GetRecordsFailure extends RecordState {
  final String errMessage;

  const GetRecordsFailure(this.errMessage);
}

class GetRecordsSuccess extends RecordState {
  final List<Record> Records;
  GetRecordsSuccess(this.Records);
}
