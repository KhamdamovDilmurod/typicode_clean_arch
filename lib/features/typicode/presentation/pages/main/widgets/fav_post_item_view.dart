import 'package:flutter/material.dart';
import '../../../../../../core/utilities/colors.dart';
import '../../../../domain/entities/post.dart';

class FavPostItemView extends StatelessWidget {
  final Post post;
  final VoidCallback onLikePressed;

  const FavPostItemView({
    Key? key,
    required this.post,
    required this.onLikePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(
          post.title,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(post.body),
        trailing: IconButton(
          icon: Icon(
            post.isSaved ? Icons.favorite : Icons.favorite_border,
            color: post.isSaved ? Colors.red : Colors.grey,
          ),
          onPressed: onLikePressed, // Call the passed callback function
        ),
      ),
    );
  }
}
