import 'package:tdd_post/core/error/failures.dart';
import 'package:tdd_post/domain/entities/post_entity.dart';
import 'package:dartz/dartz.dart';
import '../../data/models/post_model.dart';

abstract class PostBaseRepository {

  Future<Either<Failure, List<Post>>> getAllPost();
  Future<Either<Failure, Post>> getOnePost(String id);
  Future<Either<Failure, Post>> createPost(PostModel post);
  Future<Either<Failure, Post>> editPost(PostModel post);
  Future<Either<Failure, bool>> deletePost(String id);
}