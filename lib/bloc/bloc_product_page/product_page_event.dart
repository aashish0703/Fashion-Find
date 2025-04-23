import 'package:equatable/equatable.dart';

abstract class ProductPageEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadSubSubCategoryProductEvent extends ProductPageEvent {
  final String subSubcategoryId;
  LoadSubSubCategoryProductEvent({required this.subSubcategoryId});

  @override
  // TODO: implement props
  List<Object?> get props => [subSubcategoryId];
}

class AddToWishListEvent extends ProductPageEvent {
  bool isSelected;

  AddToWishListEvent({required this.isSelected});

  @override
  // TODO: implement props
  List<Object?> get props => [isSelected];
}

class RemoveFromWishListEvent extends ProductPageEvent {
   bool isSelected;

  RemoveFromWishListEvent({required this.isSelected});

  @override
  // TODO: implement props
  List<Object?> get props => [isSelected];
}