import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/error/failures.dart';
import '../../data/models/post_model.dart';
import '../entities/post_entity.dart';
import '../repositories/post_base_repository.dart';
import 'base_usecase.dart';

class EditPostUseCase extends UseCase<Post, EditParams> {
  PostBaseRepository postBaseRepository;

  EditPostUseCase(this.postBaseRepository);

  @override
  Future<Either<Failure, Post>> call(EditParams params) async {
    PostModel post = PostModel(title: params.title, body: params.body, id: params.id, userId: params.userId);
    return await postBaseRepository.editPost(post);
  }
}

class EditParams extends Equatable {
  final String title;
  final String body;
  final int userId;
  final String id;

  const EditParams({
    required this.title,
    required this.body,
    required this.userId,
    required this.id,
  });

  @override
  List<Object> get props => [title, body, userId, id];
}