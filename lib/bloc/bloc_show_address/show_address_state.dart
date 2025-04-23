import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class ShowAddressState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ShowAddressInitialState extends ShowAddressState {}

class ShowAddressLoadingState extends ShowAddressState {}

class ShowAddressLoadedState extends ShowAddressState {
  final Stream<DocumentSnapshot>? user;
  ShowAddressLoadedState([this.user]);

  @override
  // TODO: implement props
  List<Object?> get props => [user];
}

class AddressDeletedState extends ShowAddressState {}

class ShowAddressErrorState extends ShowAddressState {
  final String errorMessage;
  ShowAddressErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}