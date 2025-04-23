import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MakeSearchEvent extends SearchEvent {
  final String searchQuery;
  MakeSearchEvent({required this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}