// import 'package:flutter/material.dart';
// import 'package:quizapp/question_db.dart';
// import 'package:quizapp/quiz_db.dart'; // Import the QuizDB class

// class AllQuestionsScreen extends StatefulWidget {
//   @override
//   _AllQuestionsScreenState createState() => _AllQuestionsScreenState();
// }

// class _AllQuestionsScreenState extends State<AllQuestionsScreen> {
//   late Future<List<Question>> _questionsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _questionsFuture = _getAllQuestions();
//   }

//   Future<List<Question>> _getAllQuestions() async {
//     // Retrieve all questions from the database
//     return await QuestionDB().fetchAll();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('All Questions'),
//       ),
//       body: FutureBuilder<List<Question>>(
//         future: _questionsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else if (snapshot.hasData) {
//             List<Question> questions = snapshot.data!;
//             return ListView.builder(
//               itemCount: questions.length,
//               itemBuilder: (context, index) {
//                 Question question = questions[index];
//                 return ListTile(
//                   title: Text(question.question),
//                   subtitle: Text('Result: ${question.result}'),
//                   // You can display additional information here if needed
//                 );
//               },
//             );
//           } else {
//             return Center(
//               child: Text('No questions found'),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
