import 'package:flutter/material.dart';

import '../../../../domain/entities/user.dart';

class UserItemView extends StatelessWidget {
  final User user;
  const UserItemView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
radius: 30,
            backgroundColor: Colors.deepPurple,
            child: Text(user.name[0], style: TextStyle(color: Colors.white)),
          ),
          SizedBox(

            width: 100,
            child: Text(
              textAlign: TextAlign.center,
              user.username,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );;
  }
}
