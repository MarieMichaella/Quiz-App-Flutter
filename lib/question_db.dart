// import 'package:sqflite/sqflite.dart';
// import 'package:quizapp/database/database_service.dart';

// class QuestionDB {
//   final tableName = 'questions';
//   Future<void> createTable(Database database) async {
//     await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
//       "id" INTEGER PRIMARY KEY AUTOINCREMENT,
//       "question" TEXT NOT NULL,
//       "result" TEXT NOT NULL,
//       "quiz_id" INTEGER NOT NULL,
//       FOREIGN KEY (quiz_id) REFERENCES quizes(id) ON DELETE CASCADE
//       );""");
//   }

//   Future<int> create({required String question, required String result, required int quizId}) async {
//     final database = await DatabaseService().database;
//     await createTable(database);
//     return await database.insert(
//       tableName,
//       {'question': question, 'result': result, 'quiz_id': quizId},
//     );
//   }

//     Future<List<Question>> fetchAll() async {
//     final database = await DatabaseService().database;
//     final questions = await database.query(tableName);
//     return questions.map((question) => Question.fromMap(question)).toList();
//   }

//   Future<List<Question>> fetchByQuizId(int quizId) async {
//     final database = await DatabaseService().database;
//     final questions = await database.query(tableName, where: 'quiz_id = ?', whereArgs: [quizId]);
//     return questions.map((question) => Question.fromMap(question)).toList();
//   }
//   Future<Question?> fetchById(int id) async {
//     final database = await DatabaseService().database;
//     final questions = await database.query(tableName, where: 'id = ?', whereArgs: [id]);
//     if (questions.isNotEmpty) {
//       return Question.fromMap(questions.first);
//     } else {
//       return null;
//     }
//   }

