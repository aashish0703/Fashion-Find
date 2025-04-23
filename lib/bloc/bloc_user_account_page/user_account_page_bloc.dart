import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_find/bloc/bloc_user_account_page/user_account_page_event.dart';
import 'package:fashion_find/bloc/bloc_user_account_page/user_account_page_state.dart';
import 'package:fashion_find/model/user_model.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAccountPageBloc extends Bloc<UserAccountPageEvent, UserAccountPageState> {

  final _firebaseRepo = FirebaseRepo();

  UserAccountPageBloc() : super(UserAccountPageInitialState()) {
   on<LoadUserAccountPageEvent>((event, emit) async {
     emit(UserAccountPageLoadingState());
     try {
       Stream<DocumentSnapshot> user = await _firebaseRepo.getUserDetail(event.uid);
       emit(UserAccountPageLoadedState(user: user));
     } catch (e) {
       emit(UserAccountPageErrorState(errorMessage: e.toString()));
     }
   });

   on<DeleteUserEvent>((event, emit) async {
     emit(UserAccountPageLoadingState());
     try {
       await _firebaseRepo.deleteUser(event.uid);
       emit(UserAccountPageDeleteUserState());
     } catch (e) {
       emit(UserAccountPageErrorState(errorMessage: e.toString()));
     }
   });

  }


}