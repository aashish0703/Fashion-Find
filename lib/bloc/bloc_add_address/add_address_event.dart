import 'package:equatable/equatable.dart';

abstract class AddAddressEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EventAddAddress extends AddAddressEvent {
  final String uid;
  final String address;

  EventAddAddress({required this.uid, required this.address});

  @override
  // TODO: implement props
  List<Object?> get props => [uid, address];
}