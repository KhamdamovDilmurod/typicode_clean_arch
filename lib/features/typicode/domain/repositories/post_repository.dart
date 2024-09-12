import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/post.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts();
  Future<Either<Failure, Post>> getPost(int id);
  Future<Either<Failure, void>> savePost(Post post);
  Future<Either<Failure, void>> removePost(int id);
  Future<Either<Failure, List<Post>>> fetchSavedPosts();
}
