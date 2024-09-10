import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';

class RemovePostUseCase {
  final PostRepository repository;

  RemovePostUseCase(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.removePost(id);
  }
}
