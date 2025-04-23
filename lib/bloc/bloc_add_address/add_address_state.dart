import 'package:equatable/equatable.dart';

abstract class AddAddressState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddAddressInitialState extends AddAddressState {}

class AddAddressLoadingState extends AddAddressState {}

class AddAddressLoadedState extends AddAddressState {}

class AddAddressErrorState extends AddAddressState {
  final String errorMessage;
  AddAddressErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}