// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart';
// import 'package:quizapp/syncservices.dart';

// class QuestionListScreen extends StatelessWidget {
//   final Quiz quiz;

//   const QuestionListScreen({Key? key, required this.quiz}) : super(key: key);

// @override
// Widget build(BuildContext context) {
//   return FutureBuilder<List<Question>>(
//     future: quiz.id != null ? SyncService().getAllQuestionsFromSQLiteForQuiz(quiz.id) : null,
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return CircularProgressIndicator();
//       } else if (snapshot.hasError) {
//         return Text('Error: ${snapshot.error}');
//       } else {
//         List<Question> questions = snapshot.data ?? [];
//         return Scaffold(
//           appBar: AppBar(
//             title: Text('Questions for ${quiz.quizName}'),
//           ),
//           body: ListView.builder(
//             itemCount: questions.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(questions[index].quizQuestion),
//               );
//             },
//           ),
//         );
//       }
//     },
//   );
// }
// }


// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart';
// import 'package:quizapp/syncservices.dart';

// class QuestionListScreen extends StatelessWidget {
//   final Quiz quiz;

//   const QuestionListScreen({Key? key, required this.quiz}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Question>>(
//       future: quiz.id != null ? SyncService().getAllQuestionsFromSQLiteForQuiz(quiz.id) : null,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           List<Question> questions = snapshot.data ?? [];
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Questions for ${quiz.quizName}'),
//             ),
//             body: ListView.builder(
//               itemCount: questions.length,
//               itemBuilder: (context, index) {
//                 Question question = questions[index];
//                 return ListTile(
//                   title: Text(question.quizQuestion),
//                   subtitle: FutureBuilder<List<Answer>>(
//                     future: SyncService().getAllAnswersForQuestion(question.id),
//                     builder: (context, answerSnapshot) {
//                       if (answerSnapshot.connectionState == ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       } else if (answerSnapshot.hasError) {
//                         return Text('Error: ${answerSnapshot.error}');
//                       } else {
//                         List<Answer> answers = answerSnapshot.data ?? [];
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Answers:'),
//                             Column(
//                               children: answers.map((answer) => Text(answer.answerText)).toList(),
//                             ),
//                           ],
//                         );
//                       }
//                     },
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart';
// import 'package:quizapp/syncservices.dart';

// class QuestionListScreen extends StatelessWidget {
//   final Quiz quiz;

//   const QuestionListScreen({Key? key, required this.quiz}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Question>>(
//       future: quiz.id != null ? SyncService().getAllQuestionsFromSQLiteForQuiz(quiz.id) : null,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           List<Question> questions = snapshot.data ?? [];
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Questions for ${quiz.quizName}'),
//             ),
//             body: ListView.builder(
//               itemCount: questions.length,
//               itemBuilder: (context, index) {
//                 Question question = questions[index];
//                 return ListTile(
//                   title: Text(question.quizQuestion),
//                   subtitle: FutureBuilder<List<Answer>>(
//                     future: SyncService().getAllAnswersForQuestion(question),
//                     builder: (context, answerSnapshot) {
//                       if (answerSnapshot.connectionState == ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       } else if (answerSnapshot.hasError) {
//                         return Text('Error: ${answerSnapshot.error}');
//                       } else {
//                         List<Answer> answers = answerSnapshot.data ?? [];
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Answers:'),
//                             Column(
//                               children: answers.map((answer) => Text(answer.answerText)).toList(),
//                             ),
//                           ],
//                         );
//                       }
//                     },
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//       },
//     );
//   }
// }

//original
// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart';
// import 'package:quizapp/syncservices.dart';
// import 'package:quizapp/model/user.dart';

// class QuestionListScreen extends StateWidget {
//   final Quiz quiz;
//   final Users user; 

