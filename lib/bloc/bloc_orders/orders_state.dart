import 'package:equatable/equatable.dart';
import 'package:fashion_find/model/orders_model.dart';
import 'package:fashion_find/model/user_model.dart';

abstract class OrdersState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OrdersInitialState extends OrdersState {}

class OrdersLoadingState extends OrdersState {}

class OrdersLoadedState extends OrdersState {
  final List<OrdersModel> orderList;

  OrdersLoadedState({required this.orderList});

  @override
  // TODO: implement props
  List<Object?> get props => [orderList];
}

class OrdersErrorState extends OrdersState {
  final String errorMessage;

  OrdersErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

class OrdersPaymentState extends OrdersState {}