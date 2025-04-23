import 'package:equatable/equatable.dart';

abstract class EditUserProfileState extends Equatable {

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EditUserProfileInitialState extends EditUserProfileState {

   String? gender;
   EditUserProfileInitialState({this.gender});

  @override
  // TODO: implement props
  List<Object?> get props => [gender];
}

class EditUserProfileLoadingState extends EditUserProfileState {}

class EditUserProfileSuccessState extends EditUserProfileState {}

class EditUserProfileErrorState extends EditUserProfileState {
  final String errorMessage;

  EditUserProfileErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}