//   const QuestionListScreen({Key? key, required this.quiz, required this.user}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Question>>(
//       future: quiz.id != null ? SyncService().getAllQuestionsFromSQLiteForQuiz(quiz.id) : null,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           List<Question> questions = snapshot.data ?? [];
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Questions for ${quiz.quizName}'),
//                       actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 20.0),
//             child: Text(user.email), 
//           ),
//         ],
//             ),
//             body: ListView.builder(
//               itemCount: questions.length,
//               itemBuilder: (context, index) {
//                 Question question = questions[index];
//                 return ListTile(
//                   title: Text(question.quizQuestion),
//                   subtitle: FutureBuilder<List<Answer>>(
//                     future: SyncService().getAllAnswersForQuestion(question.id),
//                     builder: (context, answerSnapshot) {
//                       if (answerSnapshot.connectionState == ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       } else if (answerSnapshot.hasError) {
//                         return Text('Error: ${answerSnapshot.error}');
//                       } else {
//                         List<Answer> answers = answerSnapshot.data ?? [];
//                         print('Answers for question ${question.id}: $answers');
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Answers:'),
//                             Column(
//                               children: answers.map((answer) => Text(answer.answerText)).toList(),
//                             ),
//                           ],
//                         );
//                       }
//                     },
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart';
// import 'package:quizapp/syncservices.dart';
// import 'package:quizapp/model/user.dart';

// class QuestionListScreen extends StatefulWidget {
//   final Quiz quiz;
//   final Users user;

//   const QuestionListScreen({Key? key, required this.quiz, required this.user}) : super(key: key);

//   @override
//   _QuestionListScreenState createState() => _QuestionListScreenState();
// }

// class _QuestionListScreenState extends State<QuestionListScreen> {
//   late Future<List<Question>> _questionsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _questionsFuture = widget.quiz.id != null ? SyncService().getAllQuestionsFromSQLiteForQuiz(widget.quiz.id!) : Future.value([]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Question>>(
//       future: _questionsFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           List<Question> questions = snapshot.data ?? [];
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Questions for ${widget.quiz.quizName}'),
//               actions: [
//                 Padding(
//                   padding: EdgeInsets.only(right: 20.0),
//                   child: Text(widget.user.email),
//                 ),
//               ],
//             ),
//             body: ListView.builder(
//               itemCount: questions.length,
//               itemBuilder: (context, index) {
//                 Question question = questions[index];
//                 return ListTile(
//                   title: Text(question.quizQuestion),
//                   subtitle: FutureBuilder<List<Answer>>(
//                     future: SyncService().getAllAnswersForQuestion(question.id),
//                     builder: (context, answerSnapshot) {
//                       if (answerSnapshot.connectionState == ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       } else if (answerSnapshot.hasError) {
//                         return Text('Error: ${answerSnapshot.error}');
//                       } else {
//                         List<Answer> answers = answerSnapshot.data ?? [];
//                         print('Answers for question ${question.id}: $answers');
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Answers:'),
//                             Column(
//                               children: answers.map((answer) => Text(answer.answerText)).toList(),
//                             ),
//                           ],
//                         );
//                       }
//                     },
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//       },
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:navigations/model/syncModel.dart';
// import 'package:navigations/syncservices.dart';
// import 'package:navigations/model/user.dart';
// import 'package:navigations/model/userAnswer.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:navigations/user_answer.dart';
// import 'package:uuid/uuid.dart';
// import 'dart:async';

// import 'package:internet_connection_checker/internet_connection_checker.dart';
// class QuestionListScreen extends StatefulWidget {
//   final Quiz quiz;
//   final Users user;

//   const QuestionListScreen({Key? key, required this.quiz, required this.user}) : super(key: key);

//   @override
//   _QuestionListScreenState createState() => _QuestionListScreenState();
// }

// class _QuestionListScreenState extends State<QuestionListScreen> {
//   late Future<List<Question>> _questionsFuture;
//   late List<List<Answer>> _answersList;
//   late List<String?> _selectedAnswers;
//   late int _countdownDuration;
//   late Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     _questionsFuture = widget.quiz.id != null
//         ? SyncService().getAllQuestionsFromSQLiteForQuiz(widget.quiz.id!)
//         : Future.value([]);
//     _answersList = [];
//     _selectedAnswers = [];
//     _countdownDuration = widget.quiz.minutesToComplete * 60; // Convert minutes to seconds
//     _startTimer();
//   }

//   @override
//   void dispose() {
//     _timer.cancel(); // Cancel the timer to avoid memory leaks
//     super.dispose();
//   }

// void _startTimer() async {
//   List<Question> questions = await _questionsFuture;
//   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//     setState(() {
//       if (_countdownDuration > 0) {
//         _countdownDuration--;
//       } else {
//         _timer.cancel();
//         _handleSubmitQuiz(questions, _answersList, _selectedAnswers);
//         Navigator.pop(context);
//       }
//     });
//   });
// }


