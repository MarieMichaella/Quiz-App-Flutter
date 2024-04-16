import 'package:sqflite/sqflite.dart';
import 'package:quizapp/database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/model/syncModel.dart';

class AnswerDB {
  final String tableName = 'answers';
Future<void> createTable(Database database) async {
  await database.execute("""CREATE TABLE IF NOT EXISTS $tableName (
    "id" TEXT PRIMARY KEY,
    "answer_text" TEXT NOT NULL,
    "is_correct" INTEGER NOT NULL,
    "question_id" TEXT NOT NULL,
    "quiz_id" TEXT NOT NULL,
    "sync_status" TEXT,
    FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE,
    FOREIGN KEY (quiz_id) REFERENCES quiz(id) ON DELETE CASCADE
  );""");
}



Future<int> create({
  required String id,
  required String answerText,
  required bool isCorrect,
  required int questionId,
  required String quizId,
}) async {
  final database = await DatabaseService().database;
  await createTable(database);
  return await database.rawInsert(
    '''INSERT INTO $tableName (id, answer_text, is_correct, question_id, quiz_id, sync_status) VALUES (?,?,?,?,?,?)''',
    [id, answerText, isCorrect ? 1 : 0, questionId, quizId, 'unsynced'],
  );
}


  Future<List<Answer>> fetchUnsyncedAnswers() async {
    final database = await DatabaseService().database;
    final unsyncedAnswers = await database.rawQuery(
      'SELECT * FROM $tableName WHERE sync_status = "unsynced"',
    );
    return unsyncedAnswers.map((answer) => Answer.fromMap(answer)).toList();
  }

  Future<void> setSyncStatus(String answerId, String syncStatus) async {
    final database = await DatabaseService().database;
    await database.rawUpdate('UPDATE $tableName SET sync_status = ? WHERE id = ?', [syncStatus, answerId]);
  }

  Future<void> clearSyncStatus() async {
    final database = await DatabaseService().database;
    await database.rawUpdate('UPDATE $tableName SET sync_status = NULL WHERE sync_status = "unsynced"');
  }

  Future<void> delete(String id) async {
    final database = await DatabaseService().database;
    await database.transaction((txn) async {
    await txn.delete(tableName, where: 'id = ?', whereArgs: [id]);
    });
  }


    Future<void> update({
    required String id,
    required String answerText,
    required bool isCorrect,
    required String questionId,
  }) async {
    final database = await DatabaseService().database;
    await database.update(
      tableName,
      {
        'answer_text': answerText,
        'is_correct': isCorrect ? 1 : 0,
        'question_id': questionId,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    await setSyncStatus(id, 'unsynced');
  }

      Future<List<Answer>> fetchAnswersByQuestionId(String questionId) async {
    final database = await DatabaseService().database;
    final answers = await database.rawQuery('''
      SELECT * FROM $tableName WHERE question_id = ?
    ''', [questionId]);
    return answers.map((answers) => Answer.fromMap(answers)).toList();
  }

Future<String> getAnswerIdByQuestionId(String questionId) async {
  final db = await DatabaseService().database;
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT id FROM answers WHERE question_id = ?', [questionId]);

    if (result.isNotEmpty) {
      // Assuming each question has only one answer, so we return the first answer found
      return result[0]['id'].toString();
    } else {
      throw Exception('No answer found for the question ID: $questionId');
    }
  }
}

  



// class AnswerFirestore {
//   final CollectionReference _answerCollection = FirebaseFirestore.instance.collection('Questionanswers');

//   Future<void> create({required String id, required String answerText, required bool isCorrect, required String questionId}) async {
//     await _answerCollection.doc(id).set({
//       'answer_text': answerText,
//       'is_correct': isCorrect,
//       'question_id': questionId,
//     });
//   }

//   Future<List<Answer>> fetchAll() async {
//     QuerySnapshot querySnapshot = await _answerCollection.get();
//     List<Answer> answers = [];
//     querySnapshot.docs.forEach((doc) {
//       var data = doc.data() as Map<String, dynamic>?;
//       if (data != null) {
//         answers.add(Answer.fromMap(data));
//       }
//     });
//     return answers;
//   }

//   Future<void> update({required String id, required String answerText, required bool isCorrect, required String questionId}) async {
//     await _answerCollection.doc(id).update({
//       'answer_text': answerText,
//       'is_correct': isCorrect,
//       'question_id': questionId,
//     });
//   }

//     Future<void> delete(String id) async {
//     await _answerCollection.doc(id).delete();
//   }
// }


class AnswerFirestore {
  Future<void> createAnswer({
    required String quizId,
    required String questionId,
    required String id,
    required String answerText,
    required bool isCorrect,
  }) async {
    DocumentReference answerRef = FirebaseFirestore.instance
        .collection('quiz')
        .doc(quizId)
        .collection('questions')
        .doc(questionId)
        .collection('answers')
        .doc(id);
    await answerRef.set({
      'answer_text': answerText,
      'is_correct': isCorrect,
    });
  }

  Future<void> updateAnswer({
    required String quizId,
    required String questionId,
    required String id,
    required String answerText,
    required bool isCorrect,
  }) async {
    DocumentReference answerRef = FirebaseFirestore.instance
        .collection('quiz')
        .doc(quizId)
        .collection('questions')
        .doc(questionId)
        .collection('answers')
        .doc(id);
    await answerRef.update({
      'answer_text': answerText,
      'is_correct': isCorrect,
    });
  }

  Future<void> deleteAnswer(String quizId, String questionId, String id) async {
    DocumentReference answerRef = FirebaseFirestore.instance
        .collection('quiz')
        .doc(quizId)
        .collection('questions')
        .doc(questionId)
        .collection('answers')
        .doc(id);
    await answerRef.delete();
  }
}