import 'package:equatable/equatable.dart';
import 'package:fashion_find/model/shopping_cart_model.dart';

abstract class ShoppingCartEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadShoppingCartItems extends ShoppingCartEvent {
  final String userId;
  LoadShoppingCartItems({required this.userId});

  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}

class AddItemToCart extends ShoppingCartEvent {
  final String userId;
  final CartItem item;

  AddItemToCart({required this.userId, required this.item});

  @override
  // TODO: implement props
  List<Object?> get props => [userId, item];
}

class RemoveItemFromCart extends ShoppingCartEvent {
  final String userId;
  final String cartItemId;
  RemoveItemFromCart({required this.userId, required this.cartItemId});

  @override
  // TODO: implement props
  List<Object?> get props => [userId, cartItemId];
}

class IncreaseItemQuantity extends ShoppingCartEvent {
  final String userId;
  final String cartItemId;

  IncreaseItemQuantity({required this.userId, required this.cartItemId});

  @override
  // TODO: implement props
  List<Object?> get props => [userId, cartItemId];
}

class DecreaseItemQuantity extends ShoppingCartEvent {
  final String userId;
  final String cartItemId;

  DecreaseItemQuantity({required this.userId, required this.cartItemId});

  @override
  // TODO: implement props
  List<Object?> get props => [userId, cartItemId];
}

class CheckOutEvent extends ShoppingCartEvent {
  final String userId;

  CheckOutEvent({required this.userId});

  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}