import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:quizapp/model/user.dart';
import 'package:quizapp/database/database_service.dart';

class UserDB {
  final String tableName = 'user';
  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" TEXT PRIMARY KEY ,
      "email" TEXT NOT NULL,
      "password" TEXT NOT NULL
      );""");
  }
  
  Future<int> createUser({required String id, required String email, required String password}) async {
    final database = await DatabaseService().database;
    await createTable(database);
    return await database.rawInsert(
      '''INSERT INTO $tableName (id,email, password) VALUES (?,?,?)''',
      [id,email, password],
    );
  }

  Future<List<Users>> getAllUsers() async {
    final database = await DatabaseService().database;
    await createTable(database);
    final List<Map<String, dynamic>> maps = await database.query(tableName);
    return List.generate(maps.length, (i) {
      return Users(
        id: maps[i]['id'],
        email: maps[i]['email'],
        password: maps[i]['password'],
      );
    });
  }

  Future<Users?> getUserByEmail(String email) async {
    final database = await DatabaseService().database;
    await createTable(database);
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return Users(
        id: maps.first['id'],
        email: maps.first['email'],
        password: maps.first['password'],
      );
    } else {
      return null;
    }
  }
}


// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:navigations/model/user.dart';
// import 'package:navigations/database/database_service.dart';

// class UserDB {
//   final String tableName = 'user';

//   Future<void> createTable(Database database) async {
//     await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
//       "id" TEXT PRIMARY KEY,
//       "email" TEXT NOT NULL,
//       "password" TEXT NOT NULL
//       );""");
//   }

//   Future<int> createUser({required String id, required String email, required String password}) async {
//     final database = await DatabaseService().database;
//     await createTable(database);
//     return await database.insert(
//       tableName,
//       {'id': id, 'email': email, 'password': password},
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }




//   Future<Users?> getUserByEmail(String email) async {
//     final database = await openDatabase(join(await getDatabasesPath(), 'user_database.db'));
//     await createTable(database);
//     final List<Map<String, dynamic>> maps = await database.query(
//       tableName,
//       where: 'email = ?',
//       whereArgs: [email],
//     );

//     if (maps.isNotEmpty) {
//       return Users.fromMap(maps.first);
//     } else {
//       return null;
//     }
//   }
// }
