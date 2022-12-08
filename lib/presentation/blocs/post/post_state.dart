part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class Empty extends PostState {
  @override
  List<Object> get props => [];
}

class Loading extends PostState {
  @override
  List<Object> get props => [];
}

class Error extends PostState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}

class GetAllPostSuccessState extends PostState {
  final List<Post> list;

  const GetAllPostSuccessState({required this.list});

  @override
  List<Object> get props => [list];
}

class GetOnePostSuccessState extends PostState {
  final Post post;

  const GetOnePostSuccessState({required this.post});
  @override
  List<Object> get props => [post];
}

class CreatePostSuccessState extends PostState {
  final Post post;

  const CreatePostSuccessState({required this.post});

  @override
  List<Object> get props => [post];
}

class EditPostSuccessState extends PostState {
  final Post post;

  const EditPostSuccessState({required this.post});

  @override
  List<Object> get props => [post];
}

class DeletePostSuccessState extends PostState {


  @override
  List<Object> get props => [];
}