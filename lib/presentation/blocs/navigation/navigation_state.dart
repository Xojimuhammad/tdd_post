part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  final String currentPage;

  const NavigationState({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

class NavigationInitial extends NavigationState {

  const NavigationInitial({required super.currentPage});
}

class OpenSuccessState extends NavigationState {
  final String nextPage;
  final Map<String, dynamic> message;

  const OpenSuccessState({required super.currentPage, required this.nextPage, required this.message});

  @override
  List<Object> get props => [nextPage, message];
}

class BackSuccessState extends NavigationState {
  final String message;

  const BackSuccessState({required super.currentPage, required this.message});
  @override
  List<Object> get props => [message];
}

class ErrorNavigationState extends NavigationState {
  final String message;

  const ErrorNavigationState({required super.currentPage, required this.message});
  @override
  List<Object> get props => [message];
}