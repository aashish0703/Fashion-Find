import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class UserAccountPageState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserAccountPageInitialState extends UserAccountPageState {}

class UserAccountPageLoadingState extends UserAccountPageState {}

class UserAccountPageLoadedState extends UserAccountPageState {
  final Stream<DocumentSnapshot> user;
  UserAccountPageLoadedState({required this.user});

  @override
  // TODO: implement props
  List<Object?> get props => [user];
}

class UserAccountPageDeleteUserState extends UserAccountPageState {}

class UserAccountPageErrorState extends UserAccountPageState {
  final String errorMessage;
  UserAccountPageErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}