//   @override
//   Widget build(BuildContext context) {

//       String minutes = (_countdownDuration ~/ 60).toString().padLeft(2, '0');
//   String seconds = (_countdownDuration % 60).toString().padLeft(2, '0');
//     return FutureBuilder<List<Question>>(
//       future: _questionsFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           List<Question> questions = snapshot.data ?? [];
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Questions for ${widget.quiz.quizName}'),
//               actions: [
//                 Padding(
//                   padding: EdgeInsets.only(right: 20.0),
//                   child: Text(widget.user.email),
//                 ),
//               ],
//             ),
//     body: Column(
//       children: [
//         Text('Remaining Time: $minutes:$seconds'), // Display remaining time
//         Expanded(
//           child: ListView.builder(
//             itemCount: questions.length,
//             itemBuilder: (context, index) {
//               Question question = questions[index];
//               return ListTile(
//                 title: Text(question.quizQuestion),
//                 subtitle: FutureBuilder<List<Answer>>(
//                   future: SyncService().getAllAnswersForQuestion(question.id),
//                   builder: (context, answerSnapshot) {
//                     if (answerSnapshot.connectionState == ConnectionState.waiting) {
//                       return CircularProgressIndicator();
//                     } else if (answerSnapshot.hasError) {
//                       return Text('Error: ${answerSnapshot.error}');
//                     } else {
//                       List<Answer> answers = answerSnapshot.data ?? [];
//                       _answersList.add(answers);
//                       _selectedAnswers.add(null);
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Answers:'),
//                           Column(
//                             children: answers.map((answer) => RadioListTile<String?>(
//                               title: Text(answer.answerText),
//                               value: answer.id,
//                               groupValue: _selectedAnswers[index],
//                               onChanged: (value) {
//                                 setState(() {
//                                   _selectedAnswers[index] = value;
//                                 });
//                               },
//                             )).toList(),
//                           ),
//                         ],
//                       );
//                     }
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     ),

// floatingActionButton: FloatingActionButton(
//   onPressed: () {
//     _handleSubmitQuiz(questions, _answersList, _selectedAnswers);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           'Answer saved',
//           style: TextStyle(fontSize: 16.0),
//         ),
//         duration: Duration(seconds: 3),
//       ),
//     );
//   },
//   child: Icon(Icons.check),
// ),

//           );
//         }
//       },
//     );
//   }



// void _handleSubmitQuiz(List<Question> questions, List<List<Answer>> answersList, List<String?> selectedAnswers) async {
//   bool isConnected = await InternetConnectionChecker().hasConnection;
  
//   if (isConnected) {
//     for (int i = 0; i < questions.length; i++) {
//       String? selectedAnswerId = selectedAnswers[i];
//       if (selectedAnswerId != null) {
//         UserAnswer userAnswer = UserAnswer(
//           id: Uuid().v4(), // Generate a unique ID using Uuid
//           user_email: widget.user.email,
//           quizId: widget.quiz.id!,
//           questionId: questions[i].id,
//           answerId: selectedAnswerId,
//           isCorrect: answersList[i].any((answer) => answer.id == selectedAnswerId && answer.isCorrect),
//         );
        
//         // Save user answer to Firestore
//         await SyncService().saveUserAnswerToFirestore(userAnswer);
        
//         // Save user answer to SQLite and set sync status to "unsynced"
//         await SyncService().saveUserAnswerToSQLite(userAnswer);
//         await UserAnswerDB().setSyncStatus(userAnswer.id, 'unsynced');
//       }
//     }
//   } else {
//     // Handle offline state
//     for (int i = 0; i < questions.length; i++) {
//       String? selectedAnswerId = selectedAnswers[i];
//       if (selectedAnswerId != null) {
//         UserAnswer userAnswer = UserAnswer(
//           id: Uuid().v4(), // Generate a unique ID using Uuid
//           user_email: widget.user.email,
//           quizId: widget.quiz.id!,
//           questionId: questions[i].id,
//           answerId: selectedAnswerId,
//           isCorrect: answersList[i].any((answer) => answer.id == selectedAnswerId && answer.isCorrect),
//         );

