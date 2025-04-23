import 'package:fashion_find/bloc/bloc_edit_user_profile/edit_user_profile_event.dart';
import 'package:fashion_find/bloc/bloc_edit_user_profile/edit_user_profile_state.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditUserProfileBloc extends Bloc<EditUserProfileEvent, EditUserProfileState> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(debugLabel: "Update User Form Key");
  GlobalKey<FormState> get formKey => _formKey;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController primaryAddressController = TextEditingController();

  ValueNotifier<String> selectedOption = ValueNotifier("None");

  void setSelectedOption(String value) {
    selectedOption.value = value;
  }


  String? nameValidator(String? value) {
    if(value == null || value.isEmpty) {
      return "Name can't be empty";
    }
    return null;
  }

  String? addressValidator(String? value) {
    if(value == null || value.isEmpty) {
      return "Name can't be empty";
    }
    return null;
  }

  String? contactValidator(String? value) {
    RegExp regExp = RegExp(r"^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[789]\d{9}$");
    if(value == null || value.isEmpty) {
      return "Contact can't be empty";
    }
    if (!regExp.hasMatch(value)) {
      return "Invalid phone number";
    }
    return null;
  }

  InputDecoration styleTextField(hintText, Icon icon) {
    return InputDecoration(
        hintText: hintText,
        suffixIcon: icon
    );
  }

  final _firebaseRepo = FirebaseRepo();



  EditUserProfileBloc() : super(EditUserProfileInitialState()) {


    on<ChangeGenderValue>((event, emit) {
      emit(EditUserProfileInitialState(gender: event.gender));
    });

    on<UpdateProfileEvent>((event, emit) async {
      emit(EditUserProfileLoadingState());
      try {
        await _firebaseRepo.updateUser(event.name, event.contact, event.gender, event.primaryAddress);
        emit(EditUserProfileSuccessState());
        emit(EditUserProfileInitialState());
      } catch (e) {
        emit(EditUserProfileErrorState(errorMessage: e.toString()));
        emit(EditUserProfileInitialState());
      }
    });
  }
}