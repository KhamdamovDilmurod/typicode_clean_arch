import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/post.dart';
import '../../../domain/usecases/get_post_usecase.dart';
import '../../../domain/usecases/get_posts_usecase.dart';
import '../../../domain/usecases/get_saved_posts_usecases.dart';
import '../../../domain/usecases/remove_post_usecase.dart';
import '../../../domain/usecases/save_post_usecase.dart';
import '../../../../../core/error/failure.dart';

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
    on<SavePost>(_onSavePost);
    on<RemovePost>(_onRemovePost);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostsState> emit) async {
    emit(PostsLoading());
    final result = await getPostsUseCase();
    result.fold(
      (failure) => emit(PostError(failure: failure)),
      (posts) => emit(PostsLoaded(posts: posts)),
    );
  }

  Future<void> _onFetchSavedPosts(
      FetchSavedPosts event, Emitter<PostsState> emit) async {
    emit(PostsLoading());
    print("Fetching saved posts...");
    final result = await getSavedPostsUseCase();
    result.fold(
      (failure) => emit(PostError(failure: failure)),
      (posts) {

        print("Saved posts fetched: ${posts.length}");
        emit(SavedPostsLoaded(posts: posts));
      },
    );
  }

  Future<void> _onSavePost(SavePost event, Emitter<PostsState> emit) async {
    final result = await savePostUseCase(event.post);
    result.fold(
      (failure) => emit(PostError(failure: failure)),
      (_) {
        print("saved");
      },
    );
  }

  Future<void> _onRemovePost(RemovePost event, Emitter<PostsState> emit) async {
    final result = await removePostUseCase(event.id);
    result.fold(
      (failure) => emit(PostError(failure: failure)),
      (_) {},
    );
  }
}
