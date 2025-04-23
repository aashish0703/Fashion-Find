import 'dart:async';
import 'package:fashion_find/bloc/bloc_shopping_cart/shopping_cart_event.dart';
import 'package:fashion_find/bloc/bloc_shopping_cart/shopping_cart_state.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {

  final _firebaseRepo = FirebaseRepo();

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  void showLoader() {
    print("is loading....");
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      print("inside future.delayed: ${isLoading.value}");
    });
    print("${isLoading.value}");
  }

  ShoppingCartBloc() : super(ShoppingCartInitialState()) {
    on<LoadShoppingCartItems>(loadCart);

    on<AddItemToCart>(addItemToCart);

    on<RemoveItemFromCart>(removeItemFromCart);

    on<IncreaseItemQuantity>(increaseItemQuantity);

    on<DecreaseItemQuantity>(decreaseItemQuantity);

    on<CheckOutEvent>((event, emit) async {
      try {
        await _firebaseRepo.addOrder(event.userId);
        emit(AddOrdersState());
      } catch (e) {
        emit(ShoppingCartErrorState(errorMessage: e.toString()));
      }
    });
  }

  FutureOr<void> increaseItemQuantity(event, emit) async {
    try {
      await _firebaseRepo.increaseQuantity(event.userId, event.cartItemId);
    } catch (e) {
      emit(ShoppingCartErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> decreaseItemQuantity(event, emit) async {
    try {
      await _firebaseRepo.decreaseQuantity(event.userId, event.cartItemId);
    } catch(e) {
      emit(ShoppingCartErrorState(errorMessage: e.toString()));
    }
  }


  FutureOr<void> loadCart(event, emit) async {
    emit(ShoppingCartLoadingState());
    try {
      final cartItemsStream = await _firebaseRepo.fetchCartItems(event.userId);
      emit(ShoppingCartLoadedState(cartItem: cartItemsStream));
    } catch (e) {
      print(e.toString());
      emit(ShoppingCartErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> addItemToCart(event, emit) async {
    emit(ShoppingCartLoadingState());
    try {
      await _firebaseRepo.addProductToCart(event.userId, event.item);
      emit(AddItemToShoppingCart());
    } catch(e) {
      emit(ShoppingCartErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> removeItemFromCart(event, emit) async {
    emit(ShoppingCartLoadingState());
    try {
      await _firebaseRepo.removeProductFromCart(event.userId, event.cartItemId);
      // emit(RemoveItemFromShoppingCart());
    }catch (e) {
      emit(ShoppingCartErrorState(errorMessage: e.toString()));
    }
  }

}