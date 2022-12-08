import 'package:dartz/dartz.dart';
import 'package:tdd_post/core/error/failures.dart';
import 'package:tdd_post/domain/entities/post_entity.dart';
import 'package:tdd_post/domain/repositories/post_base_repository.dart';
import 'package:tdd_post/domain/usecases/base_usecase.dart';

class GetAllPostUseCase extends UseCase<List<Post>, NoParams> {
  PostBaseRepository postBaseRepository;

  GetAllPostUseCase(this.postBaseRepository);

  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) async {
    return await postBaseRepository.getAllPost();
  }
}