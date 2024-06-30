import 'package:equatable/equatable.dart';
import 'package:team_app/features/homepage/data/message_model.dart';

abstract class LoginStates {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginFailure extends LoginStates {
  final String failureMsg;

  LoginFailure({required this.failureMsg});
}

class LoginSuccess extends LoginStates {
  final MessageModel messageModel;

  LoginSuccess({required this.messageModel});
}

class ChangePasswordState extends LoginStates {}
