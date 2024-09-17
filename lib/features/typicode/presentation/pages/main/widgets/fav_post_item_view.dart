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
      color: kAccentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4.0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded Text Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8.0), // Spacing
                  // Body Text
                  Text(
                    post.body,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black54,
                      height: 1.5, // Line height for better readability
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0), // Space between text and icon
            // Favorite Icon Section
            IconButton(
              icon: Icon(
                post.isSaved ? Icons.favorite : Icons.favorite_border,
                color: post.isSaved ? Colors.red : Colors.grey,
                size: 28.0,
              ),
              onPressed: onLikePressed,
            ),
          ],
        ),
      ),
    );
  }
}
