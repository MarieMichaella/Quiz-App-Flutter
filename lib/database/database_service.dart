// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:quizapp/quiz_db.dart';
// import 'dart:io';

// class DatabaseService {
//   Database? _database;

//   // Define the custom directory path where you want to store the database
//   static const String customDirectory = 'C:\\Users\\MarieMichaellaRugumb\\Desktop\\sqflutter';


//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//     _database = await _initialize();
//     return _database!;
//   }

//   Future<String> get fullPath async {
//     const name = 'quizzzess.db';
//     // Check if the custom directory exists, if not, create it
//     if (!(await Directory(customDirectory).exists())) {
//       await Directory(customDirectory).create(recursive: true);
//     }
//     return join(customDirectory, name);
//   }

//   Future<Database> _initialize() async {
//     final path = await fullPath;
//     var database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: create,
//       singleInstance: true,
//     );
//     return database;
//   }

//   Future<void> create(Database database, int version) async => 
//     await QuizDB().createTable(database);
// }


// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:quizapp/quiz_db.dart';
// class DatabaseService {
//   Database? _database;

//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//     _database = await _initialize();
//     return _database!;
//   }

// Future<String> get fullPath async {
//   const name = 'Onlinequizes.db';
//   final path = await getDatabasesPath();
//   print('Database Path: $path');
//   return join(path, name);
// }

//   Future<Database> _initialize() async {
//     final path = await fullPath;
//     var database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: create,
//       singleInstance: true,
//     );
//     return database;
//   }

//   Future<void> create(Database database, int version) async => 
//   await QuizDB().createTable(database);

// }


import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:quizapp/quiz_db.dart';
import 'package:quizapp/answers_db.dart'; 
import 'package:quizapp/question_db.dart';
import 'package:quizapp/user_db.dart'; 
import 'package:quizapp/user_answer.dart'; 

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'newQuizzes.db';
    final path = await getDatabasesPath();
    print('Database Path: $path');
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return database;
  }

  Future<void> create(Database database, int version) async {
    await QuizDB().createTable(database);
    await AnswerDB().createTable(database); 
    await QuestionDB().createTable(database); 
    await UserDB().createTable(database); 
    await UserAnswerDB().createTable(database); 
  }
}


