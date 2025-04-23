import 'dart:async';
import 'package:fashion_find/bloc/bloc_registration/registration_event.dart';
import 'package:fashion_find/bloc/bloc_registration/registration_state.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(debugLabel: "Registration Form Key");
  GlobalKey<FormState> get formKey => _formKey;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController primaryAddressController = TextEditingController();

  String? passwordValidator(String? value) {
    RegExp regex = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$");
    if(value == null || value.isEmpty) {
      return "Password can't be empty";
    }
    if (!regex.hasMatch(value)) {
      return "Password must be of minimum eight characters,\n at least 1 uppercase letter, 1 lowercase letter\n, 1 number and 1 special character";
    }
    return null;
  }

  String? emailValidator(String? value) {
    RegExp regex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if(value == null || value.isEmpty) {
      return "Email can't be empty";
    }
    if(!regex.hasMatch(value)) {
      return "Invalid email";
    }
    return null;
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
        // icon: icon
        suffixIcon: icon
    );
  }


  final _firebaseRepo = FirebaseRepo();

  RegistrationBloc() : super(RegistrationInitialState()) {
   on<RegistrationRequestEvent>(register);

   on<LoginWithGoogleEvent>(loginWithGoogle);
  }

  FutureOr<void> loginWithGoogle(event, emit) async {
    emit(RegistrationLoadingState());
    try {
      UserCredential credential = await _firebaseRepo.signInWithGoogle();
      if(credential.user != null) {
        emit(RegistrationSuccessState());
      } else {
        emit(RegistrationErrorState(errorMessage: "credential.user is null"));
        emit(RegistrationInitialState());
      }
    } catch (e) {
      emit(RegistrationErrorState(errorMessage: e.toString()));
      emit(RegistrationInitialState());
    }
  }

  FutureOr<void> register(event, emit) async {
    emit(RegistrationLoadingState());
    try {
      await _firebaseRepo.register(event.name, event.email, event.password, event.contact, event.primaryAddress);
      emit(RegistrationSuccessState());
    } catch (e) {
      emit(RegistrationErrorState(errorMessage: e.toString()));
      emit(RegistrationInitialState());
    }
  }

}