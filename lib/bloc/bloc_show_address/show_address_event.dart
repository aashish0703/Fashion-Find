import 'package:equatable/equatable.dart';

abstract class ShowAddressEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadAllAddressEvent extends ShowAddressEvent {
  final String uid;
  LoadAllAddressEvent({required this.uid});

  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}

class DeletePrimaryAddressEvent extends ShowAddressEvent {
  final String uid;

  DeletePrimaryAddressEvent({required this.uid});

  @override
  // TODO: implement props
  List<Object?> get props => [uid];
}

class DeleteAddressEvent extends ShowAddressEvent {
  final String uid;
  final String address;

  DeleteAddressEvent({required this.uid, required this.address});

  @override
  // TODO: implement props
  List<Object?> get props => [uid, address];
}