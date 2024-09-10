import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/post_model.dart';
import '../../models/user_model.dart';

abstract class LocalDataSource {
  Future<void> addUser(UserModel user);
  Future<List<UserModel>> getUsers();
  Future<void> updateUser(UserModel user);
  Future<void> deleteUser(int id);

  Future<void> addPost(PostModel post);
  Future<List<PostModel>> getPosts();
  Future<void> updatePost(PostModel post);
  Future<void> deletePost(int id);
}

class LocalDataSourceImpl implements LocalDataSource {
  static const _databaseName = "app_database.db";
  static const _databaseVersion = 1;

  static const userTable = 'user_table';
  static const postTable = 'post_table';

  static Database? _database;

  Future<Database> get _db async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $userTable (
      id INTEGER PRIMARY KEY,
      name TEXT,
      username TEXT,
      email TEXT,
      phone TEXT,
      website TEXT,
      street TEXT,
      suite TEXT,
      city TEXT,
      zipcode TEXT,
      lat TEXT,
      lng TEXT,
      companyName TEXT,
      companyCatchPhrase TEXT,
      companyBs TEXT
    )
    ''');

    await db.execute('''
    CREATE TABLE $postTable (
      id INTEGER PRIMARY KEY,
      title TEXT,
      body TEXT,
      userId INTEGER
    )
    ''');
  }

  @override
  Future<void> addUser(UserModel user) async {
    final db = await _db;
    await db.insert(
      userTable,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<UserModel>> getUsers() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(userTable);

    return List.generate(maps.length, (i) {
      return UserModel.fromJson(maps[i]);
    });
  }

  @override
  Future<void> updateUser(UserModel user) async {
    final db = await _db;
    await db.update(
      userTable,
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  @override
  Future<void> deleteUser(int id) async {
    final db = await _db;
    await db.delete(
      userTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> addPost(PostModel post) async {
    final db = await _db;
    await db.insert(
      postTable,
      post.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<PostModel>> getPosts() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(postTable);

    return List.generate(maps.length, (i) {
      return PostModel.fromJson(maps[i]);
    });
  }

  @override
  Future<void> updatePost(PostModel post) async {
    final db = await _db;
    await db.update(
      postTable,
      post.toJson(),
      where: 'id = ?',
      whereArgs: [post.id],
    );
  }

  @override
  Future<void> deletePost(int id) async {
    final db = await _db;
    await db.delete(
      postTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> closeDatabase() async {
    final db = await _db;
    await db.close();
  }

}
