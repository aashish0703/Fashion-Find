import 'package:equatable/equatable.dart';

abstract class BannersEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadBannersEvent extends BannersEvent {}