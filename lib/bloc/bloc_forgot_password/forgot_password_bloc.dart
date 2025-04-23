import 'package:fashion_find/bloc/bloc_forgot_password/forgot_password_event.dart';
import 'package:fashion_find/bloc/bloc_forgot_password/forgot_password_state.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(debugLabel: "Forgot Password key");
  GlobalKey<FormState> get formKey => _formKey;

  final TextEditingController emailController = TextEditingController();

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

  ForgotPasswordBloc() : super(ForgotPasswordInitialState()) {
   on<ForgotPasswordRequestEvent>((event, emit) async {
     emit(ForgotPasswordLoadingState());
     try {
       await _firebaseRepo.forgotPassword(event.email);
       emit(ForgotPasswordSuccessState());
       emit(ForgotPasswordInitialState());
     } catch (e) {
       emit(ForgotPasswordErrorState(errorMessage: e.toString()));
     }
   });
  }

}