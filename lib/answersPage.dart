// import 'package:flutter/material.dart';
// import 'package:quizapp/model/add_category.dart';
// import 'package:quizapp/answers_db.dart';

// class AddQuestionScreen extends StatefulWidget {
//   @override
//   _AddQuestionScreenState createState() => _AddQuestionScreenState();
// }

// class _AddQuestionScreenState extends State<AddQuestionScreen> {
//   final TextEditingController _answerTextController = TextEditingController();
//   final TextEditingController _is_correctController = TextEditingController();
//   final TextEditingController _questionIdController = TextEditingController();

//   void _addQuiz() async {
//     String answerText = _answerTextController.text.trim();
//     String is_correct = _is_correctController.text.trim();
//     String question_id = _questionIdController.text.trim();

//     if (answerText.isNotEmpty && is_correct.isNotEmpty && question_id.isNotEmpty) {
//       int id = await AnswerDB().create(answer_text: answerText, is_correct: is_correct, question_id: question_id);
//       if (id != 0) {
//         // Quiz added successfully, you can navigate to another screen or show a success message
//         // For example:
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Answer added successfully')));
//       } else {
//         // Failed to add quiz
//         // Handle error here
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Answer to add question')));
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
//         title: Text('Add Answer'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _answerTextController,
//               decoration: InputDecoration(labelText: 'AnswerText'),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _is_correctController,
//               decoration: InputDecoration(labelText: 'result'),
//               maxLines: null, // Allow multiple lines for description
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _questionIdController,
//               decoration: InputDecoration(labelText: 'question_id'),
//               maxLines: null, // Allow multiple lines for description
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _addQuiz,
//               child: Text('Add Question'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:quizapp/answers_db.dart';
// import 'package:quizapp/question_db.dart';
// import 'package:quizapp/model/add_answer.dart';
// import 'package:quizapp/model/add_questions.dart';

// class AddAnswerScreen extends StatefulWidget {
//   @override
//   _AddAnswerScreenState createState() => _AddAnswerScreenState();
// }

// class _AddAnswerScreenState extends State<AddAnswerScreen> {
//   final TextEditingController _answerController = TextEditingController();
//   String _selectedQuestionId = ''; // Change the type to String

//   @override
//   void initState() {
//     super.initState();
//     _selectedQuestionId = ''; // Initialize _selectedQuestionId to an empty string
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Answer'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _answerController,
//               decoration: InputDecoration(labelText: 'Answer Text'),
//             ),
//             SizedBox(height: 16.0),
//             FutureBuilder<List<DropdownMenuItem<int>>>(
//               future: _buildDropdownItems(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return DropdownButtonFormField<int>(
//                     value: _selectedQuestionId.isNotEmpty ? int.parse(_selectedQuestionId) : null,
//                     hint: Text('Select Question'),
//                     onChanged: (int? value) {
//                       setState(() {
//                         _selectedQuestionId = value.toString();
//                       });
//                     },
//                     items: snapshot.data,
//                   );
//                 }
//               },
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 _addAnswer();
//               },
//               child: Text('Add Answer'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<List<DropdownMenuItem<int>>> _buildDropdownItems() async {
//     List<DropdownMenuItem<int>> items = [];
//     List<Question> questions = await QuestionDB().fetchAll();
//     print('Number of questions fetched: ${questions.length}'); // Add this debug print
//     if (questions.isNotEmpty) {
//       questions.forEach((question) {
//         print('Question ID: ${question.id}, Question Text: ${question.quizQuestion}'); // Add this debug print
//         items.add(DropdownMenuItem(
//           value: question.id,
//           child: Text(question.quizQuestion),
//         ));
//       });
//     } else {
//       items.add(DropdownMenuItem(
//         value: 0,
//         child: Text('No questions available'),
//       ));
//     }
//     print('Number of items: ${items.length}'); // Add this debug print
//     return items;
//   }

//   void _addAnswer() async {
//     String answerText = _answerController.text.trim();