//   Future<int> update({required int id, String? question, String? result}) async {
//     final database = await DatabaseService().database;
//     return await database.update(
//       tableName,
//       {
//         if (question != null) 'question': question,
//         if (result != null) 'result': result,
//       },
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<int> delete(int id) async {
//     final database = await DatabaseService().database;
//     return await database.delete(tableName, where: 'id = ?', whereArgs: [id]);
//   }
// }

// class Question {
//   final int id;
//   final String question;
//   final String result;

//   Question({required this.id, required this.question, required this.result});

//   factory Question.fromMap(Map<String, dynamic> map) => Question(
//         id: map['id'],
//         question: map['question'],
//         result: map['result'],
//       );
// }

// import 'package:sqflite/sqflite.dart';
// import 'package:quizapp/database/database_service.dart';
// import 'package:quizapp/model/add_questions.dart';

// class QuestionDB {
//   final tableName = 'questions';

// Future<void> createTable(Database database) async {
//   await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
//     "id" TEXT PRIMARY KEY,
//     "quiz_question" TEXT NOT NULL,
//     "quiz_id" TEXT NOT NULL,
//     FOREIGN KEY (quiz_id) REFERENCES quizzes(id)
//   );""");
// }


//   Future<int> create({required String quizQuestion, required int quizId}) async {
//     final database = await DatabaseService().database;
//     await createTable(database);
//     return await database.rawInsert(
//       '''INSERT INTO $tableName (quiz_question, quiz_id) VALUES (?,?)''',
//       [quizQuestion, quizId],
//     );
//   }

//   Future<List<Question>> fetchAll() async {
//     final database = await DatabaseService().database;
//     await createTable(database);
//     final questions = await database.rawQuery('SELECT * FROM $tableName');
//     return questions.map((question) => Question.fromMap(question)).toList();
//   }
// }

import 'package:sqflite/sqflite.dart';
import 'package:quizapp/database/database_service.dart';
import 'package:quizapp/model/syncModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionDB {
  final tableName = 'questions';

Future<void> createTable(Database database) async {
  await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
    "id" TEXT PRIMARY KEY,
    "quiz_question" TEXT NOT NULL,
    "quiz_id" TEXT NOT NULL,
    "sync_status" TEXT DEFAULT NULL,
    FOREIGN KEY (quiz_id) REFERENCES quiz(id) ON DELETE CASCADE
  );""");
}



Future<int> create({required String id, required String quizQuestion, required String quizId, String? syncStatus}) async {
    final database = await DatabaseService().database;
    await createTable(database);
    return await database.rawInsert(
      '''INSERT INTO $tableName (id, quiz_question, quiz_id, sync_status) VALUES (?,?,?,?)''',
      [id, quizQuestion, quizId, syncStatus ?? 'unsynced'],
    );
  }


  Future<List<Question>> fetchAll() async {
    final database = await DatabaseService().database;
    // Assuming the table is already created during app initialization or setup
    final questions = await database.rawQuery('SELECT * FROM $tableName');
    return questions.map((question) => Question.fromMap(question)).toList();
  }

    Future<void> deleteQuestionAndAnswersFromSQLite(String questionId) async {
    final database = await DatabaseService().database;
    await database.transaction((txn) async {
      await txn.delete(tableName, where: 'id = ?', whereArgs: [questionId]);
      await txn.delete('answers', where: 'question_id = ?', whereArgs: [questionId]);
    });
  }




  Future<void> clearSyncStatus() async {
    final database = await DatabaseService().database;
    await database.rawUpdate('UPDATE $tableName SET sync_status = NULL WHERE sync_status = "unsynced"');
  }

  Future<List<Question>> fetchUnsyncedQuestions() async {
    final database = await DatabaseService().database;
    final unsyncedQuestions = await database.rawQuery(
      'SELECT * FROM $tableName WHERE sync_status = "unsynced"',
    );
    return unsyncedQuestions.map((question) => Question.fromMap(question)).toList();
  }

  Future<void> setSyncStatus(String questionId, String syncStatus) async {
  final database = await DatabaseService().database;
  await database.rawUpdate('UPDATE $tableName SET sync_status = ? WHERE id = ?', [syncStatus, questionId]);
}

  Future<void> updateQuestion(Question question) async {
    final database = await DatabaseService().database;
    await database.update(
      tableName,
      {
        'quiz_question': question.quizQuestion,
        'quiz_id': question.quizId,
      },
      where: 'id = ?',
      whereArgs: [question.id],
    );
    await setSyncStatus(question.id, 'unsynced');
  }

    Future<List<Question>> fetchQuestionsByQuizId(String quizId) async {
    final database = await DatabaseService().database;
    final questions = await database.rawQuery('''
      SELECT * FROM $tableName WHERE quiz_id = ?
    ''', [quizId]);
    return questions.map((question) => Question.fromMap(question)).toList();
  }


  Future<String> getQuestionIdByQuizId(String quizId) async {
    final db = await DatabaseService().database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT id FROM questions WHERE quiz_id = ?', [quizId]);

    if (result.isNotEmpty) {
      // Assuming each quiz has only one question, so we return the first question found
      return result[0]['id'].toString();
    } else {
      throw Exception('No question found for the quiz ID: $quizId');
    }
  }

}

// class QuestionFirestore {
//   final CollectionReference _questionsCollection =
//       FirebaseFirestore.instance.collection('quizquestions');

//   Future<void> create({required String id, required String quizQuestion, required String quizId}) async {
//     await _questionsCollection.doc(id).set({
//       'quiz_question': quizQuestion,
//       'quiz_id': quizId, // Reference to the quiz it belongs to
//     });
//   }

//   Future<List<Question>> fetchAll() async {
//     QuerySnapshot querySnapshot = await _questionsCollection.get();
//     List<Question> questions = [];
//     querySnapshot.docs.forEach((doc) {
//       var data = doc.data() as Map<String, dynamic>?; // Cast to nullable map
//       if (data != null) {
//         questions.add(Question.fromFirestore(doc));
//       }
//     });
//     return questions;
//   }

//   Future<void> update({required String id, required String quizQuestion, required String quizId}) async {
//     await _questionsCollection.doc(id).update({
//       'quiz_question': quizQuestion,
//       'quiz_id': quizId, 
//     });
//   }
//     Future<void> deleteQuestionAndAnswersFromFirestore(String questionId) async {
//     await _questionsCollection.doc(questionId).delete();
//     final answersSnapshot =
//         await _questionsCollection.doc(questionId).collection('answers').get();
//     for (final doc in answersSnapshot.docs) {
//       await doc.reference.delete();
//     }
//   }

//     Future<void> updateQuestion({required String id, required String quizQuestion, required String quizId}) async {
//     await _questionsCollection.doc(id).update({
//       'quiz_question': quizQuestion,
//       'quiz_id': quizId,
//     });
//   }
// }


class QuestionFirestore {
  Future<void> createQuestion({
    required String quizId,
    required String id,
    required String quizQuestion,
  }) async {
    DocumentReference questionRef = FirebaseFirestore.instance
        .collection('quiz')
        .doc(quizId)
        .collection('questions')
        .doc(id);
    await questionRef.set({
      'quiz_question': quizQuestion,
    });
  }

  Future<void> updateQuestion({
    required String quizId,
    required String id,
    required String quizQuestion,
  }) async {
    DocumentReference questionRef = FirebaseFirestore.instance
        .collection('quiz')
        .doc(quizId)
        .collection('questions')
        .doc(id);
    await questionRef.update({
      'quiz_question': quizQuestion,
    });
  }

  Future<void> deleteQuestion(String quizId, String id) async {
    DocumentReference questionRef = FirebaseFirestore.instance
        .collection('quiz')
        .doc(quizId)
        .collection('questions')
        .doc(id);
    await questionRef.delete();

    // Delete the answers subcollection
    CollectionReference answersSubcollection = questionRef.collection('answers');
    QuerySnapshot answerDocs = await answersSubcollection.get();
    for (var doc in answerDocs.docs) {
      await doc.reference.delete();
    }
  }
}