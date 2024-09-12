import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/assets.dart';
import '../../../../domain/entities/post.dart';
import '../../../bloc/posts_bloc.dart';

class PostItemView extends StatefulWidget {
  final Post post;

  const PostItemView({Key? key, required this.post}) : super(key: key);

  @override
  _PostItemViewState createState() => _PostItemViewState();
}

class _PostItemViewState extends State<PostItemView> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    // Initialize isLiked based on the post's isSaved field
    isLiked = widget.post.isSaved;
  }

  @override
  Widget build(BuildContext context) {
    final postsBloc = BlocProvider.of<PostsBloc>(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Image and Like Button
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    Assets.imagesImg1, // Replace with actual image
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Color(0xFFE040FB) : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });

                      if (isLiked) {
                        // Dispatch save post event
                        postsBloc.add(SavePost(post: widget.post));
                      } else {
                        // Dispatch remove post event
                        postsBloc.add(RemovePost(id: widget.post.id));
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Title and Post Body
            Text(
              widget.post.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A148C), // Dark purple for title
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.post.body,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
