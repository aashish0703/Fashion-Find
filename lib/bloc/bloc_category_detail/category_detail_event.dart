import 'package:equatable/equatable.dart';

abstract class CategoryDetailEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadCategoryDetails extends CategoryDetailEvent {
  final String categoryId;

  LoadCategoryDetails({required this.categoryId});

  @override
  // TODO: implement props
  List<Object?> get props => [categoryId];
}

class ExpandTile extends CategoryDetailEvent {
  final int index;
  ExpandTile(this.index);

  @override
  // TODO: implement props
  List<Object?> get props => [index];
}