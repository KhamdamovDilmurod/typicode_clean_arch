import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/posts_bloc.dart';
import '../bloc/users_bloc.dart';
import '../../domain/entities/post.dart';
import '../../domain/entities/user.dart';

class UserPostScreen extends StatefulWidget {
  @override
  _UserPostScreenState createState() => _UserPostScreenState();
}

class _UserPostScreenState extends State<UserPostScreen> {
  late PostsBloc _postsBloc;
  late UsersBloc _usersBloc;

  @override
  void initState() {
    super.initState();
    _postsBloc = BlocProvider.of<PostsBloc>(context);
    _usersBloc = BlocProvider.of<UsersBloc>(context);
    _postsBloc.add(FetchPosts());
    _usersBloc.add(FetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User & Post Management')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Posts section
            BlocBuilder<PostsBloc, PostsState>(
              builder: (context, state) {
                if (state is PostsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is PostError) {
                  return Center(child: Text('Error: ${state.failure}'));
                } else if (state is PostsLoaded) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 300, // Constrain the height
                        child: ListView.builder(
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            final post = state.posts[index];
                            return ListTile(
                              title: Text(post.title),
                              subtitle: Text(post.body),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _postsBloc.add(RemovePost(id: post.id));
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final newPost = Post(id: 0, title: 'New Post', body: 'Content', userId: 0);
                          _postsBloc.add(SavePost(post: newPost));
                        },
                        child: Text('Add New Post'),
                      ),
                    ],
                  );
                }
                return Center(child: Text('No posts available'));
              },
            ),

            // Users section
            BlocBuilder<UsersBloc, UsersState>(
              builder: (context, state) {
                if (state is UsersLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is UserError) {
                  return Center(child: Text('Error: ${state.failure}'));
                } else if (state is UsersLoaded) {
                  return SizedBox(
                    height: 300, // Constrain the height
                    child: ListView.builder(
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return ListTile(
                          title: Text(user.name),
                          subtitle: Text(user.email),
                        );
                      },
                    ),
                  );
                }
                return Center(child: Text('No users available'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
