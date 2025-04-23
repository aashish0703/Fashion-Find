import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

abstract class BannersState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BannerInitialState extends BannersState {}

class BannerLoadingState extends BannersState {}

class BannerLoadedState extends BannersState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> bannersList;
  BannerLoadedState({required this.bannersList});

  @override
  // TODO: implement props
  List<Object?> get props => [bannersList];
}

class BannerErrorState extends BannersState {
  final String errorMessage;
  BannerErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}