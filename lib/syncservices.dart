// 


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizapp/database/database_service.dart';
import 'package:quizapp/deletedItem.dart';
import 'package:quizapp/model/syncModel.dart';
import 'package:quizapp/quiz_db.dart';
import 'package:quizapp/question_db.dart';
import 'package:quizapp/answers_db.dart';
import 'package:quizapp/user_answer.dart';
import 'package:quizapp/model/userAnswer.dart';
import 'package:sqflite/sqflite.dart';


class SyncService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DatabaseService _databaseService = DatabaseService();
  final QuizFirestore _quizFirestore = QuizFirestore();
  final QuestionFirestore _questionFirestore = QuestionFirestore();
  final AnswerFirestore _answerFirestore = AnswerFirestore();
  final UserAnswerDB _answerDB = UserAnswerDB();
    final UserAnswerDB _userAnswerDB = UserAnswerDB();
  final UserAnswerFirestore _userAnswerFirestore = UserAnswerFirestore();
    final QuizDB _quizDB = QuizDB();
    final QuestionDB _questionDB = QuestionDB();
    final AnswerDB _answersDB = AnswerDB();
    final DeletedItemsDB _deletedItemsDB = DeletedItemsDB();
  final QuizFirestore  _quizCollection = QuizFirestore();
  late Database _database;

  // SQLite methods for Answer
  Future<void> saveAnswerToSQLite(Answer answer) async {
    final database = await _databaseService.database;
    await database.insert('answers', answer.toMap());
  }

Future<List<Answer>> getAllAnswersFromSQLite() async {
  final database = await _databaseService.database;
  final List<Map<String, dynamic>> maps = await database.query('answers');
  return List.generate(maps.length, (i) {
    return Answer(
      id: maps[i]['id'],
      answerText: maps[i]['answer_text'],
      isCorrect: maps[i]['is_correct'] == 1,
      questionId: maps[i]['question_id'],
      quizId: maps[i]['quiz_id'], // Add quizId here
    );
  });
}


  // SQLite methods for Question
  Future<String> saveQuestionToSQLite(Question question) async {
    final database = await _databaseService.database;
    await database.insert('questions', question.toMap());
  return question.id; 
  }

  Future<List<Question>> getAllQuestionsFromSQLite() async {
    final database = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await database.query('questions');
    return List.generate(maps.length, (i) {
      return Question(
        id: maps[i]['id'],
        quizQuestion: maps[i]['quiz_question'],
        quizId: maps[i]['quiz_id'],
      );
    });
  }

  // Future<void> saveQuizToSQLite(Quiz quiz) async {
  //   final database = await _databaseService.database;
  //   await database.insert('quiz', quiz.toMap());
  // }

//   Future<int> saveQuizToSQLite(Quiz quiz) async {
//   final database = await _databaseService.database;
//   return await database.insert('quiz', quiz.toMap());
// }

Future<String> saveQuizToSQLite(Quiz quiz) async {
  final database = await _databaseService.database;
  await database.insert('quiz', quiz.toMap());
  return quiz.id; 
}



  Future<List<Quiz>> getAllQuizzesFromSQLite() async {
    final database = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await database.query('quiz');
    return List.generate(maps.length, (i) {
      return Quiz(
        id: maps[i]['id'],
        quizName: maps[i]['quiz_name'],
        quiz_description: maps[i]['quiz_description'],
        minutesToComplete: maps[i]['minutes_to_complete'],
      );
    });
  }

  // // Firestore methods for Answer
  // Future<void> saveAnswerToFirestore(Answer answer) async {
  //   await _firestore.collection('answers').add(answer.toMap());
  // }


    Future<void> saveAnswerToFirestore(Answer answer) async {
    await _answerFirestore.createAnswer(
      id: answer.id,
      answerText: answer.answerText,
      isCorrect: answer.isCorrect,
      questionId: answer.questionId,
      quizId: answer.quizId,
    );
  }

  Future<List<Answer>> getAllAnswersFromFirestore() async {
    final querySnapshot = await _firestore.collection('answers').get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Answer(
        id: doc.id,
        answerText: data['answer_text'],
        isCorrect: data['is_correct'],
        questionId: data['question_id'],
        quizId: data['quiz_id'],
      );
    }).toList();
  }

  // // Firestore methods for Question
  // Future<void> saveQuestionToFirestore(Question question) async {
  //   await _firestore.collection('questions').add(question.toMap());
  // }

