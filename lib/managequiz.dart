// // import 'package:flutter/material.dart';
// // import 'package:quizapp/model/syncModel.dart'; // Import your Quiz model
// // import 'package:quizapp/syncservices.dart'; // Import your SyncService class
// // import 'package:quizapp/quiz_db.dart';

// // class ManageQuizzesScreen extends StatefulWidget {
// //   const ManageQuizzesScreen({Key? key}) : super(key: key);

// //   @override
// //   _ManageQuizzesScreenState createState() => _ManageQuizzesScreenState();
// // }

// // class _ManageQuizzesScreenState extends State<ManageQuizzesScreen> {
// //   final SyncService _syncService = SyncService();
// //   late List<Quiz> quizzes;

// //   @override
// //   void initState() {
// //     super.initState();
// //     loadQuizzes();
// //   }

// //   Future<void> loadQuizzes() async {
// //     quizzes = await _syncService.fetchAllQuizzes(); // Fetch quizzes from your data source
// //     setState(() {});
// //   }

// //   Future<void> deleteQuiz(String quizId) async {
// //     await _syncService.deleteQuiz(quizId); // Delete quiz from your data source
// //     setState(() {
// //       quizzes.removeWhere((quiz) => quiz.id == quizId);
// //     });
// //   }

// //   Future<void> updateQuizName(String quizId, String newName) async {
// //     await _syncService.updateQuiz(quizId, newName); // Update quiz name in your data source
// //     setState(() {
// //       final quiz = quizzes.firstWhere((quiz) => quiz.id == quizId);
// //       quiz.quizName = newName;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Manage Quizzes'),
// //       ),
// //       body: ListView.builder(
// //         itemCount: quizzes.length,
// //         itemBuilder: (context, index) {
// //           final quiz = quizzes[index];
// //           return ListTile(
// //             title: Text(quiz.quizName),
// //             subtitle: Text(quiz.quizDescription),
// //             trailing: Row(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 IconButton(
// //                   icon: Icon(Icons.edit),
// //                   onPressed: () {
// //                     // Implement update quiz name functionality
// //                     // For simplicity, I'll use a text field in a dialog
// //                     showDialog(
// //                       context: context,
// //                       builder: (context) {
// //                         TextEditingController controller =
// //                             TextEditingController(text: quiz.quizName);
// //                         return AlertDialog(
// //                           title: Text('Update Quiz Name'),
// //                           content: TextField(
// //                             controller: controller,
// //                             decoration: InputDecoration(hintText: 'Enter new name'),
// //                           ),
// //                           actions: [
// //                             TextButton(
// //                               onPressed: () {
// //                                 Navigator.pop(context);
// //                               },
// //                               child: Text('Cancel'),
// //                             ),
// //                             TextButton(
// //                               onPressed: () {
// //                                 updateQuizName(quiz.id, controller.text);
// //                                 Navigator.pop(context);
// //                               },
// //                               child: Text('Update'),
// //                             ),
// //                           ],
// //                         );
// //                       },
// //                     );
// //                   },
// //                 ),
// //                 IconButton(
// //                   icon: Icon(Icons.delete),
// //                   onPressed: () {
// //                     // Implement delete quiz functionality
// //                     deleteQuiz(quiz.id);
// //                   },
// //                 ),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }



// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart'; // Import your Quiz model
// import 'package:quizapp/syncservices.dart'; // Import your SyncService class

// class ManageQuizzesScreen extends StatefulWidget {
//   const ManageQuizzesScreen({Key? key}) : super(key: key);

//   @override
//   _ManageQuizzesScreenState createState() => _ManageQuizzesScreenState();
// }

// class _ManageQuizzesScreenState extends State<ManageQuizzesScreen> {
//   final SyncService _syncService = SyncService();
//   late List<Quiz> quizzes;

//   @override
//   void initState() {
//     super.initState();
//     loadQuizzes();
//   }

//   Future<void> loadQuizzes() async {
//     quizzes = await _syncService.getAllQuizzesFromSQLite(); // Fetch quizzes from SQLite
//     setState(() {});
//   }

//   Future<void> deleteQuiz(String quizId) async {
//     await _syncService.deleteQuizAndRelatedData(quizId); // Delete quiz and related data
//     setState(() {
//       quizzes.removeWhere((quiz) => quiz.id == quizId);
//     });
//   }

//   Future<void> updateQuizName(String quizId, String newName) async {
//     await _syncService.updateQuizName(quizId, newName); // Update quiz name in SQLite and Firestore
//     setState(() {
//       final quiz = quizzes.firstWhere((quiz) => quiz.id == quizId);
//       quiz.quizName = newName;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Manage Quizzes'),
//       ),
//       body: ListView.builder(
//         itemCount: quizzes.length,
//         itemBuilder: (context, index) {
//           final quiz = quizzes[index];
//           return ListTile(
//             title: Text(quiz.quizName),
//             subtitle: Text(quiz.quiz_description),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () {
//                     // Implement update quiz name functionality
//                     // For simplicity, I'll use a text field in a dialog
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         TextEditingController controller =
//                             TextEditingController(text: quiz.quizName);
//                         return AlertDialog(
//                           title: Text('Update Quiz Name'),
//                           content: TextField(
//                             controller: controller,
//                             decoration: InputDecoration(hintText: 'Enter new name'),
//                           ),
//                           actions: [
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Text('Cancel'),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 updateQuizName(quiz.id, controller.text);
//                                 Navigator.pop(context);
//                               },
//                               child: Text('Update'),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () {
//                     // Implement delete quiz functionality
//                     deleteQuiz(quiz.id);
//                   },
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
