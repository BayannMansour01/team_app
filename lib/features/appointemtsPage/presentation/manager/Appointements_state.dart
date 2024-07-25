import 'package:equatable/equatable.dart';
import 'package:team_app/features/appointemtsPage/data/models/allProductResponse.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/appointemtsPage/data/models/response_done.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/widgets/chat_user.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/widgets/chat_user_card.dart';
import 'package:team_app/features/homepage/data/models/products_update_body.dart';

abstract class AppointementsState {
  const AppointementsState();

  @override
  List<Object> get props => [];
}

class AppointementsInitial extends AppointementsState {}

class AppointementsLoading extends AppointementsState {}

class AppointementsFailure extends AppointementsState {
  final String errMessage;

  const AppointementsFailure(this.errMessage);
}

class AppointementsSuccess extends AppointementsState {
  final List<Appointment> groups;

  const AppointementsSuccess(this.groups);
}

class productFailure extends AppointementsState {
  final String errMessage;

  const productFailure(this.errMessage);
}

class productSuccess extends AppointementsState {
  final List<Productforshow> groups;

  const productSuccess(this.groups);
}

class getuserbyUIDloadinge extends AppointementsState {}

class getuserbyUIDsucc extends AppointementsState {
  final ChatUser user;
  getuserbyUIDsucc(this.user);
}

class ChangeActiveStepSuccess extends AppointementsState {
  // final List<GroupModel> groups;

  // const AppointementsSuccess(this.groups);
}

class MakeDoneState extends AppointementsState {}

class AppointementsStateChangeTocomplete extends AppointementsState {
  int state;
  AppointementsStateChangeTocomplete(this.state);
}

class setDateTimeState extends AppointementsState {}

class OrderAmountChanged extends AppointementsState {}

class updateProduct extends AppointementsState {}

class OrderUpdatedState extends AppointementsState {
  final List<ProductUpdate> productsUpdates;

  OrderUpdatedState(this.productsUpdates);
}

class OrderLoading extends AppointementsState {}

class OrderUpdateSuccess extends AppointementsState {
  final BasicResponse response;

  OrderUpdateSuccess(this.response);
}

class OrderUpdateFailed extends AppointementsState {
  final String errorMessage;

  OrderUpdateFailed(this.errorMessage);
}
