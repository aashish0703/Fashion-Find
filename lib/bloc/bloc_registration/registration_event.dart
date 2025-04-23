import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {}

class RegistrationRequestEvent extends RegistrationEvent {
  final String name;
  final String email;
  final String password;
  final String contact;
  final String primaryAddress;
  RegistrationRequestEvent({required this.name, required this.email, required this.password, required this.contact, required this.primaryAddress});

  @override
  // TODO: implement props
  List<Object?> get props => [name, email, password, contact, primaryAddress];
}

class LoginWithGoogleEvent extends RegistrationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}