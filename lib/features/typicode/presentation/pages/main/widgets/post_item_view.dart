import 'package:flutter/material.dart';
import '../../../../domain/entities/post.dart';

class PostItemView extends StatefulWidget {
  final Post post;
  const PostItemView({Key? key, required this.post}) : super(key: key);

  @override
  _PostItemViewState createState() => _PostItemViewState();
}

class _PostItemViewState extends State<PostItemView> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white, // Background color for the post card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    'https://via.placeholder.com/150', // Replace with actual post image URL if available
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
                      color: isLiked ? Color(0xFFE040FB) : Colors.grey, // Pinkish purple for liked state
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
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
                height: 1,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A148C), // Dark purple for title
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.post.body,
              style: TextStyle(
                height: 1,
                fontSize: 16,
                color: Colors.grey[800], // Slightly darker grey for better readability
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
