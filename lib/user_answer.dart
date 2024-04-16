import 'package:sqflite/sqflite.dart';
import 'package:quizapp/database/database_service.dart';
import 'package:quizapp/model/userAnswer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserAnswerDB {
  final String tableName = 'user_answers';

  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
      "id" TEXT PRIMARY KEY,
      "user_email" TEXT NOT NULL,
      "quiz_id" TEXT NOT NULL,
      "question_id" TEXT NOT NULL,
      "answer_id" TEXT NOT NULL,
      "is_correct" INTEGER NOT NULL,
      "sync_status" TEXT DEFAULT NULL
    );""");
  }

  Future<int> createUserAnswer({
    required String id,
    required String user_email,
    required String quizId,
    required String questionId,
    required String answerId,
    required bool isCorrect,
    String? syncStatus,
  }) async {
    final database = await DatabaseService().database;
    await createTable(database);
    return await database.rawInsert(
      '''INSERT INTO $tableName (id,  user_email, quiz_id, question_id, answer_id, is_correct, sync_status) VALUES (?,?,?,?,?,?,?)''',
      [id, user_email, quizId, questionId, answerId, isCorrect ? 1 : 0, syncStatus ?? 'unsynced'],
    );
  }

  Future<void> clearSyncStatus() async {
    final database = await DatabaseService().database;
    await database.rawUpdate('UPDATE $tableName SET sync_status = NULL WHERE sync_status = "unsynced"');
  }

  Future<List<UserAnswer>> fetchUnsyncedUserAnswer() async {
    final database = await DatabaseService().database;
    final unsyncedAnswers = await database.rawQuery(
      'SELECT * FROM $tableName WHERE sync_status = "unsynced"',
    );
    return unsyncedAnswers.map((answer) => UserAnswer.fromSqfliteDatabase(answer)).toList();
  }

  Future<void> setSyncStatus(String id, String syncStatus) async {
    final database = await DatabaseService().database;
    await database.rawUpdate('UPDATE $tableName SET sync_status = ? WHERE id = ?', [syncStatus, id]);
  }

  //   Future<bool> isQuizDone(String userEmail, String quizId) async {
  //   final database = await DatabaseService().database;
  //   final result = await database.rawQuery(
  //     'SELECT COUNT(*) AS count FROM $tableName WHERE user_email = ? AND quiz_id = ?',
  //     [userEmail, quizId],
  //   );
  //   return Sqflite.firstIntValue(result) == 1; 
  // }

      Future<bool> isQuizDone(String userEmail, String quizId) async {
    final database = await DatabaseService().database;

    final result = await database.rawQuery(
      'SELECT COUNT(*) AS count FROM $tableName WHERE user_email = ? AND quiz_id = ?',
      [userEmail, quizId],
    );

    final answerCount = Sqflite.firstIntValue(result) ?? 0;
    return answerCount > 0;
  }
}


class UserAnswerFirestore {
  final CollectionReference _userAnswerCollection = FirebaseFirestore.instance.collection('user_answers');

  Future<void> createUserAnswer({required String id, required String user_email, required String quizId, required String questionId, required String answerId, required bool isCorrect}) async {
    await _userAnswerCollection.doc(id).set({
      'user_email': user_email,
      'quiz_id': quizId,
      'question_id': questionId,
      'answer_id': answerId,
      'is_correct': isCorrect,
    });
  }

  Future<List<UserAnswer>> getAllUserAnswersFromFirestore() async {
    QuerySnapshot querySnapshot = await _userAnswerCollection.get();
    List<UserAnswer> userAnswers = [];
    querySnapshot.docs.forEach((doc) {
      var data = doc.data() as Map<String, dynamic>?; // Cast to nullable map
      if (data != null) {
        userAnswers.add(UserAnswer.fromMap(data));
      }
    });
    return userAnswers;
  }


  
}