Future<List<Question>> getAllQuestionsFromFirestore() async {
  final querySnapshot = await _firestore.collection('questions').get();
  return querySnapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    // Ensure that quizId is converted to String if it's stored as an int in Firestore
    String quizId = data['quiz_id'].toString();
    return Question(
      id: doc.id,
      quizQuestion: data['quiz_question'],
      quizId: quizId, // Use the converted quizId
    );
  }).toList();
}
Future<List<Question>> getAllQuestionsFromFirestoreForQuiz(String quizId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('questions')
          .where('quiz_id', isEqualTo: quizId)
          .get();
      
      List<Question> questions = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Question(
          id: doc.id,
          quizQuestion: data['quiz_question'],
          quizId: data['quiz_id'],
        );
      }).toList();

      return questions;
    } catch (e) {
      print('Error fetching questions from Firestore: $e');
      return [];
    }
  }





// Future<List<Question>> getAllQuestionsFromSQLiteForQuiz(String quizId) async {
//   final database = await _databaseService.database;
//   final List<Map<String, dynamic>> maps = await database.rawQuery('''
//     SELECT * FROM questions WHERE quiz_id = ?
//   ''', [quizId ?? 2]); // Use the null-aware operator ?? and provide a default value (e.g., 0)
//   return List.generate(maps.length, (i) {
//     return Question(
//       id: maps[i]['id'],
//       quizQuestion: maps[i]['quiz_question'],
//       quizId: maps[i]['quiz_id'],
//     );
//   });
// }


// Future<List<Question>> getAllQuestionsFromSQLiteForQuiz(int? quizId) async {
//   if (quizId == null) {
//     // Handle the case where quizId is null (e.g., throw an error or return an empty list)
//     return [];
//   }

//   final database = await _databaseService.database;
//   final List<Map<String, dynamic>> maps = await database.rawQuery('''
//     SELECT * FROM questions WHERE quiz_id = ?
//   ''', [quizId]);
//   return List.generate(maps.length, (i) {
//     return Question(
//       id: maps[i]['id'],
//       quizQuestion: maps[i]['quiz_question'],
//       quizId: maps[i]['quiz_id'],
//     );
//   });
// }


  // Future<List<Question>> getAllQuestionsFromSQLiteForQuiz(Quiz quiz) async {
  //   // Get a reference to your database
  //   final database = await DatabaseService().database;

  //   // Perform a query to fetch questions based on the quiz name or ID
  //   final List<Map<String, dynamic>> questionMaps = await database.query(
  //     'questions',
  //     where: 'quiz_name = ?', // Replace 'quiz_name' with the actual column name in your questions table
  //     whereArgs: [quiz.quizName], // Use quizName or another unique identifier from the Quiz object
  //   );

  //   // Convert the query result to a list of Question objects
  //   List<Question> questions = questionMaps.map((map) => Question.fromMap(map)).toList();

  //   return questions;
  // }


// Future<List<Answer>> getAllAnswersForQuestion(int questionId) async {
//   final database = await _databaseService.database;
//   final List<Map<String, dynamic>> maps = await database.query('answers', where: 'question_id = ?', whereArgs: [questionId]);
//   return List.generate(maps.length, (i) {
//     return Answer(
//       id: maps[i]['id'],
//       answerText: maps[i]['answer_text'],
//       isCorrect: maps[i]['is_correct'] == 1 ? true : false,
//       questionId: maps[i]['question_id'],
//     );
//   });
// }


// Future<List<Answer>> getAllAnswersForQuestion(Question question) async {
//   final database = await _databaseService.database;
//   final List<Map<String, dynamic>> maps = await database.query(
//     'answers',
//     where: 'question_id = ?',
//     whereArgs: [question.quizQuestion],
//   );
//   return List.generate(maps.length, (i) {
//     return Answer(
//       id: maps[i]['id'],
//       answerText: maps[i]['answer_text'],
//       isCorrect: maps[i]['is_correct'] == 1 ? true : false,
//       questionId: maps[i]['question_id'],
//     );
//   });
// }

// Future<List<Answer>> getAllAnswersForQuestion(Question question) async {
//   final database = await _databaseService.database;
//   final List<Map<String, dynamic>> maps = await database.query(
//     'answers',
//     where: 'question_id = ?',
//     whereArgs: [question.id],
//   );
//   return List.generate(maps.length, (i) {
//     return Answer(
//       id: maps[i]['id'],
//       answerText: maps[i]['answer_text'],
//       isCorrect: maps[i]['is_correct'] == 1 ? true : false,
//       questionId: maps[i]['question_id'],
//     );
//   });
// }


