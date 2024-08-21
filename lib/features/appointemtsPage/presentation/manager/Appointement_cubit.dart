import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_app/core/utils/api/apis.dart';
import 'package:team_app/core/utils/cache_helper.dart';
import 'package:team_app/features/appointemtsPage/data/models/allProductResponse.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/appointemtsPage/data/repos/appointements_repo.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointements_state.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/widgets/chat_user.dart';
import 'package:team_app/features/homepage/data/models/products_update_body.dart';
import 'package:team_app/features/homepage/data/models/user_model.dart';

class AppointementsCubit extends Cubit<AppointementsState> {
  AppointementsCubit(this.Repo) : super(AppointementsInitial());
  final AppointementRepo Repo;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void setToCompleted(Appointment app) {
    app.statusId = 4;
    emit(AppointementsStateChangeTocomplete(app.statusId));
  }

  List<Appointment> appointements = [];
  bool isAppointmentInFuture(String startTime) {
    DateTime appointmentStartTime = DateTime.parse(startTime);

    DateTime today = DateTime.now();
    DateTime todayDateOnly = DateTime(today.year, today.month, today.day);
    DateTime appointmentDateOnly = DateTime(appointmentStartTime.year,
        appointmentStartTime.month, appointmentStartTime.day);

    return appointmentDateOnly.isAfter(todayDateOnly);
  }

  Future<void> fetchAllappointements(String id) async {
    emit(AppointementsLoading());
    var result = await Repo.fetchApointements(id);
    print("result $result");
    result.fold((failure) {
      emit(AppointementsFailure(failure.errorMessege));
    }, (data) {
      this.appointements = data;
      emit(AppointementsSuccess(appointements));
    });
  }

  ChatUser? userByuid;
  Future<void> fetchUser(String uid) async {
    emit(getuserbyUIDloadinge());
    userByuid = await APIs.getUserByUid(uid);
    log('userByuid ${userByuid?.email}');
    emit(getuserbyUIDsucc(userByuid!));
  }

  DateTime date = DateTime.now();
  void setDate(DateTime time) {
    log('message');
    date = time;
    emit(setDateTimeState(date));
  }

  String desc = " ";
  int otherPrice = 0;
  Future<void> makeDone(Appointment app) async {
    log('${app.id}  ${desc}   ${otherPrice}');
    final result = await Repo.makeDone(
      app.id,
      desc,
      otherPrice,
    );
    result.fold((failure) {
      emit(makedoneFail(failure.errorMessege));
    }, (data) {
      emit(MakeDoneState());
    });
  }

  List<Productforshow> productsshow = [];
  Future<void> fetchallproducts() async {
    var result = await Repo.fetchAllproduct();
    log(CacheHelper.getData(key: 'Token'));
    //log("products $result");
    result.fold((failure) {
      emit(productFailure((failure.errorMessege)));
    }, (data) {
      this.productsshow = data;
      emit(productSuccess(productsshow));
    });
  }

  Map<int, int> productQuantities = {};

  void increaseQuantity(int productId) {
    if (productQuantities.containsKey(productId)) {
      productQuantities[productId] = productQuantities[productId]! + 1;
    } else {
      productQuantities[productId] = 1;
    }
    int quantity = getQuantity(productId);
    emit(OrderAmountChanged(quantity));
  }

  void decreaseQuantity(int productId) {
    if (productQuantities.containsKey(productId) &&
        productQuantities[productId]! > 1) {
      productQuantities[productId] = productQuantities[productId]! - 1;
    } else {
      productQuantities[productId] = 1;
    }
    int quantity = getQuantity(productId);
    emit(OrderAmountChanged(quantity));
  }

  int getQuantity(int productId) {
    // log('$productId   ${productQuantities[productId]}');
    return productQuantities[productId] ?? 1;
  }

  List<ProductUpdate> productsUpdates = [];

  void addToupdatedProduct(ProductUpdate p) {
    productsUpdates.add(p);
    log('Product added: ${p.id}, amount: ${p.amount}');
    log('Current productUpdates list: ${productsUpdates.length}');
    emit(OrderUpdatedState(productsUpdates));
  }

  Future<void> updateProducts(Appointment app, String endTime) async {
    emit(OrderLoading());
    log('Products to update: $productsUpdates');
    final result = await Repo.updateProducts(
      app.id,
      productsUpdates
          .map((p) => ProductUpdate(id: p.id, amount: p.amount))
          .toList(),
      endTime,
    );
    result.fold((failure) => emit(OrderUpdateFailed(failure.errorMessege)),
        (response) => emit(OrderUpdateSuccess(response)));
  }

  List<Product> productsforupdate = [];
  void fetchprodupdated(List<Product> productsfor) {
    productsforupdate = productsfor;
    emit(Fetchprodupdated(productsforupdate));
  }
  // Future<void> updateProducts(
  //     int id, List<ProductUpdate> app, String endTime) async {
  //   emit(OrderLoading());
  //   log('Products to update: $productsUpdates');
  //   final result = await Repo.updateProducts(
  //     id,
  //     app,
  //     // productsUpdates
  //     //     .map((p) => ProductUpdate(id: p.id, amount: p.amount))
  //     //     .toList(),
  //     endTime,
  //   );
  //   result.fold((failure) => emit(OrderUpdateFailed(failure.errorMessege)),
  //       (response) => emit(OrderUpdateSuccess(response)));
  // }

  UserModel? userInfo;
  Future<void> fetchUserInfo() async {
    emit(GetUserInfoLoading());
    var result = await Repo.fetchuserinfo();
    result.fold((failure) {
      emit(GetUserInfoFailure(((failure.errorMessege))));
    }, (data) {
      userInfo = data;
      CacheHelper.saveData(key: 'UserID', value: userInfo?.id);
      log('GetUserInfoSuccess ${userInfo}');
      emit(GetUserInfoSuccess(data));
    });
  }
}
