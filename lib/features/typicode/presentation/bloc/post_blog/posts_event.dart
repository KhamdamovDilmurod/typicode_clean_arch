part of 'posts_bloc.dart';

sealed class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

// Event to fetch posts
final class FetchPosts extends PostsEvent {}

// Event to remove a post
final class RemovePost extends PostsEvent {
  final int id;

  RemovePost({required this.id});

  @override
  List<Object> get props => [id];
}

// Event to save a post
final class SavePost extends PostsEvent {
  final Post post;

  SavePost({required this.post});

  @override
  List<Object> get props => [post];
}

final class FetchSavedPosts extends PostsEvent {}

