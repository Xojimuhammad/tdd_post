import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_post/core/error/failures.dart';
import 'package:tdd_post/domain/entities/post_entity.dart';
import 'package:tdd_post/domain/usecases/base_usecase.dart';
import '../../../domain/usecases/create_post_usercase.dart';
import '../../../domain/usecases/delete_post_usercase.dart';
import '../../../domain/usecases/edit_post_usercase.dart';
import '../../../domain/usecases/get_all_post_usecases.dart';
import '../../../domain/usecases/get_one_post_usercase.dart';
part 'post_event.dart';
part 'post_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input - The number must be a positive integer or zero.';


class PostBloc extends Bloc<PostEvent, PostState> {
  CreatePostUseCase createPostUseCase;
  GetAllPostUseCase getAllPostUseCase;
  EditPostUseCase editPostUseCase;
  DeletePostUseCase deletePostUseCase;
  GetOnePostUseCase getOnePostUseCase;


  PostBloc({
    required this.getOnePostUseCase,
    required this.getAllPostUseCase,
    required this.createPostUseCase,
    required this.editPostUseCase,
    required this.deletePostUseCase,
  }) : super(Empty()) {
    on<GetOnePostEvent>(getOnePost);
    on<GetAllPostEvent>(getAllPost);
    on<CreatePostEvent>(createPost);
    on<EditPostEvent>(editPost);
    on<DeletePostEvent>(deletePost);
  }

  Future<void> getOnePost(GetOnePostEvent event, Emitter<PostState> emitter) async {
    emitter(Loading());
    final failureOrTrivia = await getOnePostUseCase(GetOneParams(id: event.id));
    failureOrTrivia.fold(
          (failure) => emitter(Error(message: _mapFailureToMessage(failure))),
          (post) => emitter(GetOnePostSuccessState(post: post)),
    );
  }

  Future<void> getAllPost(GetAllPostEvent event, Emitter<PostState> emitter) async {
    emitter(Loading());
    final failureOrTrivia = await getAllPostUseCase(NoParams());
    failureOrTrivia.fold(
          (failure) => emitter(Error(message: _mapFailureToMessage(failure))),
          (list) => emitter(GetAllPostSuccessState(list: list)),
    );
  }

  Future<void> createPost(CreatePostEvent event, Emitter<PostState> emitter) async {
    emitter(Loading());
    final failureOrTrivia = await createPostUseCase(Params(title: event.title, body: event.body, userId: 1));
    failureOrTrivia.fold(
          (failure) => emitter(Error(message: _mapFailureToMessage(failure))),
          (post) => emitter(CreatePostSuccessState(post: post)),
    );
  }

  Future<void> editPost(EditPostEvent event, Emitter<PostState> emitter) async {
    emitter(Loading());
    final failureOrTrivia = await editPostUseCase(EditParams(title: event.title, body: event.body, userId: 1, id: event.id));
    failureOrTrivia.fold(
          (failure) => emitter(Error(message: _mapFailureToMessage(failure))),
          (post) => emitter(EditPostSuccessState(post: post)),
    );
  }

  Future<void> deletePost(DeletePostEvent event, Emitter<PostState> emitter) async {
    emitter(Loading());
    final failureOrTrivia = await deletePostUseCase(DeleteParams(id: event.id));
    failureOrTrivia.fold(
          (failure) => emitter(Error(message: _mapFailureToMessage(failure))),
          (post) => emitter(DeletePostSuccessState()),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}