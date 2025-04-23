import 'package:fashion_find/bloc/bloc_home_products/home_products_event.dart';
import 'package:fashion_find/bloc/bloc_home_products/home_products_state.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeProductsBloc extends Bloc<HomeProductsEvent, HomeProductsState> {

  final _firebaseRepo = FirebaseRepo();

  HomeProductsBloc() : super(HomeProductsInitialState()) {
    on<LoadProductsEvent>((event, emit) async {
      emit(HomeProductsLoadingState());
      try {
        final productStream = await _firebaseRepo.getProducts();
        emit(HomeProductsLoadedState(productsStream : productStream));
      } catch(e) {
        emit(HomeProductsErrorState(errorMessage: e.toString()));
      }
    });
  }
}