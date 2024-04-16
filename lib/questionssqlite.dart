// // 

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:random_string/random_string.dart';
// import 'services/database.dart'; 

// class AddQuiz extends StatefulWidget {
//   const AddQuiz({Key? key});

//   @override
//   State<AddQuiz> createState() => _AddQuizState();
// }

// class _AddQuizState extends State<AddQuiz> {
//   final ImagePicker _picker = ImagePicker();
//   File? selectedImage;
//   late List<String> quizItems;
//   String? selectedQuiz;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch existing quizzes from the SQLite database
//     fetchQuizzes();
//   }

//   Future<void> fetchQuizzes() async {
//     // Use your database helper class to fetch quizzes
//     List<String> quizzes = await DatabaseHelper().getAllQuizzes(); // Modify this according to your database implementation
//     setState(() {
//       quizItems = quizzes;
//     });
//   }

//   Future<void> getImage() async {
//     var image = await _picker.pickImage(source: ImageSource.gallery);
//     selectedImage = File(image!.path);
//     setState(() {});
//   }

//   uploadItem() async {
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Add Quiz",
//           style: TextStyle(color: Colors.black, fontSize: 30.0, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Upload the Quiz Picture",
//                 style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w700),
//               ),
//               SizedBox(height: 20.0),
//               // Your image upload widget goes here
//               // Modify as needed based on your previous implementation
//               SizedBox(height: 20.0),
//               Text(
//                 "Select Quiz",
//                 style: TextStyle(color: Colors.black87, fontSize: 20.0, fontWeight: FontWeight.w500),
//               ),
//               SizedBox(height: 10.0),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   color: Color(0xFFececf8),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<String>(
//                     items: quizItems.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedQuiz = value;
//                       });
//                     },
//                     value: selectedQuiz,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               // Your option text fields and other widgets go here
//               // Modify as needed based on your previous implementation
//               SizedBox(height: 30.0),
//               GestureDetector(
//                 onTap: () {
//                   uploadItem();
//                 },
//                 child: Center(
//                   child: Material(
//                     elevation: 5.0,
//                     borderRadius: BorderRadius.circular(10),
//                     child: Container(
//                       padding: EdgeInsets.symmetric(vertical: 8.0),
//                       width: 150,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Center(
//                         child: Text(
//                           "Add",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 22.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:quizapp/question_db.dart';

// class AddQuestionScreen extends StatefulWidget {
//   @override
//   _AddQuestionScreenState createState() => _AddQuestionScreenState();
// }

// class _AddQuestionScreenState extends State<AddQuestionScreen> {
//   final List<TextEditingController> _questionControllers = List.generate(
//     4,
//     (index) => TextEditingController(),
//   );
//   final List<TextEditingController> _resultControllers = List.generate(
//     4,
//     (index) => TextEditingController(),
//   );

//   void _addQuestions() async {
//     for (int i = 0; i < 4; i++) {
//       String question = _questionControllers[i].text.trim();
//       String result = _resultControllers[i].text.trim();

//       if (question.isNotEmpty && result.isNotEmpty) {
//         await QuestionDB().create(question: question, result: result, quizId: 1); // Assuming quizId is 1
//       }
//     }
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Questions added successfully')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Questions'),
//       ),
//       body: ListView.builder(
//         itemCount: 4,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 TextField(
//                   controller: _questionControllers[index],
//                   decoration: InputDecoration(labelText: 'Question ${index + 1}'),
//                 ),
//                 SizedBox(height: 16.0),
//                 TextField(
//                   controller: _resultControllers[index],
//                   decoration: InputDecoration(labelText: 'Result ${index + 1}'),
//                 ),
//                 SizedBox(height: 16.0),
//               ],
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _addQuestions,
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// 


// import 'package:flutter/material.dart';
// import 'package:quizapp/question_db.dart';
// import 'package:quizapp/quiz_db.dart';
// import 'package:quizapp/model/add_category.dart';

// class AddQuestionScreen extends StatefulWidget {
//   @override
//   _AddQuestionScreenState createState() => _AddQuestionScreenState();
// }

// class _AddQuestionScreenState extends State<AddQuestionScreen> {
//   final TextEditingController _questionController = TextEditingController();
//   final TextEditingController _resultController = TextEditingController();
//   late Future<List<Quiz>> _quizzes; // Define a Future for quizzes

//   @override
//   void initState() {
//     super.initState();
//     _quizzes = QuizDB().fetchAll(); // Fetch all quizzes when the screen initializes
//   }

//   void _addQuestion() async {
//     String question = _questionController.text.trim();
//     String result = _resultController.text.trim();

//     if (question.isNotEmpty && result.isNotEmpty) {
//       int quizId = 1; // Default value
//       // You can get the selected quiz ID from the dropdown and assign it to quizId

//       int id = await QuestionDB().create(question: question, result: result, quizId: quizId);
//       if (id != 0) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Question added successfully')));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add question')));
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all fields')));
//     }
//   }

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
//             FutureBuilder<List<Quiz>>(
//               future: _quizzes,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator(); // Show loading indicator while fetching quizzes
//                 }
//                 if (snapshot.hasData) {
//                   return DropdownButtonFormField<int>(
//                     items: snapshot.data!.map((quiz) {
//                       return DropdownMenuItem<int>(
//                         value: quiz.id,
//                         child: Text(quiz.quizname), // Assuming each quiz has a title
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         // Set the selected quiz ID to be used when adding questions
//                         // This value will be used as the foreign key
//                         // quizId = value; // Uncomment this line if you want to use the selected quiz ID
//                       });
//                     },
//                     decoration: InputDecoration(labelText: 'Select Quiz'),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return Text('No quizzes available');
//                 }
//               },
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _questionController,
//               decoration: InputDecoration(labelText: 'Question'),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _resultController,
//               decoration: InputDecoration(labelText: 'Result'),
//               maxLines: null, // Allow multiple lines for result
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _addQuestion,
//               child: Text('Add Question'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
