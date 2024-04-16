import 'package:cloud_firestore/cloud_firestore.dart';
// class Answer {
//   final int id;
//   final String answerText;
//   final bool isCorrect;
//   final int questionId;

//   Answer({
//     required this.id,
//     required this.answerText,
//     required this.isCorrect,
//     required this.questionId,
//   });

//   factory Answer.fromMap(Map<String, dynamic> map) => Answer(
//         id: map['id'],
//         answerText: map['answer_text'],
//         isCorrect: map['is_correct'] == 1 ? true : false,
//         questionId: map['question_id'],
//       );

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'answer_text': answerText,
//       'is_correct': isCorrect ? 1 : 0,
//       'question_id': questionId,
//     };
//   }
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


// class Quiz {
//   final String id;
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

// factory Quiz.fromFirestore(DocumentSnapshot<Object?> doc) {
//   final data = doc.data() as Map<String, dynamic>?; // Cast to nullable map
//   if (data == null) {
//     throw Exception('Failed to parse Quiz data from Firestore');
//   }
//   return Quiz.fromMap(data);
// }


class Quiz {
  final String id;
  final String quizName;
  final String quiz_description;
  final String? syncStatus; 
  final int minutesToComplete;

  Quiz({
    required this.id,
    required this.quizName,
    required this.quiz_description,
    this.syncStatus, 
    required this.minutesToComplete
  });

  factory Quiz.fromMap(Map<String, dynamic> map) => Quiz(
        id: map['id'],
        quizName: map['quiz_name'],
        quiz_description: map['quiz_description'],
        syncStatus: map['sync_status'],
        minutesToComplete: map['minutes_to_complete'],
      );

  factory Quiz.fromSqfliteDatabase(Map<String, dynamic> map) => Quiz(
        id: map['id'],
        quizName: map['quiz_name'],
        quiz_description: map['quiz_description'],
        syncStatus: map['sync_status'],
        minutesToComplete: map['minutes_to_complete'],
      );

  factory Quiz.fromFirestore(DocumentSnapshot<Object?> doc) {
    final data = doc.data() as Map<String, dynamic>?; 
    if (data == null) {
      throw Exception('Failed to parse Quiz data from Firestore');
    }
    return Quiz.fromMap(data);
  }

    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quiz_name': quizName,
      'quiz_description': quiz_description,
      'sync_status': syncStatus,
      'minutes_to_complete': minutesToComplete
    };
  }

    Quiz copyWith({
    String? id,
    String? quizName,
    String? quizDescription,
    String? minutes_to_complete,
  }) {
    return Quiz(
      id: id ?? this.id,
      quizName: quizName ?? this.quizName,
      quiz_description: quizDescription ?? this.quiz_description,
      minutesToComplete: minutesToComplete ?? this.minutesToComplete,
    );
  }
}



class Question {
  final String id;
  final String quizQuestion;
  final String quizId; 
  final String? syncStatus; 

  Question({
    required this.id,
    required this.quizQuestion,
    required this.quizId,
    this.syncStatus, 
  });

  factory Question.fromMap(Map<String, dynamic> map) => Question(
        id: map['id'],
        quizQuestion: map['quiz_question'],
        quizId: map['quiz_id'],
        syncStatus: map['sync_status'],
      );
    factory Question.fromSqfliteDatabase(Map<String, dynamic> map) => Question(
        id: map['id'],
        quizQuestion: map['quiz_question'],
        quizId: map['quiz_id'],
        syncStatus: map['sync_status'],
      );
      
factory Question.fromFirestore(DocumentSnapshot<Object?> doc) {
  final data = doc.data() as Map<String, dynamic>?; // Cast to nullable map
  if (data == null) {
    throw Exception('Failed to parse Question data from Firestore');
  }
  return Question.fromMap(data);
}


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quiz_question': quizQuestion,
      'quiz_id': quizId,
      'sync_status': syncStatus
    };
  }

      Question copyWith({
    String? id,
    String? quizQuestion,
    String? quizId,
  }) {
    return Question(
      id: id ?? this.id,
      quizQuestion: quizQuestion ?? this.quizQuestion,
      quizId: quizId ?? this.quizId,
    );
  }
}

class Answer {
  final String id;
  final String answerText;
  final bool isCorrect;
  final String questionId;
  final String quizId; // New property
  final String? syncStatus; 

  Answer({
    required this.id,
    required this.answerText,
    required this.isCorrect,
    required this.questionId,
    required this.quizId, // Initialize quizId in the constructor
    this.syncStatus, 
  });

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      id: map['id'],
      answerText: map['answer_text'],
      isCorrect: map['is_correct'] == 1,
      questionId: map['question_id'],
      quizId: map['quiz_id'], // Initialize quizId from map
      syncStatus: map['sync_status'],
    );
  }

  factory Answer.fromSqfliteDatabase(Map<String, dynamic> map) {
    return Answer(
      id: map['id'],
      answerText: map['answer_text'],
      isCorrect: map['is_correct'] == 1,
      questionId: map['question_id'],
      quizId: map['quiz_id'], // Initialize quizId from map
      syncStatus: map['sync_status'],
    );
  }

  factory Answer.fromFirestore(DocumentSnapshot<Object?> doc) {
    final data = doc.data() as Map<String, dynamic>?; // Cast to nullable map
    if (data == null) {
      throw Exception('Failed to parse Answer data from Firestore');
    }
    return Answer.fromMap(data);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'answer_text': answerText,
      'is_correct': isCorrect ? 1 : 0,
      'question_id': questionId,
      'quiz_id': quizId, // Include quizId in the map
      'sync_status': syncStatus,
    };
  }

  Answer copyWith({
    String? id,
    String? answerText,
    bool? isCorrect,
    String? questionId,
    String? quizId,
    String? syncStatus,
  }) {
    return Answer(
      id: id ?? this.id,
      answerText: answerText ?? this.answerText,
      isCorrect: isCorrect ?? this.isCorrect,
      questionId: questionId ?? this.questionId,
      quizId: quizId ?? this.quizId, // Update quizId if provided, else use the current value
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}



// class Question {
//   final String id;
//   final String quizQuestion; // Update property name to match the database column name
//   final String quizId;

//   Question({
//     required this.id,
//     required this.quizQuestion, // Update property name
//     required this.quizId,
//   });

//   factory Question.fromMap(Map<String, dynamic> map) => Question(
//         id: map['id'],
//         quizQuestion: map['quiz_question'], // Update property name
//         quizId: map['quiz_id'],
//       );

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'quiz_question': quizQuestion, // Update property name
//       'quiz_id': quizId,
//     };
//   }
// }

