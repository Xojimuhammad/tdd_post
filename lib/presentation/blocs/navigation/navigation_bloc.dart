import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc({required String currentPage}) : super(NavigationInitial(currentPage: currentPage)) {
    on<OpenEvent>(open);
    on<BackEvent>(back);
  }

  void open(OpenEvent event, Emitter<NavigationState> emit) {
    emit(OpenSuccessState(currentPage: state.currentPage, nextPage: event.page, message: event.data));
  }

  void back(BackEvent event, Emitter<NavigationState> emit) {
    emit(BackSuccessState(currentPage: state.currentPage, message: "message"));
  }
}