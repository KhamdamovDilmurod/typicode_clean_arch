import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utilities/network_info.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/local/local_data_source.dart';
import '../datasources/remote/remote_data_source.dart';
import '../models/post_model.dart'; // Ensure this import is correct

class PostRepositoryImpl implements PostRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getPosts();
        return Right(remotePosts);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> savePost(Post post) async {
    try {
      // Convert Post to PostModel
      final postModel = PostModel(
        id: post.id,
        title: post.title,
        body: post.body,
        userId: post.userId,
      );
      await localDataSource.addPost(postModel);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removePost(int id) async {
    try {
      await localDataSource.deletePost(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
