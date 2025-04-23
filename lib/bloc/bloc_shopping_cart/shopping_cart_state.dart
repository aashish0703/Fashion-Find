
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fashion_find/model/product_model.dart';
import 'package:fashion_find/model/shopping_cart_model.dart';

abstract class ShoppingCartState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ShoppingCartInitialState extends ShoppingCartState {}

class ShoppingCartLoadingState extends ShoppingCartState {}

class ShoppingCartLoadedState extends ShoppingCartState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> cartItem;
  ShoppingCartLoadedState({required this.cartItem});

  @override
  // TODO: implement props
  List<Object?> get props => [cartItem];
}

class ShoppingCartErrorState extends ShoppingCartState {
  final String errorMessage;

  ShoppingCartErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

class AddItemToShoppingCart extends ShoppingCartState {}

class RemoveItemFromShoppingCart extends ShoppingCartState {}

class AddOrdersState extends ShoppingCartState {}