import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/error/failures.dart';
import '../entities/post_entity.dart';
import '../repositories/post_base_repository.dart';
import 'base_usecase.dart';

class GetOnePostUseCase extends UseCase<Post, GetOneParams> {
  PostBaseRepository postBaseRepository;

  GetOnePostUseCase(this.postBaseRepository);

  @override
  Future<Either<Failure, Post>> call(GetOneParams params) async {
    return await postBaseRepository.getOnePost(params.id);
  }
}

class GetOneParams extends Equatable {
  final String id;

  const GetOneParams({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}