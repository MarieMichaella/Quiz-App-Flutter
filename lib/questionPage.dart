// import 'package:flutter/material.dart';
// import 'package:quizapp/quiz_db.dart';
// import 'package:quizapp/question_db.dart';
// import 'package:quizapp/model/add_category.dart';

// class AddQuestionScreen extends StatefulWidget {
//   @override
//   _AddQuestionScreenState createState() => _AddQuestionScreenState();
// }

// class _AddQuestionScreenState extends State<AddQuestionScreen> {
//   final TextEditingController _questionController = TextEditingController();
//   String _selectedQuiz = ''; // Variable to store the selected quiz

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Question'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             FutureBuilder<List<DropdownMenuItem<int>>>(
//               future: _buildDropdownItems(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return DropdownButtonFormField<int>(
//   value: _selectedQuiz.isNotEmpty ? int.parse(_selectedQuiz) : null,
//   hint: Text('Select Quiz'),
//   onChanged: (int? value) {
//     setState(() {
//       _selectedQuiz = value.toString();
//     });
//   },
//   items: snapshot.data,
// );

//                 }
//               },
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _questionController,
//               decoration: InputDecoration(labelText: 'Question'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 // Add question logic here
//                 _addQuestion();
//               },
//               child: Text('Add Question'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// Future<List<DropdownMenuItem<int>>> _buildDropdownItems() async {
//   List<DropdownMenuItem<int>> items = [];
//   List<Quiz> quizzes = await QuizDB().fetchAll();
  
//   // Check if quizzes list is not empty
//   if (quizzes.isNotEmpty) {
//     // Iterate over each quiz and create a DropdownMenuItem for it
//     quizzes.forEach((quiz) {
//       items.add(DropdownMenuItem(
//         value: quiz.id, // Keep the ID as an integer
//         child: Text(quiz.quizName),
//       ));
//     });
//   } else {
//     // Handle the case when no quizzes are fetched from the database
//     // For example, you can add a default item or show a message
//     items.add(DropdownMenuItem(
//       value: 0, // Or any default value that represents no selection
//       child: Text('No quizzes available'),
//     ));
//   }
  
//   return items;
// }




//   void _addQuestion() async {
//     String question = _questionController.text.trim();
//     String quizId = _selectedQuiz;

//     if (question.isNotEmpty && quizId.isNotEmpty) {
//       int id = await QuestionDB().create(id: id,quizQuestion: question, quizId: quizId);
//       if (id != 0) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Question added successfully')));
//         _questionController.clear();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add question')));
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a quiz and enter a question')));
//     }
//   }
// }
