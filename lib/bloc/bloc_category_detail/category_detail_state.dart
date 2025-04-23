import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class CategoryDetailState extends Equatable {

  final int? expandedIndex;

  CategoryDetailState(this.expandedIndex);
  @override
  // TODO: implement props
  List<Object?> get props => [expandedIndex];
}

class CategoryDetailInitialState extends CategoryDetailState {
  CategoryDetailInitialState() : super(null);
}

class CategoryDetailLoadingState extends CategoryDetailState {
  CategoryDetailLoadingState() : super(null);
}

class CategoryDetailLoadedState extends CategoryDetailState {

  final Stream<QuerySnapshot<Map<String, dynamic>>> categoryDetail;
  CategoryDetailLoadedState({required this.categoryDetail})  : super(null);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CategoryDetailErrorState extends CategoryDetailState {
  final String errorMessage;
  CategoryDetailErrorState({required this.errorMessage})  : super(null);

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

class ExpansionTileUpdated extends CategoryDetailState {
  ExpansionTileUpdated(int? expandedIndex) : super(expandedIndex);
}