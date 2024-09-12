import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_post_usecase.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../domain/usecases/get_saved_posts_usecases.dart';
import '../../domain/usecases/remove_post_usecase.dart';
import '../../domain/usecases/save_post_usecase.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetPostsUseCase getPostsUseCase;
  final GetSavedPostsUseCase getSavedPostsUseCase;
  final GetPostUseCase getPostUseCase;
  final RemovePostUseCase removePostUseCase;
  final SavePostUseCase savePostUseCase;

  PostsBloc({
    required this.getPostsUseCase,
    required this.getSavedPostsUseCase,
    required this.getPostUseCase,
    required this.removePostUseCase,
    required this.savePostUseCase,
  }) : super(PostsInitial()) {
    on<FetchPosts>(_onFetchPosts);
    on<FetchSavedPosts>(_onFetchSavedPosts);
    on<RemovePost>(_onRemovePost);
    on<SavePost>(_onSavePost);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostsState> emit) async {
    emit(PostsLoading());
    final result = await getPostsUseCase();
    result.fold(
      (failure) => emit(PostError(failure: failure)),
      (posts) => emit(PostsLoaded(posts: posts)),
    );
  }

  Future<void> _onFetchSavedPosts(FetchSavedPosts event, Emitter<PostsState> emit) async {
    emit(PostsLoading());
    final result = await getSavedPostsUseCase();
    result.fold(
      (failure) => emit(PostError(failure: failure)),
      (posts) => emit(PostsLoaded(posts: posts)),
    );
  }

  Future<void> _onRemovePost(RemovePost event, Emitter<PostsState> emit) async {
    // emit(PostsLoading());
    final result = await removePostUseCase(event.id);
    result.fold(
      (failure) => emit(PostError(failure: failure)),
      (_) {
        // emit(PostRemoved());
        // add(FetchPosts());
      },
    );
  }

  Future<void> _onSavePost(SavePost event, Emitter<PostsState> emit) async {
    // emit(PostsLoading());
    final result = await savePostUseCase(event.post);
    result.fold(
      (failure) => emit(PostError(failure: failure)),
      (_) {
        // emit(PostSaved(post: event.post));
        // add(FetchPosts());
      },
    );
  }
}
