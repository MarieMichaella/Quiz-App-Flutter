// 

// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//   static Database? _database;

//   DatabaseHelper._privateConstructor();

//   // Define table and columns
//   static const String tableCategories = 'categories';
//   static const String columnId = 'id';
//   static const String columnCategoryName = 'categoryName';
//   static const String columnDescription = 'description';

//   // Open database
//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   // Initialize database
//   Future<Database> _initDatabase() async {
//     final String path = join(await getDatabasesPath(), 'app_database.db');
//     return openDatabase(path, version: 1, onCreate: _createDb);
//   }

//   // Create database table
//   Future<void> _createDb(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE $tableCategories (
//         $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
//         $columnCategoryName TEXT NOT NULL,
//         $columnDescription TEXT NOT NULL
//       )
//     ''');
//   }

//   // Insert data into table
//   Future<int> insertCategory(Map<String, dynamic> category) async {
//     Database db = await instance.database;
//     return await db.insert(tableCategories, category);
//   }
// }

// // Example usage
// void main() async {
//   final dbHelper = DatabaseHelper.instance;

//   // Inserting a category
//   Map<String, dynamic> category = {
//     DatabaseHelper.columnCategoryName: 'Books',
//     DatabaseHelper.columnDescription: 'Books category',
//   };
//   int categoryId = await dbHelper.insertCategory(category);
//   print('Inserted category with ID: $categoryId');
// }

// class Quiz {
//   final int id;
//   final String quizname;
//   final String quizDescription;
//   final String createdAt;
//   final String? updatedAt;

//   Quiz({
//     required this.id,
//     required this.quizname,
//     required this.quizDescription,
//     required this.createdAt,
//     this.updatedAt,
//   });

//   factory Quiz.fromSqfliteDatabase(Map<String,dynamic> map) => Quiz(
//     id: map['id']?.toInt() ?? 0,
//     quizname: map['quizname'] ?? '',
//     quizDescription: map['quizdescription'] ?? '',
//     createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']).toIso8601String(),
//     updatedAt: map['updated_at'] == null ? null : DateTime.fromMillisecondsSinceEpoch(map['updated_at']).toIso8601String(),
//   );
// }


// class Quiz {
//   final int id;
//   final String quizName;
//   final String quiz_description;

//   Quiz({
//     required this.id,
//     required this.quizName,
//     required this.quiz_description,
//   });

//   factory Quiz.fromMap(Map<String, dynamic> map) => Quiz(
//         id: map['id'],
//         quizName: map['quiz_name'],
//         quiz_description: map['quiz_description'],
//       );

//   factory Quiz.fromSqfliteDatabase(Map<String, dynamic> map) => Quiz(
//         id: map['id'],
//         quizName: map['quiz_name'],
//         quiz_description: map['quiz_description'],
//       );

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'quiz_name': quizName,
//       'quiz_description': quiz_description,
//     };
//   }
// }

class Quiz {
  final int id;
  final String quizName;
  final String quiz_description;

  Quiz({
    required this.quizName,
    required this.quiz_description,
    this.id = 0, // Default ID value
  });

  factory Quiz.fromMap(Map<String, dynamic> map) => Quiz(
        id: map['id'],
        quizName: map['quiz_name'],
        quiz_description: map['quiz_description'],
      );

  factory Quiz.fromSqfliteDatabase(Map<String, dynamic> map) => Quiz(
        id: map['id'],
        quizName: map['quiz_name'],
        quiz_description: map['quiz_description'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quiz_name': quizName,
      'quiz_description': quiz_description,
    };
  }
}
