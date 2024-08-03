// ignore_for_file: argument_type_not_assignable_to_error_handler

import 'package:awesome_icons/awesome_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_app/core/utils/api/apis.dart';
import 'package:team_app/features/homepage/data/login_service.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  String email = '';
  String password = '';
  IconData icon = Icons.remove_red_eye;
  bool obscureText = true;
  final formKey = GlobalKey<FormState>();
  IconData passwordSuffixIcon = Icons.remove_red_eye;
  String? token;
  LoginCubit() : super(LoginInitial());
  // void changePasswordSuffixIcon() {
  //   if (passwordSuffixIcon == Icons.remove_red_eye) {
  //     passwordSuffixIcon = FontAwesomeIcons.solidEyeSlash;
  //   } else {
  //     passwordSuffixIcon = Icons.remove_red_eye;
  //   }
  //   obscureText = !obscureText;
  //   emit(ChangePasswordState());
  // }

  Future<void> login() async {
    emit(LoginLoading());
    try {
      final UserCredential? userCredential =
          await APIs.signinWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential != null) {
        final result = await LoginService.login(
          email: email,
          password: password,
        );

        result.fold(
          (failure) {
            emit(LoginFailure(failureMsg: failure.errorMessege));
          },
          (userModel) {
            token = userModel.token;
            emit(LoginSuccess(messageModel: userModel));
          },
        );
      } else {
        emit(LoginFailure(failureMsg: 'الرجاء إنشاء حساب قبل تسجيل الدخول'));
      }
    } catch (error) {
      emit(LoginFailure(failureMsg: 'حدث خطـأ,الرجاء المحاولة مجدداً'));
    }
  }

  void changePasswordState() {
    obscureText = !obscureText;
    if (!obscureText) {
      icon = FontAwesomeIcons.solidEyeSlash;
      emit(LoginInitial());
    } else {
      icon = FontAwesomeIcons.solidEye;
      emit(ChangePasswordState());
    }
  }
}
