// // import 'package:sqflite/sqflite.dart';
// // import 'package:quizapp/database/database_service.dart';
// // import 'package:quizapp/model/add_category.dart';

// // class QuizDB {
// //   final tableName = 'todos';

// //   Future<void> createTable(Database database) async {
// //     await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
// //       "id" INTEGER NOT NULL,
// //       "quizname" TEXT NOT NULL,
// //       "quizdescription" TEXT NOT NULL,
// //       "created_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
// //       "updated_at" INTEGER,
// //       PRIMARY KEY ("id" AUTOINCREMENT)
// //       );""");
// //   }

// //   Future<int> create({required String quizname}) async {
// //     final database = await DatabaseService().database;
// //     return await database.rawInsert(
// //       '''INSERT INTO $tableName (quizname, quizdescription, created_at) VALUES (?,?)''',
// //       [quizname, DateTime.now().millisecondsSinceEpoch],
// //     );
// //   }

// //   Future<List<Quiz>> fetchAll() async {
// //     final database = await DatabaseService().database;
// //     final quizzes = await database.rawQuery(
// //       '''SELECT * FROM $tableName ORDER BY COALESCE(updated_at, created_at)''',
// //     );
// //     return quizzes.map((quiz) => Quiz.fromSqfliteDatabase(quiz)).toList();
// //   }

// //   Future<Quiz> fetchById(int id) async {
// //     final database = await DatabaseService().database;
// //     final quiz = await database.rawQuery('''SELECT * FROM $tableName WHERE id = ?''', [id]);
// //     return Quiz.fromSqfliteDatabase(quiz.first);
// //   }

// //   Future<int> update({required int id, String? quizname}) async {
// //     final database = await DatabaseService().database;
// //     return await database.update(
// //       tableName, 
// //       {
// //         if(quizname != null) 'quizname' : quizname,
// //         'update_at': DateTime.now().millisecondsSinceEpoch,
// //       },
// //       where: 'id = ?',
// //       conflictAlgorithm: ConflictAlgorithm.rollback,
// //       whereArgs: [id],
// //     );
// //   }
// // }

// // import 'package:sqflite/sqflite.dart';
// // import 'package:quizapp/database/database_service.dart';
// // import 'package:quizapp/model/add_category.dart';

// // class QuizDB {
// //   final tableName = 'quizes';

// //   Future<void> createTable(Database database) async {
// //     await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
// //       "id" INTEGER NOT NULL,
// //       "quizname" TEXT NOT NULL,
// //       "quizdescription" TEXT NOT NULL,
// //       "created_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
// //       "updated_at" INTEGER,
// //       PRIMARY KEY ("id" AUTOINCREMENT)
// //       );""");
// //   }

// //   Future<int> create({required String quizname, required String quizdescription}) async {
// //     final database = await DatabaseService().database;
// //     return await database.rawInsert(
// //       '''INSERT INTO $tableName (quizname, quizdescription, created_at) VALUES (?,?,?)''',
// //       [quizname, quizdescription, DateTime.now().millisecondsSinceEpoch],
// //     );
// //   }

// //   Future<List<Quiz>> fetchAll() async {
// //     final database = await DatabaseService().database;
// //     final quizzes = await database.rawQuery(
// //       '''SELECT * FROM $tableName ORDER BY COALESCE(updated_at, created_at)''',
// //     );
// //     return quizzes.map((quiz) => Quiz.fromSqfliteDatabase(quiz)).toList();
// //   }

// //   Future<Quiz> fetchById(int id) async {
// //     final database = await DatabaseService().database;
// //     final quiz = await database.rawQuery('''SELECT * FROM $tableName WHERE id = ?''', [id]);
// //     return Quiz.fromSqfliteDatabase(quiz.first);
// //   }

// //   Future<int> update({required int id, String? quizname}) async {
// //     final database = await DatabaseService().database;
// //     return await database.update(
// //       tableName, 
// //       {
// //         if(quizname != null) 'quizname' : quizname,
// //         'updated_at': DateTime.now().millisecondsSinceEpoch,
// //       },
// //       where: 'id = ?',
// //       conflictAlgorithm: ConflictAlgorithm.rollback,
// //       whereArgs: [id],
// //     );
// //   }

