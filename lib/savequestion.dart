// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart'; // Import your Quiz model class
// import 'package:quizapp/syncservices.dart'; // Import your SyncService class


// class CreateQuestionScreen extends StatefulWidget {
//   @override
//   _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
// }

// class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
//   final TextEditingController _questionController = TextEditingController();
//   String? _selectedQuizId; // Store the selected quiz ID here

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Quiz'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _questionController,
//               decoration: InputDecoration(labelText: 'Question'),
//             ),
//             SizedBox(height: 16.0),
//             FutureBuilder<List<Quiz>>(
//               future: SyncService().getAllQuizzesFromSQLite(), // Fetch quizzes from SQLite
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return DropdownButtonFormField<String>(
//                     value: _selectedQuizId,
//                     onChanged: (String? newValue) {
//                       setState(() {
//                         _selectedQuizId = newValue;
//                       });
//                     },
//                     items: snapshot.data!.map((quiz) {
//                       return DropdownMenuItem<String>(
//                         value: quiz.id.toString(),
//                         child: Text(quiz.quizName),
//                       );
//                     }).toList(),
//                     decoration: InputDecoration(labelText: 'Select Quiz'),
//                   );
//                 }
//               },
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _saveQuestion,
//               child: Text('Save Question'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _saveQuestion() {
//     // Get the question text
//     String questionText = _questionController.text.trim();

//     // Check if question text is not empty and quiz is selected
//     if (questionText.isNotEmpty && _selectedQuizId != null) {
//       // Create a new Question object
//       Question newQuestion = Question(
//         id: 0, // SQLite will assign ID
//         quizQuestion: questionText,
//         quizId: int.parse(_selectedQuizId!), // Convert selected quiz ID to int
//       );

//       // Save the question to both SQLite and Firestore
//       SyncService().saveQuestionToSQLite(newQuestion);
//       SyncService().saveQuestionToFirestore(newQuestion);

//       // Show a confirmation message
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Question saved successfully')));

//       // Clear the text field
//       _questionController.clear();
//     } else {
//       // Show an error message if the question text is empty or quiz is not selected
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a question and select a quiz')));
//     }
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart'; // Import your Question model class
// import 'package:quizapp/syncservices.dart'; // Import your SyncService class
// import 'package:uuid/uuid.dart';

// class CreateQuestionScreen extends StatefulWidget {
//   final String quizId;

//   const CreateQuestionScreen({Key? key, required this.quizId}) : super(key: key);

//   @override
//   _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
// }

// class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
//   final TextEditingController _questionController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Question'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _questionController,
//               decoration: InputDecoration(labelText: 'Question'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _saveQuestion,
//               child: Text('Save Question'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// void _saveQuestion() {
//   // Get the question text
//   String questionText = _questionController.text.trim();

//   // Generate a unique ID for the question
//   String questionId = Uuid().v4(); // Using the uuid package to generate a UUID

//   // Check if question text is not empty
//   if (questionText.isNotEmpty) {
//     // Create a new Question object
//     Question newQuestion = Question(
//       id: questionId, // Assign the generated UUID to the question ID
//       quizQuestion: questionText,
//       quizId: widget.quizId, // Use the quizId passed from CreateQuizScreen
//     );

//     // Save the question to both SQLite and Firestore
//     SyncService().saveQuestionToSQLite(newQuestion);
//     SyncService().saveQuestionToFirestore(newQuestion);

//     // Show a confirmation message
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Question saved successfully')));

//     // Clear the text field
//     _questionController.clear();
//   } else {
//     // Show an error message if the question text is empty
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a question')));
//   }
// }

// }


// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart'; // Import your Question model class
// import 'package:quizapp/syncservices.dart'; // Import your SyncService class
// import 'package:uuid/uuid.dart';
// import 'package:quizapp/answersPage.dart';

// class CreateQuestionScreen extends StatefulWidget {
//   final String quizId; 

//   const CreateQuestionScreen({Key? key, required this.quizId}) : super(key: key);

//   @override
//   _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
// }

// class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
//     String? _createdQuestion;
//   final TextEditingController _questionController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Question'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _questionController,
//               decoration: InputDecoration(labelText: 'Question'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _saveQuestion,
//               child: Text('Save Question'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to the answer creation screen and pass the question ID
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => CreateAnswerScreen(questionId: _createdQuestion),
//                   ),
//                 );
//               },
//               child: Text('Add Answer'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _saveQuestion() async{
//     // Get the question text
//     String questionText = _questionController.text.trim();

//     // Generate a unique ID for the question
//     String questionId = Uuid().v4(); // Using the uuid package to generate a UUID

//     // Check if question text is not empty
//     if (questionText.isNotEmpty) {
//       // Create a new Question object
//       Question newQuestion = Question(
//         id: questionId, // Assign the generated UUID to the question ID
//         quizQuestion: questionText,
//         quizId: widget.quizId, // Use the quizId passed from CreateQuizScreen
//       );

//       // Save the question to both SQLite and Firestore
//       _createdQuestion = await SyncService().saveQuestionToSQLite(newQuestion);
//       SyncService().saveQuestionToFirestore(newQuestion);

//       // Show a confirmation message
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Question saved successfully')));

//       // Clear the text field
//       _questionController.clear();
//     } else {
//       // Show an error message if the question text is empty
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a question')));
//     }
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:navigations/model/syncModel.dart';
// import 'package:navigations/syncservices.dart';
// import 'package:uuid/uuid.dart';
// import 'package:navigations/answersPage.dart';

// class CreateQuestionScreen extends StatefulWidget {
//   final String quizId;

//   const CreateQuestionScreen({Key? key, required this.quizId}) : super(key: key);

//   @override
//   _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
// }

// class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
//   String? _createdQuestion;
//   final TextEditingController _questionController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Question'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 170, left: 16.0, right: 16.0, bottom: 16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextFormField(
//               controller: _questionController,
//               decoration: InputDecoration(
//                 labelText: 'Question',
//                 border: OutlineInputBorder(),
//                 hintText: 'Enter the question',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _saveQuestion,
//               child: Text('Save Question'),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(vertical: 16.0), // Adjust padding as needed
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 // Check if _createdQuestion is not null before navigating
//                 if (_createdQuestion != null) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => CreateAnswerScreen(questionId: _createdQuestion!),
//                     ),
//                   );
//                 } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(
//                           'Please save the question first',
//                           style: TextStyle(fontSize: 16.0, color: Colors.white),
//                         ),
//                         backgroundColor: Color(0xFF5271FF), 
//                         elevation: 8.0, 
//                         behavior: SnackBarBehavior.floating, 
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         margin: EdgeInsets.all(16.0), 
//                         duration: Duration(seconds: 3), 
//                       ),
//                     );
//                 }
//               },
//               child: Text('Add Answer'),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(vertical: 16.0), // Adjust padding as needed
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _saveQuestion() async {
//     // Get the question text
//     String questionText = _questionController.text.trim();

//     // Generate a unique ID for the question
//     String questionId = Uuid().v4(); // Using the uuid package to generate a UUID

//     // Check if question text is not empty
//     if (questionText.isNotEmpty) {
//       // Create a new Question object
//       Question newQuestion = Question(
//         id: questionId, // Assign the generated UUID to the question ID
//         quizQuestion: questionText,
//         quizId: widget.quizId, // Use the quizId passed from CreateQuizScreen
//       );

//       // Save the question to both SQLite and Firestore
//       _createdQuestion = await SyncService().saveQuestionToSQLite(newQuestion);
//       SyncService().saveQuestionToFirestore(newQuestion);

//             ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Question saved successfully',
//             style: TextStyle(fontSize: 16.0, color: Colors.white),
//           ),
//           backgroundColor: Color(0xFF5271FF), 
//           elevation: 8.0, 
//           behavior: SnackBarBehavior.floating, 
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           margin: EdgeInsets.all(16.0), 
//           duration: Duration(seconds: 3), 
//         ),
//       );

//       _questionController.clear();
//     } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Please enter a question',
//               style: TextStyle(fontSize: 16.0, color: Colors.white),
//             ),
//             backgroundColor: Color(0xFF5271FF), 
//             elevation: 8.0, 
//             behavior: SnackBarBehavior.floating, 
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             margin: EdgeInsets.all(16.0), 
//             duration: Duration(seconds: 3), 
//           ),
//         );
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:quizapp/model/syncModel.dart';
import 'package:quizapp/syncservices.dart';
import 'package:uuid/uuid.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quizapp/question_db.dart';
import 'package:quizapp/answersPage.dart';

class CreateQuestionScreen extends StatefulWidget {
  final String quizId;

  const CreateQuestionScreen({Key? key, required this.quizId}) : super(key: key);

  @override
  _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  String? _createdQuestionId;
  final TextEditingController _questionController = TextEditingController();
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    checkConnectionStatus();
  }

  Future<void> checkConnectionStatus() async {
    bool connected = await InternetConnectionChecker().hasConnection;
    setState(() {
      isConnected = connected;
    });
  }

  void _saveQuestion() async {
    String questionText = _questionController.text.trim();
    String questionId = Uuid().v4();

    bool isConnected = await InternetConnectionChecker().hasConnection;

    if (questionText.isNotEmpty) {
      Question newQuestion = Question(
        id: questionId,
        quizQuestion: questionText,
        quizId: widget.quizId,
      );

      try {
        if (isConnected) {

                    await SyncService().saveQuestionToFirestore(newQuestion);
                    await SyncService().saveQuestionToSQLite(newQuestion);
          _createdQuestionId = questionId; 
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Question saved and synced with Firestore',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              backgroundColor: Color(0xFF5271FF),
              elevation: 8.0,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              margin: EdgeInsets.all(16.0),
              duration: Duration(seconds: 3),
            ),
          );

                            Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAnswerScreen(questionId: _createdQuestionId!, quizId: widget.quizId,),
                    ),
                  );
        } else {
          _createdQuestionId = await SyncService().saveQuestionToSQLite(newQuestion);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Question saved locally',
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              backgroundColor: Color(0xFF5271FF),
              elevation: 8.0,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              margin: EdgeInsets.all(16.0),
              duration: Duration(seconds: 3),
            ),
          );
          await QuestionDB().setSyncStatus(questionId, 'unsynced');
                            Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAnswerScreen(questionId: _createdQuestionId!, quizId: widget.quizId,),
                    ),
                  );
        }

        bool isReconnected = await InternetConnectionChecker().hasConnection;
        if (_createdQuestionId != null && isConnected && isReconnected) {
          _questionController.clear();
        }
      } catch (error) {
        print('Error: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error saving question',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            backgroundColor: Color(0xFF5271FF),
            elevation: 8.0,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: EdgeInsets.all(16.0),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a question',
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          backgroundColor: Color(0xFF5271FF),
          elevation: 8.0,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: EdgeInsets.all(16.0),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }


//   void _navigateToCreateAnswerScreen() {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => CreateAnswerScreen(
//         questionId: _createdQuestionId!,
//         quizId: widget.quizId,
//       ),
//     ),
//   );
// }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Question'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 120.0, left:16.0, right:16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _questionController,
              decoration: InputDecoration(
                labelText: 'Question',
                border: OutlineInputBorder(),
                hintText: 'Enter the question',
              ),
            ),
            SizedBox(height: 26.0),
