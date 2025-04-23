import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class SubSubCategoryState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SubSubCategoryInitialState extends SubSubCategoryState {}

class SubSubCategoryLoadingState extends SubSubCategoryState {}

class SubSubCategoryLoadedState extends SubSubCategoryState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> subSubCategoryDetails;
  SubSubCategoryLoadedState({required this.subSubCategoryDetails});

  @override
  // TODO: implement props
  List<Object?> get props => [subSubCategoryDetails];
}

class SubSubCategoryErrorState extends SubSubCategoryState {
  final String errorMessage;
  SubSubCategoryErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}