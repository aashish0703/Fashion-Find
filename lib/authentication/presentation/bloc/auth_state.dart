import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthLoginLoadedState extends AuthState {}

class AuthRegisterLoadedState extends AuthState {}

class AuthGoogleLoginLoadedState extends AuthState {}

class AuthErrorState extends AuthState {
  final String errorMessage;
  AuthErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}