// //   Future<void> delete(int id) async {
// //     final database = await DatabaseService().database;
// //     await database.rawDelete('''DELETE FROM $tableName WHERE $id = ?''', [id]);
// //   }}



// import 'package:sqflite/sqflite.dart';
// import 'package:quizapp/database/database_service.dart';
// import 'package:quizapp/model/syncModel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class QuizDB {
//   final tableName = 'quiz';

//   Future<void> createTable(Database database) async {
//     await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
//       "id" TEXT PRIMARY KEY,
//       "quiz_name" TEXT NOT NULL,
//       "quiz_description" TEXT NOT NULL
//       );""");
//   }

//     Future<int> create({required String id, required String quizname, required String quizdescription}) async {
//     final database = await DatabaseService().database;
//     await createTable(database);
//     return await database.rawInsert(
//       '''INSERT INTO $tableName (id, quiz_name, quiz_description) VALUES (?,?,?)''',
//       [id, quizname, quizdescription],
//     );
//   }


// //   Future<int> create({required String quizname, required String quizdescription}) async {
// //   final database = await DatabaseService().database;
// //   await createTable(database);
// //   return await database.rawInsert(
// //     '''INSERT INTO $tableName (quiz_name, quiz_description) VALUES (?,?)''',
// //     [quizname, quizdescription],
// //   );
// // }


// Future<List<Quiz>> fetchAll() async {
//   final database = await DatabaseService().database;
//   final quizzes = await database.rawQuery(
//     'SELECT * FROM $tableName',
//   );
//   return quizzes.map((quiz) => Quiz.fromSqfliteDatabase(quiz)).toList();
// }
//   Future<void> deleteQuizAndRelatedData(String quizId) async {
//     final database = await DatabaseService().database;
//     await database.transaction((txn) async {
//       // Delete questions related to the quiz
//       await txn.delete('questions', where: 'quiz_id = ?', whereArgs: [quizId]);
//       // Delete answers related to the questions
//       await txn.delete('answers', where: 'question_id IN (SELECT id FROM questions WHERE quiz_id = ?)', whereArgs: [quizId]);
//       // Delete the quiz itself
//       await txn.delete(tableName, where: 'id = ?', whereArgs: [quizId]);
//     });
//   }


//   }


// class QuizFirestore {
//   final CollectionReference _quizCollection =
//       FirebaseFirestore.instance.collection('quizdef');

//   Future<void> create({required String id, required String quizname, required String quizdescription}) async {
//     await _quizCollection.doc(id).set({
//       'quiz_name': quizname,
//       'quiz_description': quizdescription,
//     });
//   }

// Future<List<Quiz>> fetchAll() async {
//   QuerySnapshot querySnapshot = await _quizCollection.get();
//   List<Quiz> quizzes = [];
//   querySnapshot.docs.forEach((doc) {
//     var data = doc.data() as Map<String, dynamic>?; // Cast to nullable map
//     if (data != null) {
//       quizzes.add(Quiz.fromMap(data));
//     }
//   });
//   return quizzes;
// }


// }


