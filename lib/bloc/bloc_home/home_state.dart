import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeSuccessState extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeSignOutState extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class HomeErrorState extends HomeState {
  final String errorMessage;
  HomeErrorState({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}