// import 'package:flutter/material.dart';
// import 'package:quizapp/model/add_category.dart';
// import 'package:quizapp/quiz_db.dart';

// class AddQuizScreen extends StatefulWidget {
//   @override
//   _AddQuizScreenState createState() => _AddQuizScreenState();
// }

// class _AddQuizScreenState extends State<AddQuizScreen> {
//   final TextEditingController _quizNameController = TextEditingController();
//   final TextEditingController _quizDescriptionController = TextEditingController();

//   void _addQuiz() async {
//     String quizName = _quizNameController.text.trim();
//     String quizDescription = _quizDescriptionController.text.trim();

//     if (quizName.isNotEmpty && quizDescription.isNotEmpty) {
//       int id = await QuizDB().create(quizname: quizName, quizdescription: quizDescription);
//       if (id != 0) {
//         // Quiz added successfully, you can navigate to another screen or show a success message
//         // For example:
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Quiz added successfully')));
//       } else {
//         // Failed to add quiz
//         // Handle error here
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add quiz')));
//       }
//     } else {
//       // Show error message if any field is empty
//       // For example:
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Quiz'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _quizNameController,
//               decoration: InputDecoration(labelText: 'Quiz Name'),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _quizDescriptionController,
//               decoration: InputDecoration(labelText: 'Quiz Description'),
//               maxLines: null, // Allow multiple lines for description
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _addQuiz,
//               child: Text('Add Quiz'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class QuizListScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz List'),
//       ),
//       body: FutureBuilder<List<Quiz>>(
//         future: QuizDB().fetchAll(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             List<Quiz>? quizzes = snapshot.data;
//             if (quizzes == null || quizzes.isEmpty) {
//               return Center(child: Text('No quizzes available'));
//             } else {
//               return ListView.builder(
//                 itemCount: quizzes.length,
//                 itemBuilder: (context, index) {
//                   Quiz quiz = quizzes[index];
//                   return ListTile(
//                     title: Text(quiz.quizname),
//                     subtitle: Text(quiz.quizDescription),
//                     onTap: () {
//                     },
//                   );
//                 },
//               );
//             }
//           }
//         },
//       ),
//     );
//   }
// }