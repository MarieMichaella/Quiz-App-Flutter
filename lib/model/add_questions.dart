// class Question {
//   // final int id;
//   final String quizQuestion; // Update property name to match the database column name
//   final int quizId;

//   Question({
//     // required this.id,
//     required this.quizQuestion, // Update property name
//     required this.quizId,
//   });

//   factory Question.fromMap(Map<String, dynamic> map) => Question(
//         // id: map['id'],
//         quizQuestion: map['quiz_question'], // Update property name
//         quizId: map['quiz_id'],
//       );

//   Map<String, dynamic> toMap() {
//     return {
//       // 'id': id,
//       'quiz_question': quizQuestion, // Update property name
//       'quiz_id': quizId,
//     };
//   }
// }


class Question {
  // final int id;
  final String quizQuestion;
  final int quizId;

  Question({
    // required this.id,
    required this.quizQuestion,
    required this.quizId,
  });

  factory Question.fromMap(Map<String, dynamic> map) => Question(
        // id: map['id'],
        quizQuestion: map['quiz_question'],
        quizId: map['quiz_id'],
      );

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'quiz_question': quizQuestion,
      'quiz_id': quizId,
    };
  }
}
