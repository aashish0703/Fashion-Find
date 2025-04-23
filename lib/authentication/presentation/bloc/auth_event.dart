import 'package:equatable/equatable.dart';
import 'package:fashion_find/authentication/domain/entities/register_entity.dart';

import '../../domain/entities/login_entity.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginRequestEvent extends AuthEvent {
  final LoginEntity loginEntity;
  LoginRequestEvent({required this.loginEntity});

  @override
  // TODO: implement props
  List<Object> get props => [loginEntity];
}

class RegisterRequestEvent extends AuthEvent {
  final RegisterEntity registerEntity;
  RegisterRequestEvent({required this.registerEntity});

  @override
  // TODO: implement props
  List<Object> get props => [registerEntity];
}

class LoginWithGoogleEvent extends AuthEvent {}