Future<List<Answer>> getAllAnswersForQuestion(String questionId) async {
  final database = await _databaseService.database;
  final List<Map<String, dynamic>> maps = await database.rawQuery('''
    SELECT * FROM answers WHERE question_id = ?
    ''',[questionId]);

  return List.generate(maps.length, (i) {
    return Answer(
      id: maps[i]['id'],
      answerText: maps[i]['answer_text'],
      isCorrect: maps[i]['is_correct'] == 1 ? true : false,
      questionId: maps[i]['question_id'],
      quizId: maps[i]['quiz_id'],
    );
  });
}

Future<List<Question>> getAllQuestionsFromSQLiteForQuiz(String quizId) async {
  final database = await _databaseService.database;
  final List<Map<String, dynamic>> maps = await database.rawQuery('''
    SELECT * FROM questions WHERE quiz_id = ?
  ''', [quizId]);
  return List.generate(maps.length, (i) {
    return Question(
      id: maps[i]['id'],
      quizQuestion: maps[i]['quiz_question'],
      quizId: maps[i]['quiz_id'],
    );
  });
}


  // Future<void> saveQuizToFirestore(Quiz quiz) async {
  //   await _firestore.collection('quiztry').add(quiz.toMap());
  // }



  Future<void> saveQuizToFirestore(Quiz quiz) async {
  await _quizFirestore.createQuiz(
    id: quiz.id,
    quizname: quiz.quizName,
    quizdescription: quiz.quiz_description,
    minutesToComplete: quiz.minutesToComplete,
  );
}



Future<void> saveQuestionToFirestore(Question question) async {
  await _questionFirestore.createQuestion(
    id: question.id,
    quizQuestion: question.quizQuestion,
    quizId: question.quizId,
  );
}



  Future<List<Quiz>> getAllQuizzesFromFirestore() async {
    final querySnapshot = await _firestore.collection('quiztry').get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Quiz(
        id: doc.id,
        quizName: data['quiz_name'],
        quiz_description: data['quiz_description'],
        minutesToComplete: data['minutes_to_complete']
      );
    }).toList();
  }


  //   Future<void> saveUserAnswer(UserAnswer userAnswer) async {
  //   // Save user answer to SQLite
  //   await _userAnswerDB.createUserAnswer(
  //     id: userAnswer.id,
  //     user_email: userAnswer.user_email,
  //     quizId: userAnswer.quizId,
  //     questionId: userAnswer.questionId,
  //     answerId: userAnswer.answerId,
  //     isCorrect: userAnswer.isCorrect,
  //   );


  
  //   await _userAnswerFirestore.createUserAnswer(
  //     id: userAnswer.id,
  //     user_email: userAnswer.user_email,
  //     quizId: userAnswer.quizId,
  //     questionId: userAnswer.questionId,
  //     answerId: userAnswer.answerId,
  //     isCorrect: userAnswer.isCorrect,
  //   );
  // }



  Future<void> saveUserAnswerToSQLite(UserAnswer userAnswer) async {
  // Save user answer to SQLite
  await _userAnswerDB.createUserAnswer(
    id: userAnswer.id,
    user_email: userAnswer.user_email,
    quizId: userAnswer.quizId,
    questionId: userAnswer.questionId,
    answerId: userAnswer.answerId,
    isCorrect: userAnswer.isCorrect,
  );
}

