import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';

class GetPostsUseCase {
  final PostRepository repository;

  GetPostsUseCase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getPosts();
  }
}
