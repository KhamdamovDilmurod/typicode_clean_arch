import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';

class SavePostUseCase {
  final PostRepository repository;

  SavePostUseCase(this.repository);

  Future<Either<Failure, void>> call(Post post) async {
    return await repository.savePost(post);
  }
}
