import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable {}

class ForgotPasswordInitialState extends ForgotPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ForgotPasswordLoadingState extends ForgotPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ForgotPasswordSuccessState extends ForgotPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ForgotPasswordErrorState extends ForgotPasswordState {
  final String errorMessage;
  ForgotPasswordErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}