import 'package:sqflite/sqflite.dart';
import 'package:quizapp/database/database_service.dart';
import 'package:quizapp/model/syncModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizDB {
  final tableName = 'quiz';

  // Future<void> createTable(Database database) async {
  //   await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
  //     "id" TEXT PRIMARY KEY,
  //     "quiz_name" TEXT NOT NULL,
  //     "quiz_description" TEXT NOT NULL
  //   );""");
  // }

    Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" TEXT PRIMARY KEY,
      "quiz_name" TEXT NOT NULL,
      "quiz_description" TEXT NOT NULL,
      "sync_status" TEXT DEFAULT NULL,
      "minutes_to_complete" INTEGER NOT NULL
    );""");
  }

  // Future<int> create({required String id, required String quizname, required String quizdescription}) async {
  //   final database = await DatabaseService().database;
  //   await createTable(database);
  //   return await database.rawInsert(
  //     '''INSERT INTO $tableName (id, quiz_name, quiz_description) VALUES (?,?,?)''',
  //     [id, quizname, quizdescription],
  //   );
  // }

Future<int> create({required String id, required String quizname, required String quizdescription, required int minutesToComplete, String? syncStatus}) async {
  final database = await DatabaseService().database;
  await createTable(database);
  return await database.rawInsert(
    '''INSERT INTO $tableName (id, quiz_name, quiz_description, minutes_to_complete, sync_status) VALUES (?,?,?,?,?)''',
    [id, quizname, quizdescription, minutesToComplete, syncStatus ?? 'unsynced'],
  );
}



  Future<List<Quiz>> fetchAll() async {
    final database = await DatabaseService().database;
    final quizzes = await database.rawQuery(
      'SELECT * FROM $tableName',
    );
    return quizzes.map((quiz) => Quiz.fromSqfliteDatabase(quiz)).toList();
  }

  // Future<void> deleteQuizAndRelatedData(String quizId) async {
  //   final database = await DatabaseService().database;
  //   await database.transaction((txn) async {
  //     await txn.delete('questions', where: 'quiz_id = ?', whereArgs: [quizId]);
  //     await txn.delete('answers', where: 'question_id IN (SELECT id FROM questions WHERE quiz_id = ?)', whereArgs: [quizId]);
  //     await txn.delete(tableName, where: 'id = ?', whereArgs: [quizId]);
      
  //   });
  // }
Future<void> deleteQuizAndRelatedData(String quizId) async {
  final database = await DatabaseService().database;
  await database.transaction((txn) async {

    await txn.delete('answers', where: 'quiz_id = ?', whereArgs: [quizId]);
    await txn.delete('questions', where: 'quiz_id = ?', whereArgs: [quizId]);
    await txn.delete(tableName, where: 'id = ?', whereArgs: [quizId]);
  });
}




    Future<void> clearSyncStatus() async {
    final database = await DatabaseService().database;
    await database.rawUpdate('UPDATE quiz SET sync_status = NULL WHERE sync_status = "unsynced"');
  }

  Future<List<Quiz>> fetchUnsyncedQuizzes() async {
    final database = await DatabaseService().database;
    final unsyncedQuizzes = await database.rawQuery(
      'SELECT * FROM $tableName WHERE sync_status = "unsynced"',
    );
    return unsyncedQuizzes.map((quiz) => Quiz.fromSqfliteDatabase(quiz)).toList();
  }

  Future<void> setSyncStatus(String quizId, String syncStatus) async {
  final database = await DatabaseService().database;
  await database.rawUpdate('UPDATE $tableName SET sync_status = ? WHERE id = ?', [syncStatus, quizId]);
}

Future<void> updateQuiz({required String id, required String quizname, required String quizdescription}) async {
  final database = await DatabaseService().database;
  await database.update(
    tableName,
    {
      'quiz_name': quizname,
      'quiz_description': quizdescription,
    },
    where: 'id = ?',
    whereArgs: [id],
  );
  await setSyncStatus(id, 'unsynced');
}

  
}

// class QuizFirestore {
//   final CollectionReference _quizCollection =
//       FirebaseFirestore.instance.collection('quizdef');

//       final CollectionReference _questionsCollection =
//     FirebaseFirestore.instance.collection('quizquestions');


//           final CollectionReference _answersCollection =
//     FirebaseFirestore.instance.collection('Questionanswers');


//   Future<void> create({required String id, required String quizname, required String quizdescription, required int minutesToComplete}) async {
//     await _quizCollection.doc(id).set({
//       'quiz_name': quizname,
//       'quiz_description': quizdescription,
//       'minutes_to_complete' : minutesToComplete,
//     });
//   }

//   Future<List<Quiz>> fetchAll() async {
//     QuerySnapshot querySnapshot = await _quizCollection.get();
//     List<Quiz> quizzes = [];
//     querySnapshot.docs.forEach((doc) {
//       var data = doc.data() as Map<String, dynamic>?;
//       if (data != null) {
//         quizzes.add(Quiz.fromMap(data));
//       }
//     });
//     return quizzes;
//   }

//   Future<void> deleteQuizAndRelatedData(String quizId) async {
//     await _quizCollection.doc(quizId).delete();
//     final relatedQuestions = await _questionsCollection.where('quiz_id', isEqualTo: quizId).get();
//     for (final questionDoc in relatedQuestions.docs) {
//       final questionId = questionDoc.id;
//       final relatedAnswers = await _answersCollection.where('question_id', isEqualTo: questionId).get();
//       for (final answerDoc in relatedAnswers.docs) {
//         await answerDoc.reference.delete();
//       }
//       await questionDoc.reference.delete();
//     }
//   }
// Future<void> updateQuiz({
//   required String id,
//   required String quizname,
//   required String quizdescription,
//   required int minutesToComplete, // Changed from String to int
// }) async {
//   await _quizCollection.doc(id).update({
//     'quiz_name': quizname,
//     'quiz_description': quizdescription,
//     'minutes_to_complete': minutesToComplete,
//   });
// }

 
// }


class QuizFirestore {
  final CollectionReference _quizCollection =
      FirebaseFirestore.instance.collection('quiz');

  Future<void> createQuiz({
    required String id,
    required String quizname,
    required String quizdescription,
    required int minutesToComplete,
  }) async {
    // Create the quiz document
    DocumentReference quizRef = _quizCollection.doc(id);
    await quizRef.set({
      'quiz_name': quizname,
      'quiz_description': quizdescription,
      'minutes_to_complete': minutesToComplete,
    });

    // Create the questions subcollection under the quiz
    CollectionReference questionsSubcollection = quizRef.collection('questions');
    // You can add questions here if needed
  }

  Future<void> updateQuiz({
    required String id,
    required String quizname,
    required String quizdescription,
    required int minutesToComplete,
  }) async {
    // Update the quiz document
    DocumentReference quizRef = _quizCollection.doc(id);
    await quizRef.update({
      'quiz_name': quizname,
      'quiz_description': quizdescription,
      'minutes_to_complete': minutesToComplete,
    });
  }

Future<void> deleteQuiz(String quizId) async {
  DocumentReference quizRef = _quizCollection.doc(quizId);
  await quizRef.delete();

  // Delete the questions subcollection
  CollectionReference questionsSubcollection = quizRef.collection('questions');
  QuerySnapshot questionDocs = await questionsSubcollection.get();
  for (var doc in questionDocs.docs) {
    // Delete the answers subcollection for each question
    CollectionReference answersSubcollection = doc.reference.collection('answers');
    QuerySnapshot answerDocs = await answersSubcollection.get();
    for (var answerDoc in answerDocs.docs) {
      await answerDoc.reference.delete();
    }

    await doc.reference.delete();
  }
}

  Future<List<Quiz>> getAllQuizzesFromFirestore() async {
    List<Quiz> quizzes = [];

    try {
      QuerySnapshot querySnapshot = await _quizCollection.get();
      querySnapshot.docs.forEach((doc) {
        Quiz quiz = Quiz(
          id: doc.id,
          quizName: doc['quiz_name'],
          quiz_description: doc['quiz_description'],
          minutesToComplete: doc['minutes_to_complete'],
        );
        quizzes.add(quiz);
      });
    } catch (e) {
      print('Error fetching quizzes: $e');
    }

    return quizzes;
  }


}



  // Future<void> deleteQuiz(String quizId) async {
  //   DocumentReference quizRef = _quizCollection.doc(quizId);
  //   await quizRef.delete();

  //   // Delete the questions subcollection
  //   CollectionReference questionsSubcollection = quizRef.collection('questions');
  //   QuerySnapshot questionDocs = await questionsSubcollection.get();
  //   for (var doc in questionDocs.docs) {
  //     await doc.reference.delete();
  //   }
  // }