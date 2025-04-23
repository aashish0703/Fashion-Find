import 'package:fashion_find/authentication/domain/use_cases/google_login_use_case.dart';
import 'package:fashion_find/authentication/domain/use_cases/login_use_case.dart';
import 'package:fashion_find/authentication/domain/use_cases/register_use_case.dart';
import 'package:fashion_find/authentication/presentation/bloc/auth_event.dart';
import 'package:fashion_find/authentication/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final GoogleLoginUseCase googleLoginUseCase;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>(debugLabel: "Login Form Key");
  GlobalKey<FormState> get loginFormKey => _loginFormKey;

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>(debugLabel: "Register Form Key");
  GlobalKey<FormState> get registerFormKey  => _registerFormKey;

  final TextEditingController registerNameController = TextEditingController();
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController = TextEditingController();
  final TextEditingController registerContactController = TextEditingController();

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

  String? nameValidator(String? value) {
    if(value == null || value.isEmpty) {
      return "Name can't be empty";
    }
    return null;
  }

  InputDecoration styleTextField(hintText, Icon icon) {
    return InputDecoration(
        hintText: hintText,
        suffixIcon: icon
    );
  }

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.googleLoginUseCase
  }) : super(AuthInitialState()) {
   on<AuthEvent>((event, emit) async {
     if(event is LoginRequestEvent) {
       emit(AuthLoadingState());
       try {
         final userCredentials = await loginUseCase(event.loginEntity);
         if(userCredentials!.user != null) {
           emit(AuthLoginLoadedState());
         } else {
           emit(AuthErrorState(errorMessage: "Error occurred user null"));
         }
       } catch (e) {
         emit(AuthErrorState(errorMessage: e.toString()));
       }
     } else if(event is RegisterRequestEvent) {
       emit(AuthLoadingState());
       try {
         await registerUseCase(event.registerEntity);
         emit(AuthRegisterLoadedState());
       } catch (e) {
         emit(AuthErrorState(errorMessage: e.toString()));
       }
     } else if(event is GoogleLoginUseCase) {
       emit(AuthLoadingState());
       try {
         final userCredential = await googleLoginUseCase();
         if(userCredential.user != null) {
           emit(AuthGoogleLoginLoadedState());
         } else {
           emit(AuthErrorState(errorMessage: "user null"));
         }
       } catch (e) {
         emit(AuthErrorState(errorMessage: e.toString()));
       }
     }
   });
  }


}