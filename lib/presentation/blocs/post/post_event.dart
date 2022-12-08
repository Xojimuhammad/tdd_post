part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class GetOnePostEvent extends PostEvent {
  final String id;

  const GetOnePostEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class GetAllPostEvent extends PostEvent {
  @override
  List<Object> get props => [];
}

class CreatePostEvent extends PostEvent {
  final String title;
  final String body;

  const CreatePostEvent({required this.title, required this.body});

  @override
  List<Object> get props => [title, body];
}

class EditPostEvent extends PostEvent {
  final String title;
  final String body;
  final String id;

  const EditPostEvent({required this.title, required this.body, required this.id});

  @override
  List<Object> get props => [title, body];
}

class DeletePostEvent extends PostEvent {
  final String id;

  const DeletePostEvent({required this.id});

  @override
  List<Object?> get props => [id];
}