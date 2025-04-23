import 'dart:async';
import 'package:fashion_find/bloc/bloc_show_address/show_address_event.dart';
import 'package:fashion_find/bloc/bloc_show_address/show_address_state.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowAddressBloc extends Bloc<ShowAddressEvent, ShowAddressState> {

  final _firebaseRepo = FirebaseRepo();

  ShowAddressBloc() : super(ShowAddressInitialState()) {
    on<LoadAllAddressEvent>(loadAllAddresses);

    on<DeletePrimaryAddressEvent>(deletePrimaryAddress);

    on<DeleteAddressEvent>(deleteSecondaryAddress);
  }

  FutureOr<void> deletePrimaryAddress(event, emit) {
    try{
      _firebaseRepo.removePrimaryAddress(event.uid);
      emit(AddressDeletedState());
      emit(ShowAddressLoadedState());
    } catch (e) {
      emit(ShowAddressErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> deleteSecondaryAddress(event, emit) async {
    try{
      _firebaseRepo.removeAddress(event.uid, event.address);
      emit(AddressDeletedState());
      emit(ShowAddressLoadedState());
    } catch (e) {
      emit(ShowAddressErrorState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> loadAllAddresses(event, emit) async {
    emit(ShowAddressLoadingState());
    try {
      final user = await _firebaseRepo.getUserDetail(event.uid);
      emit(ShowAddressLoadedState(user));
    } catch (e) {
      emit(ShowAddressErrorState(errorMessage: e.toString()));
    }
  }
}