import 'package:equatable/equatable.dart';

abstract class SubSubCategoryEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadSubSubCategoriesEvent extends SubSubCategoryEvent {
  final String subcategoryId;
  LoadSubSubCategoriesEvent({required this.subcategoryId});

  @override
  // TODO: implement props
  List<Object?> get props => [subcategoryId];
}