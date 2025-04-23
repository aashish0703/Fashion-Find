import 'dart:async';
import 'package:fashion_find/bloc/bloc_categories/categories_event.dart';
import 'package:fashion_find/bloc/bloc_categories/categories_state.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {

  final _firebaseRepo = FirebaseRepo();

  CategoriesBloc() : super(CategoriesInitialState()) {
    on<LoadCategoriesEvent>(loadCategories);
  }

  FutureOr<void> loadCategories(event, emit) async {
    emit(CategoriesLoadingState());
    try {
      final futureCategory = _firebaseRepo.getCategories();
      emit(CategoriesLoadedState(categories: futureCategory));
    } catch (e) {
      emit(CategoriesErrorState(errorMessage: e.toString()));
    }
  }

}