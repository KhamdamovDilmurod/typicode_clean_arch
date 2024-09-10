part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();
}

final class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}

final class PostsLoading extends PostsState {
  @override
  List<Object> get props => [];
}

final class PostsLoaded extends PostsState {
  final List<Post> posts;

  PostsLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}

final class PostError extends PostsState {
  final Failure failure;

  PostError({required this.failure});

  @override
  List<Object> get props => [failure];
}

final class PostRemoved extends PostsState {

  PostRemoved();

  @override
  List<Object> get props => [];
}

final class PostSaved extends PostsState {
  final Post post;

  PostSaved({required this.post});

  @override
  List<Object> get props => [post];
}