//     if (answerText.isNotEmpty && _selectedQuestionId.isNotEmpty) {
//       int id = await AnswerDB().create(answerText: answerText, isCorrect: true, questionId: int.parse(_selectedQuestionId));
//       if (id != 0) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Answer added successfully')));
//         _answerController.clear();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add answer')));
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a question and enter an answer')));
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:quizapp/answers_db.dart';
// import 'package:quizapp/question_db.dart';
// import 'package:quizapp/syncservices.dart';
// import 'package:quizapp/model/syncModel.dart';


// class CreateAnswerScreen extends StatefulWidget {
//   @override
//   _CreateAnswerScreenState createState() => _CreateAnswerScreenState();
// }

// class _CreateAnswerScreenState extends State<CreateAnswerScreen> {
//   final TextEditingController _answerTextController = TextEditingController();
//   bool _isCorrect = false;
//   int _selectedQuestionId = 0; // Initially selected question ID
//   List<Question> _questions = []; // List of questions from SQLite or Firestore

//   @override
//   void initState() {
//     super.initState();
//     // Load questions from SQLite or Firestore
//     _loadQuestions();
//   }

//   Future<void> _loadQuestions() async {
//     // Fetch questions from SQLite or Firestore
//     _questions = await SyncService().getAllQuestionsFromSQLite(); // Or from Firestore
//     // Update the state to reflect changes
//     setState(() {});
//   }

//   void _createAnswer() async {
//     String answerText = _answerTextController.text.trim();
//     if (answerText.isNotEmpty && _selectedQuestionId != 0) {
//       // Create a new Answer object
//       Answer newAnswer = Answer(
//         id: 0, // Assuming the ID will be assigned by the database
//         answerText: answerText,
//         isCorrect: _isCorrect,
//         questionId: _selectedQuestionId,
//       );

//       // Save the answer to both SQLite and Firestore
//       SyncService().saveAnswerToSQLite(newAnswer);
//       SyncService().saveAnswerToFirestore(newAnswer);

//       // Show a confirmation message
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Answer created successfully')));

//       // Clear the text field
//       _answerTextController.clear();
//     } else {
//       // Show an error message if the answer text is empty or no question selected
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter an answer and select a question')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Answer'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _answerTextController,
//               decoration: InputDecoration(labelText: 'Answer Text'),
//             ),
//             SizedBox(height: 16.0),
//             DropdownButtonFormField<int>(
//               value: _selectedQuestionId,
//               items: _questions.map((question) {
//                 return DropdownMenuItem<int>(
//                   // value: question.id,
//                   child: Text(question.quizQuestion),
//                 );
//               }).toList(),
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedQuestionId = newValue!;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Select Question',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16.0),
//             CheckboxListTile(
//               title: Text('Is Correct?'),
//               value: _isCorrect,
//               onChanged: (newValue) {
//                 setState(() {
//                   _isCorrect = newValue!;
//                 });
//               },
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _createAnswer,
//               child: Text('Create Answer'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:navigations/answers_db.dart';
// import 'package:navigations/question_db.dart';
// import 'package:navigations/syncservices.dart';
// import 'package:navigations/model/syncModel.dart';
// import 'package:uuid/uuid.dart';

// class CreateAnswerScreen extends StatefulWidget {
//   final String questionId; // Pass the questionId as a parameter

//   const CreateAnswerScreen({Key? key, required this.questionId}) : super(key: key);

//   @override
//   _CreateAnswerScreenState createState() => _CreateAnswerScreenState();
// }

// class _CreateAnswerScreenState extends State<CreateAnswerScreen> {
//   final TextEditingController _answerTextController = TextEditingController();
//   bool _isCorrect = false;

//   void _createAnswer() async {
//     String answerText = _answerTextController.text.trim();
//     if (answerText.isNotEmpty && widget.questionId != 0) {
//       // Generate a unique ID for the answer
//       String answerId = Uuid().v4();

//       // Create a new Answer object
//       Answer newAnswer = Answer(
//         id: answerId, // Assign the generated UUID to the answer ID
//         answerText: answerText,
//         isCorrect: _isCorrect,
//         questionId: widget.questionId, // Use the passed questionId
//       );

