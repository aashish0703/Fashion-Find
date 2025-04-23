import 'package:equatable/equatable.dart';
import 'package:fashion_find/model/product_model.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchInitialState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<ProductModel> productList;

  SearchLoadedState({required this.productList});

  @override
  List<Object?> get props => [productList];
}

class SearchErrorState extends SearchState {
  final String errorMessage;

  SearchErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}