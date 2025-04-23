import 'package:fashion_find/bloc/bloc_add_address/add_address_event.dart';
import 'package:fashion_find/bloc/bloc_add_address/add_address_state.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(debugLabel: "Add Address Form Key");
  GlobalKey<FormState> get formKey => _formKey;


  final TextEditingController addressController = TextEditingController();

  String? addressValidator(String? value) {
    if(value == null || value.isEmpty) {
      return "Name can't be empty";
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

  AddAddressBloc() : super(AddAddressInitialState()) {
    on<EventAddAddress>((event, emit) {
      emit(AddAddressLoadingState());
      try {
        _firebaseRepo.addAddress(event.uid, event.address);
        emit(AddAddressLoadedState());
      } catch (e) {
        emit(AddAddressErrorState(errorMessage: e.toString()));
      }
    });
  }
}