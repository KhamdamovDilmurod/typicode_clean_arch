import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/posts_bloc.dart';
import '../widgets/post_item_view.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => context.read<PostsBloc>()..add(FetchSavedPosts()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
        ),
        body: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is PostsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PostError) {
              return Center(child: Text('Error: ${state.failure}'));
            } else if (state is PostsLoaded) {
              final posts = state.posts.where((post) => post.isSaved).toList();
              if (posts.isEmpty) {
                return Center(child: Text('No favorite posts available.'));
              }
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return PostItemView(post: post);
                },
              );
            }
            return Center(child: Text('No posts available'));
          },
        ),
      ),
    );
  }
}