ElevatedButton(
  onPressed: () async{
    _saveQuestion(); 

                  if (_createdQuestionId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAnswerScreen(questionId: _createdQuestionId!, quizId: widget.quizId,),
                    ),
                  );
                } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please save the question first',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        backgroundColor: Color(0xFF5271FF), 
                        elevation: 8.0, 
                        behavior: SnackBarBehavior.floating, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        margin: EdgeInsets.all(16.0), 
                        duration: Duration(seconds: 3), 
                      ),
                    );
                }
  },
  child: Text('Save Question'),
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 16.0),
  ),
),

            // SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: () {
            //     if (_createdQuestionId != null) {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => CreateAnswerScreen(questionId: _createdQuestionId!, quizId: widget.quizId,),
            //         ),
            //       );
            //     } else {
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(
            //             content: Text(
            //               'Please save the question first',
            //               style: TextStyle(fontSize: 16.0, color: Colors.white),
            //             ),
            //             backgroundColor: Color(0xFF5271FF), 
            //             elevation: 8.0, 
            //             behavior: SnackBarBehavior.floating, 
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(8.0),
            //             ),
            //             margin: EdgeInsets.all(16.0), 
            //             duration: Duration(seconds: 3), 
            //           ),
            //         );
            //     }
            //   },
            //   child: Text('Add Answer'),
            //   style: ElevatedButton.styleFrom(
            //     padding: EdgeInsets.symmetric(vertical: 16.0), // Adjust padding as needed
            //   ),
            // ),
            SizedBox(height: 16.0),
            Text(
              isConnected ? 'Connected' : 'Not Connected',
              style: TextStyle(
                fontSize: 18,
                color: isConnected ? Colors.green : Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
