import 'package:flutter/material.dart';

import '../../domain/entities/post.dart';

class PostItemView extends StatefulWidget {
  final Post post;
  const PostItemView({Key? key, required this.post}) : super(key: key);

  @override
  _PostItemViewState createState() => _PostItemViewState();
}

class _PostItemViewState extends State<PostItemView> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.post.title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(widget.post.body),
      trailing: IconButton(
        icon: Icon(Icons.favorite_border, color: Colors.redAccent),
        onPressed: () {
        },
      ),
    );;
  }
}