//       // Save the answer to both SQLite and Firestore
//       SyncService().saveAnswerToSQLite(newAnswer);
//       SyncService().saveAnswerToFirestore(newAnswer);

//       // Show a confirmation message
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Answer created successfully')));

//       // Clear the text field
//       _answerTextController.clear();
//     } else {
//       // Show an error message if the answer text is empty or no question selected
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter an answer and select a question')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Answer'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: _answerTextController,
//               decoration: InputDecoration(labelText: 'Answer Text'),
//             ),
//             SizedBox(height: 16.0),
//             CheckboxListTile(
//               title: Text('Is Correct?'),
//               value: _isCorrect,
//               onChanged: (newValue) {
//                 setState(() {
//                   _isCorrect = newValue!;
//                 });
//               },
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _createAnswer,
//               child: Text('Create Answer'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:quizapp/answers_db.dart';
import 'package:quizapp/home.dart';
import 'package:quizapp/homescreen.dart';
import 'package:quizapp/question_db.dart';
import 'package:quizapp/savequestion.dart';
import 'package:quizapp/syncservices.dart';
import 'package:quizapp/model/syncModel.dart';
import 'package:uuid/uuid.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class CreateAnswerScreen extends StatefulWidget {
  final String questionId;
  final String quizId;

  const CreateAnswerScreen({Key? key, required this.questionId, required this.quizId}) : super(key: key);

  @override
  _CreateAnswerScreenState createState() => _CreateAnswerScreenState();
}

class _CreateAnswerScreenState extends State<CreateAnswerScreen> {
  final TextEditingController _answerTextController = TextEditingController();
  bool _isCorrect = false;
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

  void _createAnswer() async {
    String answerText = _answerTextController.text.trim();
    if (answerText.isNotEmpty && widget.questionId != '0') {
      // Generate a unique ID for the answer
      String answerId = Uuid().v4();

      // Create a new Answer object
      Answer newAnswer = Answer(
        id: answerId, // Assign the generated UUID to the answer ID
        answerText: answerText,
        isCorrect: _isCorrect,
        questionId: widget.questionId,
        quizId: widget.quizId,
      );

      // Save the answer locally or sync with Firestore based on connectivity
      if (isConnected) {
        SyncService().saveAnswerToFirestore(newAnswer);
        await SyncService().saveAnswerToSQLite(newAnswer);
        ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                        content: Text(
                          'Answer synced with Firestore',
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
                      
      } else {
        await SyncService().saveAnswerToSQLite(newAnswer);
        ScaffoldMessenger.of(context).showSnackBar(
        
                        SnackBar(
                        content: Text(
                          'Answer saved locally',
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
        await AnswerDB().setSyncStatus(answerId, 'unsynced');
      }
      ScaffoldMessenger.of(context).showSnackBar(
      
                                SnackBar(
                        content: Text(
                          'Answer created successfully',
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

      _answerTextController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                        content: Text(
                          'Please enter an answer and select a question',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Answer'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:120.0, left:16.0, right:16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _answerTextController,
                            decoration: InputDecoration(
                labelText: 'Answer Text',
                border: OutlineInputBorder(),
                hintText: 'Enter the Answer',
              ),
            ),
            
            SizedBox(height: 16.0),
            CheckboxListTile(
              title: Text('Is Correct?'),
              value: _isCorrect,
              onChanged: (newValue) {
                setState(() {
                  _isCorrect = newValue!;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _createAnswer,
              child: Text('Create Answer'),
            ),

                        SizedBox(height: 16.0),
ElevatedButton(
  onPressed: () {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => CreateQuestionScreen(quizId: widget.quizId),
      ),
    );
  },
  child: Text('Add another Question'),
),
                        SizedBox(height: 16.0),
// ElevatedButton(
//   onPressed: () {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(
//         builder: (context) => Home(),
//       ),
//     );
//   },
//   child: Text('Go to Home Page'),
// ),


            SizedBox(height: 16.0),
            Text(
              isConnected ? 'Connected' : 'Not Connected',
              style: TextStyle(
                fontSize: 18,
                color: isConnected ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