Future<void> saveUserAnswerToFirestore(UserAnswer userAnswer) async {
  // Save user answer to Firestore
  await _userAnswerFirestore.createUserAnswer(
    id: userAnswer.id,
    user_email: userAnswer.user_email,
    quizId: userAnswer.quizId,
    questionId: userAnswer.questionId,
    answerId: userAnswer.answerId,
    isCorrect: userAnswer.isCorrect,
  );
}


    Future<List<UserAnswer>> getUserAnswersByEmail(String userEmail) async {
  final database = await DatabaseService().database;
  final List<Map<String, dynamic>> maps = await database.rawQuery('''
    SELECT * FROM user_answers WHERE user_email = ?
  ''',[userEmail]);

  return List.generate(maps.length, (i) {
    return UserAnswer(
      id: maps[i]['id'],
      user_email: maps[i]['user_email'],
      quizId: maps[i]['quiz_id'],
      questionId: maps[i]['question_id'],
      answerId: maps[i]['answer_id'],
      isCorrect: maps[i]['is_correct'] == 1 ? true : false,
    );
  });
}
Future<List<UserAnswer>> getUserAnswersByEmailFirestore(String userEmail) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('user_answers')
      .where('user_email', isEqualTo: userEmail)
      .get();

  List<UserAnswer> userAnswers = [];
  querySnapshot.docs.forEach((doc) {
    var data = doc.data() as Map<String, dynamic>?;
    if (data != null) {
      userAnswers.add(UserAnswer.fromMap(data));
    }
  });
  return userAnswers;
}


  // Future<List<UserAnswer>> getUserAnswersByEmailFirestore(String userEmail) async {
  //   QuerySnapshot querySnapshot = await _userAnswerFirestore.where('user_email', isEqualTo: userEmail).get();
  //   List<UserAnswer> userAnswers = [];
  //   querySnapshot.docs.forEach((doc) {
  //     var data = doc.data() as Map<String, dynamic>?;
  //     if (data != null) {
  //       userAnswers.add(UserAnswer.fromMap(data));
  //     }
  //   });
  //   return userAnswers;
  // }



  Future<String?> getQuizNameById(String quizId) async {
    final database = await _databaseService.database;
    final List<Map<String, dynamic>> result = await database.rawQuery(
      'SELECT quiz_name FROM quiz WHERE id = ?',
      [quizId],
    );
    if (result.isNotEmpty) {
      return result.first['quiz_name'] as String?;
    }
    return null;
  }

  Future<String?> getQuestionTextById(String questionId) async {
    final database = await _databaseService.database;
    final List<Map<String, dynamic>> result = await database.rawQuery(
      'SELECT quiz_question FROM questions WHERE id = ?',
      [questionId],
    );
    if (result.isNotEmpty) {
      return result.first['quiz_question'] as String?;
    }
    return null;
  }

  Future<String?> getAnswerTextById(String answerId) async {
    final database = await _databaseService.database;
    final List<Map<String, dynamic>> result = await database.rawQuery(
      'SELECT answer_text FROM answers WHERE id = ?',
      [answerId],
    );
    if (result.isNotEmpty) {
      return result.first['answer_text'] as String?;
    }
    return null;
  }

  Future<List<UserAnswer>> getUserAnswerByEmail(String userEmail) async {
    final database = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await database.rawQuery(
      'SELECT * FROM user_answers WHERE user_email = ?',
      [userEmail],
    );

    return List.generate(maps.length, (i) {
      return UserAnswer(
        id: maps[i]['id'],
        user_email: maps[i]['user_email'],
        quizId: maps[i]['quiz_id'],
        questionId: maps[i]['question_id'],
        answerId: maps[i]['answer_id'],
        isCorrect: maps[i]['is_correct'] == 1 ? true : false,
      );
    });
  }

  Future<void> deleteAnswerFromSQLite(String answerId) async {
    await _answersDB.delete(answerId);
  }

  Future<void> deleteQuestionFromSQLite(String questionId) async {
  await _questionDB.deleteQuestionAndAnswersFromSQLite(questionId);
}

Future<void> deleteQuizFromSQLite(String quizId) async {
  await _quizDB.deleteQuizAndRelatedData(quizId);
}

Future<void> deleteAnswerFromFirestore(String quizId, String questionId, String id) async {
  await _answerFirestore.deleteAnswer(quizId, questionId, id);
}

Future<void> deleteQuestionFromFirestore(String id, String quizId) async {
  await _questionFirestore.deleteQuestion(id, quizId);
}


// Future<void> deleteQuestionAndAnswersFromSQLite(String quizId, String questionId, String id) async {
//  await deleteAnswerFromSQLite(questionId);
//     await deleteQuestionFromSQLite(questionId);
//     await deleteAnswerFromFirestore(quizId, questionId, id);
//     // await deleteQuestionFromFirestore(questionId, id);
// }


Future<void> deleteQuizFromFirestore(String quizId) async {
  await _quizFirestore.deleteQuiz(quizId);
}


  Future<void> deleteQuizAndRelatedData(String quizId) async {
    await deleteQuizFromSQLite(quizId);
    await deleteQuizFromFirestore(quizId);
  }


    Future<void> deleteQuiz(String quizId) async {
    await _quizDB.deleteQuizAndRelatedData(quizId);

    await _deletedItemsDB.storeDeletedItem(quizId, 'quiz');
  }

    Future<void> deleteQuestion(String questionId) async {
    await _questionDB.deleteQuestionAndAnswersFromSQLite(questionId);
    await _deletedItemsDB.storeDeletedItem(questionId, 'question');
  }


    Future<void> deleteAnswer(String answerId) async {
    await _answersDB.delete(answerId);
    await _deletedItemsDB.storeDeletedItem(answerId, 'answer');
  }


  Future<void> deleteAndStoreLocally(String itemId, String itemType) async {
  switch (itemType) {
    case 'quiz':
      await deleteQuizFromSQLite(itemId);
      break;
    case 'question':
      await deleteQuestionFromSQLite(itemId);
      break;
    case 'answer':
      await deleteAnswerFromSQLite(itemId);
      break;
    default:
      throw Exception('Invalid item type: $itemType');
  }

  // Store the deleted item in DeletedItemsDB
  await _deletedItemsDB.storeDeletedItem(itemId, itemType);
}




