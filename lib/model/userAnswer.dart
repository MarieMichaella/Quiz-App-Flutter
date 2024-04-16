// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserAnswer {
//   final String ud;
//   final String quizId;
//   final String questionId;
//   final String answerId;
//   final bool isCorrect;

//   UserAnswer({
//     required this.userId,
//     required this.quizId,
//     required this.questionId,
//     required this.answerId,
//     required this.isCorrect,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'userId': userId,
//       'quizId': quizId,
//       'questionId': questionId,
//       'answerId': answerId,
//       'isCorrect': isCorrect,
//     };
//   }

//   factory UserAnswer.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

//     if (data == null) {
//       throw Exception('Document data not found!');
//     }

//     return UserAnswer(
//       userId: data['userId'] ?? '',
//       quizId: data['quizId'] ?? '',
//       questionId: data['questionId'] ?? '',
//       answerId: data['answerId'] ?? '',
//       isCorrect: data['isCorrect'] ?? false,
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class UserAnswer {
  final String id;
  final String user_email;
  final String quizId;
  final String questionId;
  final String answerId;
  final bool isCorrect;

  UserAnswer({
    required this.id,
    required this.user_email,
    required this.quizId,
    required this.questionId,
    required this.answerId,
    required this.isCorrect,
  });

  factory UserAnswer.fromMap(Map<String, dynamic> map) {
    return UserAnswer(
      id: map['id'] ?? '',
      user_email: map['user_email'] ?? '',
      quizId: map['quizId'] ?? '',
      questionId: map['questionId'] ?? '',
      answerId: map['answerId'] ?? '',
      isCorrect: map['isCorrect'] ?? false,
    );
  }

  factory UserAnswer.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    if (data == null) {
      throw Exception('Document data not found!');
    }

    return UserAnswer.fromMap(data);
  }

  factory UserAnswer.fromSqfliteDatabase(Map<String, dynamic> map) {
    return UserAnswer(
      id: map['id'],
      user_email: map['user_email'],
      quizId: map['quiz_id'],
      questionId: map['question_id'],
      answerId: map['answer_id'],
      isCorrect: map['is_correct'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_email': user_email,
      'quizId': quizId,
      'questionId': questionId,
      'answerId': answerId,
      'isCorrect': isCorrect ? 1 : 0,
    };
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';

// class UserAnswer {
//   final String id;
//   final String useremail;
//   final String quizId;
//   final String questionId;
//   final String answerId;
//   final bool isCorrect;

//   UserAnswer({
//     required this.id,
//     required this.useremail,
//     required this.quizId,
//     required this.questionId,
//     required this.answerId,
//     required this.isCorrect,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'useremail': useremail,
//       'quizId': quizId,
//       'questionId': questionId,
//       'answerId': answerId,
//       'isCorrect': isCorrect,
//     };
//   }
  
//   factory UserAnswer.fromFirestore(DocumentSnapshot doc) {
//     Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

//     if (data == null) {
//       throw Exception('Document data not found!');
//     }

//     return UserAnswer(
//       id: data['id'] ?? '',
//       useremail: data['useremail']?? '',
//       quizId: data['quizId'] ?? '',
//       questionId: data['questionId'] ?? '',
//       answerId: data['answerId'] ?? '',
//       isCorrect: data['isCorrect'] ?? false,
//     );
//   }
// }
