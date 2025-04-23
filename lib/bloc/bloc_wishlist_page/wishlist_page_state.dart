import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:fashion_find/model/product_model.dart';

abstract class WishListPageState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WishListPageInitialState extends WishListPageState {}

class WishListPageLoadingState extends WishListPageState {}

class WishListPageLoadedState extends WishListPageState {
  final List<ProductModel> productDetails;

  WishListPageLoadedState({required this.productDetails});

  @override
  // TODO: implement props
  List<Object?> get props => [productDetails];
}

class WishListPageErrorState extends WishListPageState {
  final String errorMessage;
  WishListPageErrorState({required this.errorMessage});
  
  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}