//         // Save user answer to SQLite directly
//         await UserAnswerDB().createUserAnswer(
//           id: userAnswer.id,
//           user_email: userAnswer.user_email,
//           quizId: userAnswer.quizId,
//           questionId: userAnswer.questionId,
//           answerId: userAnswer.answerId,
//           isCorrect: userAnswer.isCorrect,
//         );

//         // Set sync status to "unsynced" for the locally saved user answer
//         await UserAnswerDB().setSyncStatus(userAnswer.id, 'unsynced');
//       }
//     }

//     // Show a message or take appropriate action when there is no internet connection
//     // For example:
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           'No internet connection. User answers saved locally.',
//           style: TextStyle(fontSize: 16.0, color: Colors.white),
//         ),
//         backgroundColor: Colors.red, // You can use a different color to indicate offline state
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:quizapp/home.dart';
import 'package:quizapp/model/syncModel.dart';
import 'package:quizapp/syncservices.dart';
import 'package:quizapp/model/user.dart';
import 'package:quizapp/model/userAnswer.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quizapp/user_answer.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

class QuestionListScreen extends StatefulWidget {
  final Quiz quiz;
  final Users user;

  const QuestionListScreen({Key? key, required this.quiz, required this.user})
      : super(key: key);

  @override
  _QuestionListScreenState createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  late Future<List<Question>> _questionsFuture;
  List<List<Answer>> _answersList = [];
  List<String?> _selectedAnswers = [];
  late PageController _pageController;
  late int _currentIndex;
  late int _countdownDuration;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _pageController = PageController(initialPage: _currentIndex);
    _questionsFuture = widget.quiz.id != null
        ? SyncService().getAllQuestionsFromSQLiteForQuiz(widget.quiz.id!)
        : Future.value([]);

