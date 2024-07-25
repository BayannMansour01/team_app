import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:team_app/core/utils/api/apis.dart';
import 'package:team_app/features/appointemtsPage/data/models/allProductResponse.dart';
import 'package:team_app/features/appointemtsPage/data/models/apointement_model.dart';
import 'package:team_app/features/appointemtsPage/data/repos/appointements_repo.dart';
import 'package:team_app/features/appointemtsPage/presentation/manager/Appointements_state.dart';
import 'package:team_app/features/chatScreen/presentation/Screens/widgets/chat_user.dart';
import 'package:team_app/features/homepage/data/models/products_update_body.dart';
import 'package:team_app/features/homepage/presentation/manager/cubit/home_page_state.dart';

class AppointementsCubit extends Cubit<AppointementsState> {
  AppointementsCubit(this.Repo) : super(AppointementsInitial());
  final AppointementRepo Repo;
  // String groupname = '';
  int status = 0;
  // void changeActiveStepper(int index) {
  //   emit(AppointementsInitial());
  //   status = index;
  //   emit(ChangeActiveStepSuccess());
  // }

  void setToCompleted() {
    status = 3;
    emit(AppointementsStateChangeTocomplete(status));
  }

  List<Appointment> appointements = [];

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

  // ChatUser? userByuid;
  // Future<void> fetchUser(String uid) async {
  //   emit(getuserbyUIDloadinge());
  //   userByuid = await APIs.getUserByUid(uid);
  //   log('userByuid ${userByuid?.email}');
  //   emit(getuserbyUIDsucc(userByuid!));
  // }

  DateTime date = DateTime.now();
  void setDate(DateTime time) {
    date = time;
    emit(setDateTimeState());
  }

  String desc = " ";
  String otherPrice = " ";
  void makeDone(int id) async {
    var result = await Repo.makeDone(id, desc, otherPrice);
    setToCompleted();
    // emit(MakeDoneState());
  }

  List<Productforshow> productsshow = [];
  Future<void> fetchallproducts() async {
    var result = await Repo.fetchAllproduct();
    log("products $result");
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
    emit(OrderAmountChanged());
  }

  void decreaseQuantity(int productId) {
    if (productQuantities.containsKey(productId) &&
        productQuantities[productId]! > 1) {
      productQuantities[productId] = productQuantities[productId]! - 1;
    } else {
      productQuantities[productId] = 1;
    }
    emit(OrderAmountChanged());
  }

  int getQuantity(int productId) {
    return productQuantities[productId] ?? 1;
  }

  List<ProductUpdate> productsUpdates = [];
  void addToupdatedProduct(ProductUpdate p) {
    productsUpdates.add(p);
    emit(OrderUpdatedState(productsUpdates));
  }

  Future<void> updateProducts(int appointmentId, String endTime) async {
    emit(OrderLoading());
    final result = await Repo.updateProducts(
      appointmentId,
      productsUpdates
          .map((p) => ProductUpdate(id: p.id, amount: p.amount))
          .toList(),
      endTime,
    );
    result.fold((failure) => emit(OrderUpdateFailed(failure.errorMessege)),
        (response) {
      log(response.msg);

      return emit(OrderUpdateSuccess(response));
    });
  }
}
