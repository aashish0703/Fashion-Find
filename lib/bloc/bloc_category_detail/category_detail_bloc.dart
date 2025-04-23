import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_find/bloc/bloc_category_detail/category_detail_event.dart';
import 'package:fashion_find/bloc/bloc_category_detail/category_detail_state.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetailBloc extends Bloc<CategoryDetailEvent, CategoryDetailState> {

  final _firebaseRepo = FirebaseRepo();

  getSubSubCategories(String subcategoryId) async {
    final subSubCategories = FirebaseFirestore.instance
        .collection("subsubcategory")
        .where("subcategoryId", isEqualTo: subcategoryId);

    final subSubCategoriesQuerySnapshot = await subSubCategories.get();

    final data = subSubCategoriesQuerySnapshot.docs;
    print(data);

    // print(data[0]);
  }

  CategoryDetailBloc() : super(CategoryDetailInitialState()) {
    on<LoadCategoryDetails>((event, emit) async {
      emit(CategoryDetailLoadingState());
      try {
        final categoryDetails = await _firebaseRepo.getSubCategories(event.categoryId);
        emit(CategoryDetailLoadedState(categoryDetail: categoryDetails));
      } catch (e) {
        emit(CategoryDetailErrorState(errorMessage: e.toString()));
      }
    });
  }

}