// Future<Quiz?> getQuizFromSQLite(String quizId) async {
//     final Database db = await _openDatabase();


//     List<Map<String, dynamic>> maps = await db.query(
//       'quiz',
//       where: 'id = ?',
//       whereArgs: [quizId],
//     );

//     // Check if the query returned any results
//     if (maps.isNotEmpty) {
//       // Convert the retrieved data into a Quiz object
//       return Quiz.fromMap(maps.first);
//     } else {
//       // Return null if no quiz is found with the specified ID
//       return null;
//     }
//   }


  // Define a method to get a quiz from SQLite using its ID
  Future<Quiz?> getQuizFromSQLite(String quizId) async {

    List<Map<String, dynamic>> maps = await _database.query(
      'quizzes',
      where: 'id = ?',
      whereArgs: [quizId],
    );

    // Check if the query returned any results
    if (maps.isNotEmpty) {
      // Convert the retrieved data into a Quiz object
      return Quiz.fromMap(maps.first);
    } else {
      // Return null if no quiz is found with the specified ID
      return null;
    }
  }


  Future<void> syncUnsyncedQuizzes() async {
    // Fetch unsynced quizzes from SQLite
    List<Quiz> unsyncedQuizzes = await QuizDB().fetchUnsyncedQuizzes();
    
    // Sync unsynced quizzes with Firestore
    for (Quiz quiz in unsyncedQuizzes) {
      await QuizFirestore().createQuiz(
        id: quiz.id,
        quizname: quiz.quizName,
        quizdescription: quiz.quiz_description,
        minutesToComplete: quiz.minutesToComplete,
      );
    }
  }

    Future<void> syncUnsyncedQuestions() async {
    List<Question> unsyncedQuestions = await QuestionDB().fetchUnsyncedQuestions();
    for (Question question in unsyncedQuestions) {
      await QuestionFirestore().createQuestion(
        id: question.id,
        quizQuestion: question.quizQuestion,
        quizId: question.quizId,
      );
    }
  }
    Future<void> syncUnsyncedAnswers() async {
    List<Answer> unsyncedAnswers = await AnswerDB().fetchUnsyncedAnswers();
    for (Answer answer in unsyncedAnswers) {
      await AnswerFirestore().createAnswer(
        id: answer.id,
        answerText: answer.answerText,
        isCorrect: answer.isCorrect,
        questionId: answer.questionId,
        quizId: answer.quizId,
      );
    }
  }
Future<void> syncUpdatedQuizzes(Quiz updatedQuiz) async {
  await QuizFirestore().updateQuiz(
    id: updatedQuiz.id,
    quizname: updatedQuiz.quizName,
    quizdescription: updatedQuiz.quiz_description,
    minutesToComplete: updatedQuiz.minutesToComplete,
  );
}

  Future<void> syncUpdatedQuestions(Question updatedQuestion) async {
    await QuestionFirestore().updateQuestion(
      id: updatedQuestion.id,
      quizQuestion: updatedQuestion.quizQuestion,
      quizId: updatedQuestion.quizId,
    );
  }

    Future<void> syncUpdatedAnswers(Answer updatedAnswer) async {
    await AnswerFirestore().updateAnswer(
      id: updatedAnswer.id,
      answerText: updatedAnswer.answerText,
      isCorrect: updatedAnswer.isCorrect,
      questionId: updatedAnswer.questionId,
      quizId: updatedAnswer.quizId,
    );
  }


  

Future<void> syncUnsyncedUserAnswers() async {
  // Fetch unsynced user answers from SQLite
  List<UserAnswer> unsyncedUserAnswers = await UserAnswerDB().fetchUnsyncedUserAnswer();

  // Sync unsynced user answers with Firestore
  for (UserAnswer userAnswer in unsyncedUserAnswers) {
    await UserAnswerFirestore().createUserAnswer(
      id: userAnswer.id,
      user_email: userAnswer.user_email,
      quizId: userAnswer.quizId,
      questionId: userAnswer.questionId,
      answerId: userAnswer.answerId,
      isCorrect: userAnswer.isCorrect,
    );
  }
}



}


