import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class CategoriesState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CategoriesInitialState extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesLoadedState extends CategoriesState {
  final Future<QuerySnapshot<Map<String, dynamic>>> categories;
  CategoriesLoadedState({required this.categories});

  @override
  // TODO: implement props
  List<Object?> get props => [categories];
}

class CategoriesErrorState extends CategoriesState {
  final String errorMessage;
  CategoriesErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}