import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user.dart';

class UserController extends GetxController {
  late Database database;
  var users = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'user.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        );
      },
      version: 1,
    );
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final List<Map<String, dynamic>> result = await database.query('users');
    users.assignAll(result.map((data) => User.fromMap(data)).toList());
  }

  Future<void> insertUser(User user) async {
    await database.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    fetchUsers();
  }
}
