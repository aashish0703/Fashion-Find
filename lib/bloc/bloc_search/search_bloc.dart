import 'package:fashion_find/bloc/bloc_search/search_event.dart';
import 'package:fashion_find/bloc/bloc_search/search_state.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final _firebaseRepo = FirebaseRepo();

  final TextEditingController searchController = TextEditingController();

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

  SearchBloc() : super(SearchInitialState()) {

    on<MakeSearchEvent>((event, emit) async {
      emit(SearchLoadingState());
      try {
        if(event.searchQuery.trim().isEmpty) {
          emit(SearchLoadedState(productList: const []));
          print("[searchBloc] list sent by .isEmpty");
        } else {
          final productList = await _firebaseRepo.getSearchResult(event.searchQuery);
          print("[searchBloc] list sent by else part");
          print("[searchBloc] productList : $productList");
          emit(SearchLoadedState(productList: productList));
        }
      } catch(e) {
        emit(SearchErrorState(errorMessage: e.toString()));
      }
    });

  }
}