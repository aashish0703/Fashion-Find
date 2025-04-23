import 'dart:async';
import 'package:fashion_find/bloc/bloc_home/home_event.dart';
import 'package:fashion_find/bloc/bloc_home/home_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {



  InputDecoration styleTextField(hintText, Icon icon) {
    return InputDecoration(
      labelText: hintText,
      suffixIcon:  icon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10)
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10)
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10)
      ),
      errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10)
      ),
    );
  }

  HomeBloc() : super(HomeInitialState()) {
   on<SignOutRequestEvent>(signOut);
  }

  FutureOr<void> signOut(event, emit) async {
    await FirebaseAuth.instance.signOut();
    emit(HomeSignOutState());
  }
}