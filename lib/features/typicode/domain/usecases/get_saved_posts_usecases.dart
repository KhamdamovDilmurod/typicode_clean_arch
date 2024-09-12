
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class GetSavedPostsUseCase {
  final PostRepository repository;

  GetSavedPostsUseCase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.fetchSavedPosts();
  }
}