import 'package:equatable/equatable.dart';
import 'package:fashion_find/model/user_model.dart';

abstract class EditUserProfileEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UpdateProfileEvent extends EditUserProfileEvent {
  final String name;
  final String contact;
  final String gender;
  final String primaryAddress;

  UpdateProfileEvent({required this.name, required this.contact, required this.gender, required this.primaryAddress});


  @override
  // TODO: implement props
  List<Object?> get props => [name, contact, gender, primaryAddress];
}

class ChangeGenderValue extends EditUserProfileEvent {
  final String gender;

  ChangeGenderValue({required this.gender});

  @override
  // TODO: implement props
  List<Object?> get props => [gender];
}