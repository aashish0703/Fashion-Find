import 'dart:async';
import 'package:fashion_find/bloc/bloc_login/login_event.dart';
import 'package:fashion_find/bloc/bloc_login/login_state.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(debugLabel: "Login Form Key");
  GlobalKey<FormState> get formKey => _formKey;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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

  InputDecoration styleTextField(hintText, Icon icon) {
    return InputDecoration(
      hintText: hintText,
      suffixIcon: icon
    );
  }

  final _firebaseRepo = FirebaseRepo();

  LoginBloc() : super(LoginInitialState()) {
    on<LoginRequestEvent>(login);

    on<LoginWithGoogleEvent>(loginWithGoogle);
  }

  FutureOr<void> loginWithGoogle(event, emit) async {
    emit(LoginLoadingState());
    try {
      UserCredential credential = await _firebaseRepo.signInWithGoogle();
      if(credential.user != null) {
        emit(LoginSuccessState());
        emit(LoginInitialState());
      } else {
        emit(LoginErrorState(errorMessage: "credential.user is null"));
        emit(LoginInitialState());
      }
    } catch (e) {
      emit(LoginErrorState(errorMessage: e.toString()));
      emit(LoginInitialState());
    }
  }

  FutureOr<void> login(event, emit) async {
    emit(LoginLoadingState());
    try {
      User? user = await _firebaseRepo.login(event.email, event.password);
      if (user != null) {
        emit(LoginSuccessState());
        emit(LoginInitialState());
      } else {
        emit(LoginErrorState(errorMessage: "User is null"));
      }
    } catch (e) {
      emit(LoginErrorState(errorMessage: e.toString()));
      emit(LoginInitialState());
    }
  }

}