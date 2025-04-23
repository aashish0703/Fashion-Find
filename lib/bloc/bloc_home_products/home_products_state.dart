import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class HomeProductsState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeProductsInitialState extends HomeProductsState {}

class HomeProductsLoadingState extends HomeProductsState {}

class HomeProductsLoadedState extends HomeProductsState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> productsStream;

  HomeProductsLoadedState({required this.productsStream});

  @override
  // TODO: implement props
  List<Object?> get props => [productsStream];
}

class HomeProductsErrorState extends HomeProductsState {
  final String errorMessage;

  HomeProductsErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
