import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadCategoriesEvent extends CategoriesEvent {}