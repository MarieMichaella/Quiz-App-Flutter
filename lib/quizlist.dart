// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart';
// import 'package:quizapp/syncservices.dart';

// class QuizListScreen extends StatefulWidget {
//   @override
//   _QuizListScreenState createState() => _QuizListScreenState();
// }

// class _QuizListScreenState extends State<QuizListScreen> {
//   late Future<List<Quiz>> _quizListFuture;

//   @override
//   void initState() {
//     super.initState();
//     _quizListFuture = _loadQuizList();
//   }

//   Future<List<Quiz>> _loadQuizList() async {
//     // Fetch quiz list from SQLite or Firestore
//     return SyncService().getAllQuizzesFromSQLite(); // Or from Firestore
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz List'),
//       ),
//       body: FutureBuilder<List<Quiz>>(
//         future: _quizListFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final List<Quiz> quizList = snapshot.data!;
//             return GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16.0,
//                 mainAxisSpacing: 16.0,
//               ),
//               itemCount: quizList.length,
//               itemBuilder: (context, index) {
//                 final quiz = quizList[index];
//                 return InkWell(
//                   onTap: () {
//                     // Handle quiz tile tap
//                   },
//                   child: Card(
//                     elevation: 2.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           quiz.quizName,
//                           style: TextStyle(fontSize: 18.0),
//                           textAlign: TextAlign.center,
//                         ),
//                         SizedBox(height: 8.0),
//                         Text(
//                           quiz.quiz_description,
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else {
//             return Center(child: Text('No quizzes found'));
//           }
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart'; // Import your Quiz and Question model classes
// import 'package:quizapp/syncservices.dart'; // Import your SyncService class

// class QuizListScreen extends StatefulWidget {
//   @override
//   _QuizListScreenState createState() => _QuizListScreenState();
// }

// class _QuizListScreenState extends State<QuizListScreen> {
//   List<Quiz> _quizzes = [];
//   List<Question> _questions = [];
//   int? _selectedQuizId;

//   @override
//   void initState() {
//     super.initState();
//     _loadQuizzes();
//     _loadQuestions();
//   }

//   Future<void> _loadQuizzes() async {
//     _quizzes = await SyncService().getAllQuizzesFromSQLite(); // Fetch quizzes from SQLite
//     setState(() {});
//   }

//   Future<void> _loadQuestions() async {
//     _questions = await SyncService().getAllQuestionsFromSQLite(); // Fetch questions from SQLite
//     setState(() {});
//   }

//   void _onQuizSelected(int quizId) {
//     setState(() {
//       _selectedQuizId = quizId;
//     });
//   }

//   List<Question> _filterQuestionsByQuizId(int quizId) {
//     return _questions.where((question) => question.quizId == quizId).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz List'),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Display list of quizzes
//           Expanded(
//             child: ListView.builder(
//               itemCount: _quizzes.length,
//               itemBuilder: (context, index) {
//                 final quiz = _quizzes[index];
//                 return ListTile(
//                   title: Text(quiz.quizName),
//                   onTap: () => _onQuizSelected(quiz.id),
//                 );
//               },
//             ),
//           ),
//           Divider(),
//           // Display filtered questions based on selected quiz
//           Expanded(
//             child: ListView.builder(
//               itemCount: _selectedQuizId != null ? _filterQuestionsByQuizId(_selectedQuizId!).length : 0,
//               itemBuilder: (context, index) {
//                 final question = _filterQuestionsByQuizId(_selectedQuizId!)[index];
//                 return ListTile(
//                   title: Text(question.quizQuestion),
//                   // Add more details if needed
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:quizapp/model/syncModel.dart';
import 'package:quizapp/questionList.dart';
import 'package:quizapp/syncservices.dart';
import 'package:quizapp/model/user.dart';
import 'package:quizapp/user_answer.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class QuizListScreen extends StatefulWidget {
  final Users user;

  const QuizListScreen({required this.user});

  @override
  _QuizListScreenState createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {
  late Future<List<Quiz>> quizzes;
  late UserAnswerDB _userAnswerDB;

  @override
  void initState() {
    super.initState();
    quizzes = _loadQuizzes();
    _userAnswerDB = UserAnswerDB();
    checkForUncompletedQuizzes();
  }

  Future<List<Quiz>> _loadQuizzes() async {
    return SyncService().getAllQuizzesFromSQLite();
  }

  Future<void> checkForUncompletedQuizzes() async {
    List<Quiz> allQuizzes = await _loadQuizzes();
    List<Quiz> uncompletedQuizzes = [];

    for (Quiz quiz in allQuizzes) {
      bool isQuizDone = await _userAnswerDB.isQuizDone(widget.user.email, quiz.id);
      if (!isQuizDone) {
        uncompletedQuizzes.add(quiz);
      }
    }

    if (uncompletedQuizzes.isNotEmpty) {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: 'Uncompleted Quizzes',
          body: 'You have ${uncompletedQuizzes.length} uncompleted quiz(zes).',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quizzes'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Text(widget.user.email),
          ),
        ],
      ),
      body: FutureBuilder<List<Quiz>>(
        future: quizzes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Quiz> quizzes = snapshot.data ?? [];
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                final Quiz quiz = quizzes[index];
                return FutureBuilder<bool>(
                  future: _userAnswerDB.isQuizDone(widget.user.email, quiz.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final bool isQuizDone = snapshot.data ?? false;
                      return InkWell(
  onTap: () async {
    final isQuizDone = await _userAnswerDB.isQuizDone(widget.user.email, quiz.id);
    if (!isQuizDone) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuestionListScreen(quiz: quiz, user: widget.user),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Quiz Completed'),
          content: Text('You have already completed this quiz.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  },
  child: Card(
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            quiz.quizName,
            style: TextStyle(
              color: isQuizDone ? Colors.grey : Colors.black,
              fontWeight: isQuizDone ? FontWeight.normal : FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 10),
          if (isQuizDone)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.done, color: Colors.green),
                SizedBox(width: 5),
                Text('Done', style: TextStyle(color: Colors.green)),
              ],
            ),
        ],
      ),
    ),
  ),
);
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

// class _QuizListScreenState extends State<QuizListScreen> {
//   late List<Quiz> quizzes;

//   @override
//   void initState() {
//     super.initState();
//     _loadQuizzes();
//   }

//   Future<void> _loadQuizzes() async {
//     quizzes = await SyncService().getAllQuizzesFromSQLite();
//     setState(() {}); // Update the UI with the fetched quizzes
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quizzes'),

//                 actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 20.0),
//             child: Text(widget.user.email), 
//           ),
//         ],
//       ),
      
//       body: quizzes.isEmpty
//           ? Center(child: CircularProgressIndicator()) 
//           : GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // Two quizzes per row
//                 crossAxisSpacing: 10.0,
//                 mainAxisSpacing: 10.0,
//               ),
//               itemCount: quizzes.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
// onTap: () {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       // builder: (context) => QuestionListScreen(quiz: quizzes[index], user: widget.user),
//       builder: (context) => QuestionListScreen(quiz: quizzes[index]),
//     ),
//   );
// },

//                   child: Card(
//                     child: Center(
//                       child: Text(quizzes[index].quizName),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }