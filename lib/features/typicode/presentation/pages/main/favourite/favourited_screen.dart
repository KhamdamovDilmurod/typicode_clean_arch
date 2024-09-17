import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../../core/utilities/colors.dart';
import '../../../../domain/entities/post.dart';
import '../../../bloc/post_blog/posts_bloc.dart';
import '../widgets/fav_post_item_view.dart';
import '../widgets/shimmer_post_view.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late PostsBloc _postsBloc;

  @override
  void initState() {
    super.initState();
    _postsBloc = BlocProvider.of<PostsBloc>(context);
    _postsBloc.add(FetchSavedPosts());
    print(" FetchSavedPosts created");
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
        "Favorites",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Favorite Posts'),
          Expanded(child: _buildFavoritePostSection()),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
      ),
    );
  }

  Widget _buildFavoritePostSection() {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is PostsFetchLoading) {
          return Expanded(child: ShimmerPostView());
        } else if (state is PostError) {
          return Center(child: Text('Something went wrong'));
        } else if (state is SavedPostsLoaded) {
          print("here we are");
          return _buildFavPostList(state.posts);
        }
        return Center(child: Text(state.toString()));
      },
    );
  }

  Widget _buildFavPostList(List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return FavPostItemView(
          post: post,
          onLikePressed: () {
            setState(() {
              // Trigger post removal on pressing like
              _postsBloc.add(RemovePost(id: post.id));
              posts.removeAt(index);
            });
          },
        );
      },
    );
  }
}
