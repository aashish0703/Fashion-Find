import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class HomeProductsEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadProductsEvent extends HomeProductsEvent {}