    _countdownDuration = widget.quiz.minutesToComplete * 60;
    _startTimer();
  }

  void _startTimer() async {
    List<Question> questions = await _questionsFuture;
    _answersList = List.generate(questions.length, (_) => <Answer>[]);
    _selectedAnswers = List.generate(questions.length, (_) => null);
    _countdownDuration = widget.quiz.minutesToComplete * 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _countdownDuration--;
      if (_countdownDuration <= 0) {
        _timer.cancel();
        _handleSubmitQuiz(questions, _answersList, _selectedAnswers);
        Navigator.pop(context);
      }
    });
  }

  void _handleSubmitQuiz(List<Question> questions, List<List<Answer>> answersList,
      List<String?> selectedAnswers) async {
    bool isConnected = await InternetConnectionChecker().hasConnection;

    if (isConnected) {
      for (int i = 0; i < questions.length; i++) {
        String? selectedAnswerId = selectedAnswers[i];
        if (selectedAnswerId != null) {
          UserAnswer userAnswer = UserAnswer(
            id: Uuid().v4(),
            user_email: widget.user.email,
            quizId: widget.quiz.id!,
            questionId: questions[i].id,
            answerId: selectedAnswerId,
            isCorrect: answersList[i].any((answer) =>
                answer.id == selectedAnswerId && answer.isCorrect),
          );

          await SyncService().saveUserAnswerToFirestore(userAnswer);
          await SyncService().saveUserAnswerToSQLite(userAnswer);
          await UserAnswerDB().setSyncStatus(userAnswer.id, 'unsynced');
        } else {
          UserAnswer userAnswer = UserAnswer(
            id: Uuid().v4(),
            user_email: widget.user.email,
            quizId: widget.quiz.id!,
            questionId: questions[i].id,
            answerId: '',
            isCorrect: false,
          );

          await SyncService().saveUserAnswerToFirestore(userAnswer);
          await SyncService().saveUserAnswerToSQLite(userAnswer);
          await UserAnswerDB().setSyncStatus(userAnswer.id, 'unsynced');
        }
      }
    } else {

      for (int i = 0; i < questions.length; i++) {
        String? selectedAnswerId = selectedAnswers[i];
        if (selectedAnswerId != null) {
          UserAnswer userAnswer = UserAnswer(
            id: Uuid().v4(),
            user_email: widget.user.email,
            quizId: widget.quiz.id!,
            questionId: questions[i].id,
            answerId: selectedAnswerId,
            isCorrect: answersList[i].any((answer) =>
                answer.id == selectedAnswerId && answer.isCorrect),
          );
          await UserAnswerDB().createUserAnswer(
            id: userAnswer.id,
            user_email: userAnswer.user_email,
            quizId: userAnswer.quizId,
            questionId: userAnswer.questionId,
            answerId: userAnswer.answerId,
            isCorrect: userAnswer.isCorrect,
          );
          await UserAnswerDB().setSyncStatus(userAnswer.id, 'unsynced');
        } else {
          UserAnswer userAnswer = UserAnswer(
            id: Uuid().v4(),
            user_email: widget.user.email,
            quizId: widget.quiz.id!,
            questionId: questions[i].id,
            answerId: '',
            isCorrect: false,
          );
          await UserAnswerDB().createUserAnswer(
            id: userAnswer.id,
            user_email: userAnswer.user_email,
            quizId: userAnswer.quizId,
            questionId: userAnswer.questionId,
            answerId: userAnswer.answerId,
            isCorrect: userAnswer.isCorrect,
          );
          await UserAnswerDB().setSyncStatus(userAnswer.id, 'unsynced');
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No internet connection. User answers saved locally.',
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _handleNextQuestion() {
    if (_currentIndex < _answersList.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      setState(() {
        _currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Question>>(
      future: _questionsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Question> questions = snapshot.data ?? [];

          return Scaffold(
            appBar: AppBar(
              title: Text('Questions for ${widget.quiz.quizName}'),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Text(widget.user.email),
                ),
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TimerDisplay(countdownDuration: _countdownDuration),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      Question question = questions[index];
                      return _buildQuestionPage(question, index);
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _handleNextQuestion,
              child: Icon(Icons.arrow_forward),
            ),
          );
        }
      },
    );
  }

Widget _buildQuestionPage(Question question, int index) {
  bool isLastQuestion = index == _answersList.length - 1;

  return Card(
    margin: EdgeInsets.all(16.0),
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${index + 1}: ${question.quizQuestion}',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 16.0),
          FutureBuilder<List<Answer>>(
            future: SyncService().getAllAnswersForQuestion(question.id),
            builder: (context, answerSnapshot) {
              if (answerSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (answerSnapshot.hasError) {
                return Text('Error: ${answerSnapshot.error}');
              } else {
                List<Answer> answers = answerSnapshot.data ?? [];
                _answersList[index] = answers;
                return Column(
                  children: [
                    ...answers.map((answer) {
                      return RadioListTile<String?>(
                        title: Text(answer.answerText),
                        value: answer.id,
                        groupValue: _selectedAnswers[index],
                        onChanged: (value) {
                          setState(() {
                            _selectedAnswers[index] = value;
                          });
                        },
                      );
                    }).toList(),
                    if (isLastQuestion)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            List<Question> questions = await _questionsFuture;
                            _handleSubmitQuiz(
                                questions, _answersList, _selectedAnswers);

                              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home(user :widget.user!)),
                );
                          },
                          child: Text('Submit'),
                        ),
                      ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    ),
  );
}
  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }
}

class TimerDisplay extends StatefulWidget {
  final int countdownDuration;

  const TimerDisplay({Key? key, required this.countdownDuration})
      : super(key: key);

  @override
  _TimerDisplayState createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay> {
  late Timer _timer;
  late int _remainingDuration;

  @override
  void initState() {
    super.initState();
    _remainingDuration = widget.countdownDuration;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_remainingDuration > 0) {
        setState(() {
          _remainingDuration--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String minutes = (_remainingDuration ~/ 60).toString().padLeft(2, '0');
    String seconds = (_remainingDuration % 60).toString().padLeft(2, '0');

    return Text(
      'Remaining Time: $minutes:$seconds',
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}


// void _handleSubmitQuiz(List<Question> questions, List<List<Answer>> answersList, List<String?> selectedAnswers) async {
//   bool isConnected = await InternetConnectionChecker().hasConnection;
  
//   if (isConnected) {
//     for (int i = 0; i < questions.length; i++) {
//       String? selectedAnswerId = selectedAnswers[i];
//       if (selectedAnswerId != null) {
//         UserAnswer userAnswer = UserAnswer(
//           id: Uuid().v4(), // Generate a unique ID using Uuid
//           user_email: widget.user.email,
//           quizId: widget.quiz.id!,
//           questionId: questions[i].id,
//           answerId: selectedAnswerId,
//           isCorrect: answersList[i].any((answer) => answer.id == selectedAnswerId && answer.isCorrect),
//         );
        
//         // Save user answer to Firestore
//         await SyncService().saveUserAnswerToFirestore(userAnswer);
        
//         // Save user answer to SQLite and set sync status to "unsynced"
//         await SyncService().saveUserAnswerToSQLite(userAnswer);
//         await UserAnswerDB().setSyncStatus(userAnswer.id, 'unsynced');
//       }
//     }
//   } else {
//     // Handle offline state
//     for (int i = 0; i < questions.length; i++) {
//       String? selectedAnswerId = selectedAnswers[i];
//       if (selectedAnswerId != null) {
//         UserAnswer userAnswer = UserAnswer(
//           id: Uuid().v4(), // Generate a unique ID using Uuid
//           user_email: widget.user.email,
//           quizId: widget.quiz.id!,
//           questionId: questions[i].id,
//           answerId: selectedAnswerId,
//           isCorrect: answersList[i].any((answer) => answer.id == selectedAnswerId && answer.isCorrect),
//         );

//         // Save user answer to SQLite directly
//         await UserAnswerDB().createUserAnswer(
//           id: userAnswer.id,
//           user_email: userAnswer.user_email,
//           quizId: userAnswer.quizId,
//           questionId: userAnswer.questionId,
//           answerId: userAnswer.answerId,
//           isCorrect: userAnswer.isCorrect,
//         );

//         // Set sync status to "unsynced" for the locally saved user answer
//         await UserAnswerDB().setSyncStatus(userAnswer.id, 'unsynced');
//       }
//     }

//     // Show a message or take appropriate action when there is no internet connection
//     // For example:
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           'No internet connection. User answers saved locally.',
//           style: TextStyle(fontSize: 16.0, color: Colors.white),
//         ),
//         backgroundColor: Colors.red, // You can use a different color to indicate offline state
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }
// }


// void _handleSubmitQuiz(List<Question> questions, List<List<Answer>> answersList, List<String?> selectedAnswers) async {
//   for (int i = 0; i < questions.length; i++) {
//     String? selectedAnswerId = selectedAnswers[i];
//     if (selectedAnswerId != null) {
//       UserAnswer userAnswer = UserAnswer(
//         id: UniqueKey().toString(),
//         user_email: widget.user.email,
//         quizId: widget.quiz.id!,
//         questionId: questions[i].id,
//         answerId: selectedAnswerId,
//         isCorrect: answersList[i].any((answer) => answer.id == selectedAnswerId && answer.isCorrect),
//       );
      
//       await SyncService().saveUserAnswerToFirestore(userAnswer);
//       await SyncService().saveUserAnswerToSQLite(userAnswer);
//     }
//   }
// }



// void _handleSubmitQuiz(List<Question> questions, List<List<Answer>> answersList, List<String?> selectedAnswers) async {
//   for (int i = 0; i < questions.length; i++) {
//     String? selectedAnswerId = selectedAnswers[i];
//     if (selectedAnswerId != null) {
//       UserAnswer userAnswer = UserAnswer(
//         id: Uuid().v4(),
//         user_email: widget.user.email,
//         quizId: widget.quiz.id!,
//         questionId: questions[i].id,
//         answerId: selectedAnswerId,
//         isCorrect: answersList[i].any((answer) => answer.id == selectedAnswerId && answer.isCorrect),
//       );

//       bool isConnected = await InternetConnectionChecker().hasConnection;
//       if (isConnected) {
//         try {
//           await SyncService().saveUserAnswerToFirestore(userAnswer);
//         } catch (error) {
//           print('Error saving user answer to Firestore: $error');
//         }
//       } else {
//         try {
//           await SyncService().saveUserAnswerToSQLite(userAnswer);
//           await UserAnswerDB().setSyncStatus(userAnswer.id, 'unsynced');
//         } catch (error) {
//           print('Error saving user answer locally: $error');
//         }
//       }
//     }
//   }
// }

// }




//   void _handleSubmitQuiz(List<Question> questions, List<List<Answer>> answersList, List<String?> selectedAnswers) async {
//     List<UserAnswer> userAnswers = [];
//     for (int i = 0; i < questions.length; i++) {
//       String? selectedAnswerId = selectedAnswers[i];
//       if (selectedAnswerId != null) {
//         userAnswers.add(UserAnswer(
//           id: UniqueKey().toString(),
//           user_email: widget.user.email,
//           quizId: widget.quiz.id!,
//           questionId: questions[i].id,
//           answerId: selectedAnswerId,
//           isCorrect: answersList[i].any((answer) => answer.id == selectedAnswerId && answer.isCorrect),
//         ));
//       }
//     }

// }

// class _QuestionListScreenState extends State<QuestionListScreen> {
//   late Future<List<Question>> _questionsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _questionsFuture = widget.quiz.id != null ? SyncService().getAllQuestionsFromSQLiteForQuiz(widget.quiz.id!) : Future.value([]);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Question>>(
//       future: _questionsFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           List<Question> questions = snapshot.data ?? [];
//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Questions for ${widget.quiz.quizName}'),
//               actions: [
//                 Padding(
//                   padding: EdgeInsets.only(right: 20.0),
//                   child: Text(widget.user.email),
//                 ),
//               ],
//             ),
//             body: ListView.builder(
//               itemCount: questions.length,
//               itemBuilder: (context, index) {
//                 Question question = questions[index];
//                 return ListTile(
//                   title: Text(question.quizQuestion),
//                   subtitle: FutureBuilder<List<Answer>>(
//                     future: SyncService().getAllAnswersForQuestion(question.id),
//                     builder: (context, answerSnapshot) {
//                       if (answerSnapshot.connectionState == ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       } else if (answerSnapshot.hasError) {
//                         return Text('Error: ${answerSnapshot.error}');
//                       } else {
//                         List<Answer> answers = answerSnapshot.data ?? [];
//                         print('Answers for question ${question.id}: $answers');
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Answers:'),
//                             Column(
//                               children: answers.map((answer) => ElevatedButton(
//                                 onPressed: () {
//                                   _handleAnswer(question.id, answer);
//                                 },
//                                 child: Text(answer.answerText),
//                               )).toList(),
//                             ),
//                           ],
//                         );
//                       }
//                     },
//                   ),
//                 );
//               },
//             ),
//           );
//         }
//       },
//     );
//   }

// void _handleAnswer(String questionId, Answer answer) async {
//   bool isCorrect = answer.isCorrect;

//   await SyncService().saveUserAnswer(
//     UserAnswer(
//       id: UniqueKey().toString(),
//       user_email: widget.user.email,
//       quizId: widget.quiz.id!,
//       questionId: questionId,
//       answerId: answer.id,
//       isCorrect: isCorrect,
//     ),
//   );
// }
// }



// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart';
// import 'package:quizapp/syncservices.dart';

// class QuestionListScreen extends StatelessWidget {
//   final Quiz quiz;

//   const QuestionListScreen({Key? key, required this.quiz}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Question>>(
//       future: SyncService().getAllQuestionsFromSQLiteForQuiz(quiz.id),
//       builder: (context, questionSnapshot) {
//         if (questionSnapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (questionSnapshot.hasError) {
//           return Center(child: Text('Error: ${questionSnapshot.error}'));
//         } else {
//           List<Question> questions = questionSnapshot.data ?? [];

//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Questions for ${quiz.quizName}'),
//             ),
//             body: ListView.builder(
//               itemCount: questions.length,
//               itemBuilder: (context, index) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ListTile(
//                       title: Text(questions[index].quizQuestion),
//                     ),
//                     FutureBuilder<List<Answer>>(
//                       future: SyncService().getAllAnswersForQuestion(questions[index].id),
//                       builder: (context, answerSnapshot) {
//                         if (answerSnapshot.connectionState == ConnectionState.waiting) {
//                           return CircularProgressIndicator();
//                         } else if (answerSnapshot.hasError) {
//                           return Text('Error: ${answerSnapshot.error}');
//                         } else {
//                           List<Answer> answers = answerSnapshot.data ?? [];

//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: answers.map((answer) {
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                                 child: ListTile(
//                                   title: Text(answer.answerText),
//                                   subtitle: Text('Is Correct: ${answer.isCorrect}'),
//                                 ),
//                               );
//                             }).toList(),
//                           );
//                         }
//                       },
//                     ),
//                     Divider(),
//                   ],
//                 );
//               },
//             ),
//           );
//         }
//       },
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart';
// import 'package:quizapp/syncservices.dart';
// import 'package:quizapp/model/user.dart'; // Import the User model class

// class QuestionListScreen extends StatelessWidget {
//   final Quiz quiz;
//   final Users user; // Add this line

//   const QuestionListScreen({Key? key, required this.quiz, required this.user}) : super(key: key); // Modify the constructor

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Question>>(
//       future: SyncService().getAllQuestionsFromSQLiteForQuiz(quiz.id),
//       builder: (context, questionSnapshot) {
//         if (questionSnapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (questionSnapshot.hasError) {
//           return Center(child: Text('Error: ${questionSnapshot.error}'));
//         } else {
//           List<Question> questions = questionSnapshot.data ?? [];

//           return Scaffold(
//             appBar: AppBar(
//               title: Text('Questions for ${quiz.quizName}'),
//             ),
//             body: ListView.builder(
//               itemCount: questions.length,
//               itemBuilder: (context, index) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ListTile(
//                       title: Text(questions[index].quizQuestion),
//                     ),
//                     FutureBuilder<List<Answer>>(
//                       future: SyncService().getAllAnswersForQuestion(questions[index].id),
//                       builder: (context, answerSnapshot) {
//                         if (answerSnapshot.connectionState == ConnectionState.waiting) {
//                           return CircularProgressIndicator();
//                         } else if (answerSnapshot.hasError) {
//                           return Text('Error: ${answerSnapshot.error}');
//                         } else {
//                           List<Answer> answers = answerSnapshot.data ?? [];

//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: answers.map((answer) {
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                                 child: ListTile(
//                                   title: Text(answer.answerText),
//                                   subtitle: Text('Is Correct: ${answer.isCorrect}'),
//                                 ),
//                               );
//                             }).toList(),
//                           );
//                         }
//                       },
//                     ),
//                     Divider(),
//                   ],
//                 );
//               },
//             ),
//           );
//         }
//       },
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart';
// import 'package:quizapp/syncservices.dart';
// import 'package:quizapp/model/user.dart';

// class QuestionListScreen extends StatefulWidget {
//   final Users user;
//   final Quiz quiz;

//   const QuestionListScreen({Key? key, required this.user, required this.quiz}) : super(key: key);

//   @override
//   _QuestionListScreenState createState() => _QuestionListScreenState();
// }

// class _QuestionListScreenState extends State<QuestionListScreen> {
//   late Future<List<Question>> _questionsFuture;
//   int _currentPageIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     // _questionsFuture = SyncService().getAllQuestionsFromSQLiteForQuiz(widget.quiz.id);
//     _questionsFuture = SyncService().getAllQuestionsFromSQLiteForQuiz(widget.quiz);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Questions for ${widget.quiz.quizName}'),
//                         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 20.0),
//             child: Text(widget.user.email), 
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<Question>>(
//         future: _questionsFuture,
//         builder: (context, questionSnapshot) {
//           if (questionSnapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (questionSnapshot.hasError) {
//             return Center(child: Text('Error: ${questionSnapshot.error}'));
//           } else {
//             List<Question> questions = questionSnapshot.data ?? [];
//             Question currentQuestion = questions[_currentPageIndex];

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Text(
//                     currentQuestion.quizQuestion,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: FutureBuilder<List<Answer>>(
//                     future: SyncService().getAllAnswersForQuestion(currentQuestion.quizQuestion),
//                     builder: (context, answerSnapshot) {
//                       if (answerSnapshot.connectionState == ConnectionState.waiting) {
//                         return Center(child: CircularProgressIndicator());
//                       } else if (answerSnapshot.hasError) {
//                         return Text('Error: ${answerSnapshot.error}');
//                       } else {
//                         List<Answer> answers = answerSnapshot.data ?? [];

//                         return ListView.builder(
//                           itemCount: answers.length,
//                           itemBuilder: (context, index) {
//                             Answer answer = answers[index];
//                             return ListTile(
//                               title: Text(answer.answerText),
//                               subtitle: Text('Is Correct: ${answer.isCorrect}'),
//                               onTap: () {
//                                 // Handle answer selection
//                               },
//                             );
//                           },
//                         );
//                       }
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_currentPageIndex < questions.length - 1) {
//                         setState(() {
//                           _currentPageIndex++;
//                         });
//                       } else {
//                         // Finish the quiz
//                       }
//                     },
//                     child: Text(_currentPageIndex == questions.length - 1 ? 'Finish' : 'Next'),
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }
