import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/error/failures.dart';
import '../../data/models/post_model.dart';
import '../entities/post_entity.dart';
import '../repositories/post_base_repository.dart';
import 'base_usecase.dart';

class CreatePostUseCase extends UseCase<Post, Params> {
  PostBaseRepository postBaseRepository;

  CreatePostUseCase(this.postBaseRepository);

  @override
  Future<Either<Failure, Post>> call(Params params) async {
    PostModel post = PostModel(title: params.title, body: params.body, id: "01", userId: params.userId);
    return await postBaseRepository.createPost(post);
  }
}

class Params extends Equatable {
  final String title;
  final String body;
  final int userId;

  const Params({
    required this.title,
    required this.body,
    required this.userId,
  });

  @override
  List<Object?> get props => [title, body, userId];
}