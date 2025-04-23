import 'package:equatable/equatable.dart';


abstract class LoginEvent extends Equatable {}

class LoginRequestEvent extends LoginEvent {
  final String email;
  final String password;

  LoginRequestEvent({required this.email, required this.password});
  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class LoginWithGoogleEvent extends LoginEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
