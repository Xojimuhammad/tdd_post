part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class OpenEvent extends NavigationEvent {
  final String page;
  final Map<String, dynamic> data;

  const OpenEvent({required this.page, required this.data});

  @override
  List<Object> get props => [page, data];
}

class BackEvent extends NavigationEvent {
  @override
  List<Object> get props => [];
}