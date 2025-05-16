

import 'dart:async';
import 'package:fashion_find/bloc/bloc_orders/orders_event.dart';
import 'package:fashion_find/bloc/bloc_orders/orders_state.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {

  final _firebaseRepo = FirebaseRepo();
  Razorpay razorpay = Razorpay();
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    // showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  OrdersBloc() : super(OrdersInitialState()) {
    on<LoadCurrentOrder>(currentOrder);

    on<InitiatePayment>(payment);

    on<LoadAllOrders>(loadAllOrders);
  }

  FutureOr<void> loadAllOrders(event, emit) async {
    emit(OrdersLoadingState());
    try {
      final orderList = await _firebaseRepo.fetchOrder(event.userId);
      emit(OrdersLoadedState(orderList: orderList));
    } catch(e) {
      emit(OrdersErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> payment(event, emit) {
    try {

      var options = {
        'key': 'rzp_live_ILgsfZCZoFIKMb',
        'amount': (event.totalAmount * 100).toInt(),
        'name': "Fashion Find",
        'description': "Payment for order",
        'prefill': {
          'contact': "9999999999",
          'email': "fashionfind@gmail.com"
        }
      };
      razorpay.open(options);

      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

      emit(OrdersPaymentState());
    } catch(e) {
      emit(OrdersErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> currentOrder(event, emit) async {
    emit(OrdersLoadingState());
    try {
      final orderList = await _firebaseRepo.fetchLatestOrder(event.userId);
      emit(OrdersLoadedState(orderList: orderList));
    } catch(e) {
      emit(OrdersErrorState(errorMessage: e.toString()));
    }
  }
}