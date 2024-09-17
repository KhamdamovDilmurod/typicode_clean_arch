import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:typicode_clean_arch/features/typicode/presentation/pages/main/widgets/shimmer_post_view.dart';

import '../../../../../../core/utilities/colors.dart';
import '../../../../domain/entities/post.dart';
import '../../../../domain/entities/user.dart';
import '../../../bloc/post_blog/posts_bloc.dart';
import '../../../bloc/user_blog/users_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    _postsBloc = BlocProvider.of<PostsBloc>(context);
    _usersBloc = BlocProvider.of<UsersBloc>(context);
    _postsBloc.add(FetchPosts());
    _usersBloc.add(FetchUsers());

    print("home created");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildUserSection()), // User section
          SliverToBoxAdapter(child: _bannerSection()), // Banner section
          SliverToBoxAdapter(child: _buildSectionTitle('Posts')), // Section title
          _buildPostSection(), // Post section
        ],
      ),
    );
  }

  Widget _bannerSection() {
    return BannerSection(); // Your banner widget
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
      ),
    );
  }

  Widget _buildPostSection() {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is PostsLoading) {
          return SliverFillRemaining(child: ShimmerPostView()); // Show shimmer while loading
        } else if (state is PostError) {
          return SliverFillRemaining(child: Center(child: Text('Error: ${state.failure}')));
        } else if (state is PostsLoaded) {
          return _buildPostList(state.posts);
        }
        return SliverFillRemaining(child: Center(child: Text('No post available')));
      },
    );
  }

  Widget _buildPostList(List<Post> posts) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final post = posts[index];
          return PostItemView(post: post); // PostItemView widget for each post
        },
        childCount: posts.length,
      ),
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

  Widget _buildUserList(List<User> users) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return UserItemView(user: user); // UserItemView widget for each user
        },
      ),
    );
  }
}
