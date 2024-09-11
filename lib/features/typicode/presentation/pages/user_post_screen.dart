import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typicode_clean_arch/features/typicode/presentation/widgets/user_item_view.dart';
import '../bloc/posts_bloc.dart';
import '../bloc/users_bloc.dart';
import '../../domain/entities/post.dart';
import '../../domain/entities/user.dart';
import '../widgets/post_item_view.dart';

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
      appBar: AppBar(
        title: Text('User & Post Management', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Users'),
            _buildUserSection(),
            SizedBox(height: 20),
            _buildSectionTitle('Posts'),
            _buildPostSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
    );
  }

  Widget _buildPostSection() {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is PostsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PostError) {
          return Center(child: Text('Error: ${state.failure}'));
        } else if (state is PostsLoaded) {
          return _buildPostList(state.posts);
        }
        return Center(child: Text('No posts available'));
      },
    );
  }

  Widget _buildUserSection() {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is UsersLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is UserError) {
          return Center(child: Text('Error: ${state.failure}'));
        } else if (state is UsersLoaded) {
          return _buildUserList(state.users);
        }
        return Center(child: Text('No users available'));
      },
    );
  }

  Widget _buildPostList(List<Post> posts) {
    return Expanded(
      child: ListView.separated(
        itemCount: posts.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostItemView(post: post);
        },
      ),
    );
  }

  Widget _buildUserList(List<User> users) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: users.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final user = users[index];
          return UserItemView(user: user);
        },
      ),
    );
  }
}
