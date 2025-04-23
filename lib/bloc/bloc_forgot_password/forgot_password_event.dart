import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {}

class ForgotPasswordRequestEvent extends ForgotPasswordEvent {
  final String email;
  ForgotPasswordRequestEvent({required this.email});

  @override
  // TODO: implement props
  List<Object?> get props => [email];
}