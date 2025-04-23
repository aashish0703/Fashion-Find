import 'package:equatable/equatable.dart';

abstract class UserAccountPageEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadUserAccountPageEvent extends UserAccountPageEvent {
  final String uid;

  LoadUserAccountPageEvent({required this.uid});

  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}

class DeleteUserEvent extends UserAccountPageEvent {
  final String uid;

  DeleteUserEvent({required this.uid});

  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}