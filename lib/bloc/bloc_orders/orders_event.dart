import 'package:equatable/equatable.dart';

abstract class OrdersEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadCurrentOrder extends OrdersEvent {
  final String userId;

  LoadCurrentOrder({required this.userId});

  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}

class LoadAllOrders extends OrdersEvent {
  final String userId;

  LoadAllOrders({required this.userId});

  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}

class InitiatePayment extends OrdersEvent {
  final double totalAmount;

  InitiatePayment({required this.totalAmount});

  @override
  // TODO: implement props
  List<Object?> get props => [totalAmount];
}