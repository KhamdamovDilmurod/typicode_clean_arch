import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class GetPostUseCase {
  final PostRepository repository;

  GetPostUseCase(this.repository);

  Future<Either<Failure, Post>> call(int id) async {
    return await repository.getPost(id);
  }
}