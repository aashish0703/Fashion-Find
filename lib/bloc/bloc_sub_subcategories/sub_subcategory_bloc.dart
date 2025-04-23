import 'package:fashion_find/bloc/bloc_sub_subcategories/sub_subcategory_event.dart';
import 'package:fashion_find/bloc/bloc_sub_subcategories/sub_subcategory_state.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubSubCategoryBloc extends Bloc<SubSubCategoryEvent, SubSubCategoryState> {

  final _firebaseRepo = FirebaseRepo();

  SubSubCategoryBloc() : super(SubSubCategoryInitialState()) {
   on<LoadSubSubCategoriesEvent>((event, emit) async {
     emit(SubSubCategoryLoadingState());
     try {
       final subSubCategoriesDetails = await _firebaseRepo.getSubSubCategories(event.subcategoryId);
       print("my data is->>$subSubCategoriesDetails");
       emit(SubSubCategoryLoadedState(subSubCategoryDetails: subSubCategoriesDetails));
     } catch(e) {
       emit(SubSubCategoryErrorState(errorMessage: e.toString()));
     }
   });
  }

}