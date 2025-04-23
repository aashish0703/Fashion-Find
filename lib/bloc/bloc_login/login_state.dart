import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {}

class LoginInitialState extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginErrorState extends LoginState {
  final String errorMessage;
  LoginErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}