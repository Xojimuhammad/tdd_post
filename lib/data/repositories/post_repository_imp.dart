import 'package:dartz/dartz.dart';
import '../../core/error/exception.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_base_repository.dart';
import '../datasources/post_local_data_source.dart';
import '../datasources/post_remote_data_sources.dart';
import '../models/post_model.dart';

class PostRepositoryImp implements PostBaseRepository {

  final PostLocalDataSource localDataSource;
  final PostRemoteDataSource remoteDataSource;
  final NetworkInfo info;

  PostRepositoryImp({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.info,
  });

  @override
  Future<Either<Failure, List<PostModel>>> getAllPost() async {
    if (await info.isConnected) {
      try {
        final remotePost = await remoteDataSource.getAllPost();
        localDataSource.cacheNListPost(remotePost);
        return Right(remotePost);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localList = await localDataSource.getLastListPost();
        return Right(localList);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Post>> createPost(PostModel post) async {
    if(await info.isConnected) {
      try {
        final remotePost = await remoteDataSource.createPost(post.toJson());
        localDataSource.cacheOneAddPost(post);
        return Right(remotePost);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deletePost(String id) async {
    if(await info.isConnected) {
      try {
        final result = await remoteDataSource.deletePost(id);
        localDataSource.cacheOneDeletePost(id);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Post>> editPost(PostModel post) async{
    if(await info.isConnected) {
      try {
        final remotePost = await remoteDataSource.editPost(post.toJson(), post.id);
        localDataSource.cacheOneUpdatePost(post);
        return Right(remotePost);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PostModel>> getOnePost(String id) async {
    if(await info.isConnected) {
      try {
        var result = await localDataSource.getOnePost(id);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}