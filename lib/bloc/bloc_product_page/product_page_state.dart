import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class ProductPageState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductPageInitialState extends ProductPageState {}

class ProductPageLoadingState extends ProductPageState {}

class ProductPageLoadedState extends ProductPageState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> subsubcategoryProductDetails;
  ProductPageLoadedState({required this.subsubcategoryProductDetails});

  @override
  // TODO: implement props
  List<Object?> get props => [subsubcategoryProductDetails];
}

class ProductPageErrorState extends ProductPageState {
  final String errorMessage;
  ProductPageErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}