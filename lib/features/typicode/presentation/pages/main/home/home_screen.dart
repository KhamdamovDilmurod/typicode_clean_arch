import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utilities/colors.dart';
import '../../../../domain/entities/post.dart';
import '../../../../domain/entities/user.dart';
import '../../../bloc/posts_bloc.dart';
import '../../../bloc/users_bloc.dart';
import '../widgets/banner_section.dart';
import '../widgets/post_item_view.dart';
import '../widgets/shimmer_user_view.dart';
import '../widgets/user_item_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PostsBloc _postsBloc;
  late UsersBloc _usersBloc;

  final ScrollController _scrollController = ScrollController();

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: _appBar(),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserSection(),
          _bannerSection(),
          _buildSectionTitle('Posts'),
          _buildPostSection(),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [kPrimaryColor, kAccentColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Text(
        "Blog App",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _bannerSection() {
    return BannerSection();
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
          return ShimmerUserView();
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
      child: ListView.builder(
        controller: _scrollController,
        itemCount: posts.length,
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



