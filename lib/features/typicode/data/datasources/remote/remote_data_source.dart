import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../../core/utilities/constants.dart';
import '../../models/post_model.dart';
import '../../models/user_model.dart'; // Import the constants file

// Define the abstract class for remote data source
abstract class RemoteDataSource {
  Future<List<UserModel>> getUsers();

  Future<List<PostModel>> getPosts();
}

// Implementation of the remote data source
class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await client.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      final List<dynamic> userJson = json.decode(response.body);
      final users = userJson.map((json) => UserModel.fromJson(json)).toList();
      print(users);
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await client.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode == 200) {
      final List<dynamic> postJson = json.decode(response.body);
      final posts = postJson.map((json) => PostModel.fromJson(json)).toList();
      print(posts);
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
