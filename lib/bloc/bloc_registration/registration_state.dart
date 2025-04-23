import 'package:equatable/equatable.dart';

abstract class RegistrationState extends Equatable {}

class RegistrationInitialState extends RegistrationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegistrationLoadingState extends RegistrationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegistrationSuccessState extends RegistrationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RegistrationErrorState extends RegistrationState {
  final String errorMessage;
  RegistrationErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
