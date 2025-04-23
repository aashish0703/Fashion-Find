import 'package:fashion_find/bloc/bloc_banners/banners_event.dart';
import 'package:fashion_find/bloc/bloc_banners/banners_state.dart';
import 'package:fashion_find/repository/firebase_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannersBloc extends Bloc<BannersEvent, BannersState> {

  final _firebaseRepo = FirebaseRepo();

  BannersBloc() : super(BannerInitialState()) {
    on<LoadBannersEvent>((event, emit) async {
      emit(BannerLoadingState());
      try {
        final banners = await _firebaseRepo.getBanners();
        emit(BannerLoadedState(bannersList: banners));
      } catch (e) {
        emit(BannerErrorState(errorMessage: e.toString()));
      }
    });
  }

}