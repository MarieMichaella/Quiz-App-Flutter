// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart';
// import 'package:quizapp/syncservices.dart';

// class QuizListPage extends StatelessWidget {
//   final SyncService syncService = SyncService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz List'),
//       ),
//       body: FutureBuilder<List<Quiz>>(
//         future: syncService.getAllQuizzesFromSQLite(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No quizzes available.'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final quiz = snapshot.data![index];
//                 return ListTile(
//                   title: Text(quiz.quizName),
//                   subtitle: Text(quiz.quiz_description),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () async {
//                       // Call the delete method from SyncService
//                       await syncService.deleteQuizAndRelatedData(quiz.id);
//                       // Refresh the quiz list after deletion
//                       setState(() {});
//                     },
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:navigations/model/syncModel.dart';
// import 'package:navigations/syncservices.dart';

// class QuizListPage extends StatefulWidget {
//   @override
//   _QuizListPageState createState() => _QuizListPageState();
// }

// class _QuizListPageState extends State<QuizListPage> {
//   final SyncService syncService = SyncService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz List'),
//       ),
//       body: FutureBuilder<List<Quiz>>(
//         future: syncService.getAllQuizzesFromSQLite(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No quizzes available.'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final quiz = snapshot.data![index];
//                 return ListTile(
//                   title: Text(quiz.quizName),
//                   subtitle: Text(quiz.quiz_description),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () async {
//                       // Call the delete method from SyncService
//                       await syncService.deleteQuizAndRelatedData(quiz.id);
//                       // Refresh the quiz list after deletion
//                       setState(() {}); // Use setState to update the UI
//                     },
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:navigations/model/syncModel.dart';
// import 'package:navigations/syncservices.dart';
// import 'package:navigations/quiz_db.dart';
// import 'package:navigations/question_db.dart';
// import 'package:navigations/answers_db.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// class QuizListPage extends StatefulWidget {
//   @override
//   _QuizListPageState createState() => _QuizListPageState();
// }

// class _QuizListPageState extends State<QuizListPage> {
//   final SyncService syncService = SyncService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quiz List'),
//       ),
//       body: FutureBuilder<List<Quiz>>(
//         future: syncService.getAllQuizzesFromSQLite(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No quizzes available.'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final quiz = snapshot.data![index];
//                 return ListTile(
//                   title: Text(quiz.quizName),
//                   subtitle: Text(quiz.quiz_description),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.delete),
//                         onPressed: () async {
//                           // Call the delete method from SyncService
//                           await syncService.deleteQuizAndRelatedData(quiz.id);
//                           // Refresh the quiz list after deletion
//                           setState(() {}); // Use setState to update the UI
//                         },
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.edit),
//                         onPressed: () {
//                           // Navigate to the update quiz page
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => UpdateQuizPage(quiz: quiz),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:quizapp/model/syncModel.dart';
import 'package:quizapp/savequestion.dart';
import 'package:quizapp/syncservices.dart';
import 'package:quizapp/quiz_db.dart';
import 'package:quizapp/question_db.dart';
import 'package:quizapp/answers_db.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class QuizListPage extends StatefulWidget {
  @override
  _QuizListPageState createState() => _QuizListPageState();
}

class _QuizListPageState extends State<QuizListPage> {
  final SyncService syncService = SyncService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz List'),
      ),
      body: FutureBuilder<List<Quiz>>(
        future: syncService.getAllQuizzesFromSQLite(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No quizzes available.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final quiz = snapshot.data![index];
                return ListTile(
                  title: Text(quiz.quizName),
                  subtitle: Text(quiz.quiz_description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.green),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateQuestionScreen(quizId: quiz.id),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          String quizId = quiz.id;
                          bool isConnected = await InternetConnectionChecker().hasConnection;
                          if (isConnected) {
                            await syncService.deleteQuizAndRelatedData(quiz.id);
                          } else {
                            await syncService.deleteAndStoreLocally(quiz.id, 'quiz');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Quiz deleted locally.'),
                              ),
                            );
                          }
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateQuizPage(quiz: quiz),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}



// class UpdateQuizPage extends StatefulWidget {
//   final Quiz quiz;

//   const UpdateQuizPage({Key? key, required this.quiz}) : super(key: key);

//   @override
//   _UpdateQuizPageState createState() => _UpdateQuizPageState();
// }

// class _UpdateQuizPageState extends State<UpdateQuizPage> {
//   final TextEditingController _quizNameController = TextEditingController();
//   final TextEditingController _quizDescriptionController = TextEditingController();
//   bool isConnected = false;

//   @override
//   void initState() {
//     super.initState();
//     _quizNameController.text = widget.quiz.quizName;
//     _quizDescriptionController.text = widget.quiz.quiz_description;
//     checkConnectionStatus();
//   }

//   Future<void> checkConnectionStatus() async {
//     bool connected = await InternetConnectionChecker().hasConnection;
//     setState(() {
//       isConnected = connected;
//     });
//   }

// void _updateQuiz() async {
//   String quizName = _quizNameController.text.trim();
//   String quizDescription = _quizDescriptionController.text.trim();

//   if (quizName.isNotEmpty && quizDescription.isNotEmpty) {
//     Quiz updatedQuiz = widget.quiz.copyWith(
//       quizName: quizName,
//       quizDescription: quizDescription,
//     );

//     try {
//       if (isConnected) {
//         // Update directly in Firestore if online
//         await SyncService().syncUpdatedQuizzes(updatedQuiz);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Quiz updated and synced with Firestore',
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
//       } else {
//         // Update locally if offline
//         await QuizDB().updateQuiz(
//           id: updatedQuiz.id,
//           quizname: updatedQuiz.quizName,
//           quizdescription: updatedQuiz.quiz_description,
//         );
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Quiz updated locally',
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
//       }
//     } catch (error) {
//       // Handle any errors that occur during the update or sync process
//       print('Error: $error');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Error updating quiz',
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
//     }
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           'Please enter a quiz name and description',
//           style: TextStyle(fontSize: 16.0, color: Colors.white),
//         ),
//         backgroundColor: Color(0xFF5271FF),
//         elevation: 8.0,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         margin: EdgeInsets.all(16.0),
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Update Quiz'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 controller: _quizNameController,
//                 decoration: InputDecoration(
//                   labelText: 'Quiz Name',
//                   border: OutlineInputBorder(),
//                   hintText: 'Enter the quiz name',
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 controller: _quizDescriptionController,
//                 maxLines: 2,
//                 decoration: InputDecoration(
//                   labelText: 'Quiz Description',
//                   border: OutlineInputBorder(),
//                   hintText: 'Enter the quiz description',
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _updateQuiz,
//                 child: Text('Update Quiz'),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 isConnected ? 'Connected' : 'Not Connected',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: isConnected ? Colors.green : Colors.red,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class UpdateQuizPage extends StatefulWidget {
  final Quiz quiz;

  const UpdateQuizPage({Key? key, required this.quiz}) : super(key: key);

  @override
  _UpdateQuizPageState createState() => _UpdateQuizPageState();
}

class _UpdateQuizPageState extends State<UpdateQuizPage> {
  final TextEditingController _quizNameController = TextEditingController();
  final TextEditingController _quizDescriptionController = TextEditingController();
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _quizNameController.text = widget.quiz.quizName;
    _quizDescriptionController.text = widget.quiz.quiz_description;
    checkConnectionStatus();
  }

  Future<void> checkConnectionStatus() async {
    bool connected = await InternetConnectionChecker().hasConnection;
    setState(() {
      isConnected = connected;
    });
  }

  void _updateQuiz() async {
    String updatedQuizName = _quizNameController.text.trim();
    String updatedQuizDescription = _quizDescriptionController.text.trim();

    if (updatedQuizName.isNotEmpty && updatedQuizDescription.isNotEmpty) {
      // Create a new Quiz object with updated details
      Quiz updatedQuiz = widget.quiz.copyWith(
        quizName: updatedQuizName,
        quizDescription: updatedQuizDescription,
      );

      try {
        if (isConnected) {
          // Update quiz details in Firestore
          await QuizFirestore().updateQuiz(
            id: updatedQuiz.id,
            quizname: updatedQuiz.quizName,
            quizdescription: updatedQuiz.quiz_description,
            minutesToComplete: updatedQuiz.minutesToComplete,
          );

          await QuizDB().updateQuiz(id: updatedQuiz.id, quizname: updatedQuiz.quizName, quizdescription: updatedQuiz.quiz_description);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Quiz updated and synced with Firestore',
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
          // Update quiz details in SQLite only
          await QuizDB().updateQuiz(id: updatedQuiz.id, quizname: updatedQuiz.quizName, quizdescription: updatedQuiz.quiz_description);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Quiz updated locally',
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
      } catch (error) {
        print('Error updating quiz: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error updating quiz',
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
            'Please enter quiz name and description',
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
        title: Text('Update Quiz'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TextFormFields for quiz name and description
              TextFormField(
                controller: _quizNameController,
                decoration: InputDecoration(
                  labelText: 'Quiz Name',
                  border: OutlineInputBorder(),
                  hintText: 'Enter the quiz name',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _quizDescriptionController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Quiz Description',
                  border: OutlineInputBorder(),
                  hintText: 'Enter the quiz description',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateQuiz,
                child: Text('Update Quiz'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                isConnected ? 'Connected' : 'Not Connected',
                style: TextStyle(
                  fontSize: 18,
                  color: isConnected ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: 32.0),
              Text(
                'Questions:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FutureBuilder<List<Question>>(
                future: QuestionDB().fetchQuestionsByQuizId(widget.quiz.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No questions available.'));
                  } else {
                    return Column(
                      children: snapshot.data!.map((question) {
                        return ListTile(
                          title: Text(question.quizQuestion),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Navigate to update question page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateQuestionPage(question: question),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class UpdateQuestionPage extends StatefulWidget {
  final Question question;

  const UpdateQuestionPage({Key? key, required this.question}) : super(key: key);

  @override
  _UpdateQuestionPageState createState() => _UpdateQuestionPageState();
}

class _UpdateQuestionPageState extends State<UpdateQuestionPage> {
  final TextEditingController _questionTextController = TextEditingController();
  final TextEditingController _answerTextController = TextEditingController();
  final SyncService syncService = SyncService();
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _questionTextController.text = widget.question.quizQuestion;
    checkConnectionStatus();
  }

  Future<void> checkConnectionStatus() async {
    bool connected = await InternetConnectionChecker().hasConnection;
    setState(() {
      isConnected = connected;
    });
  }

  Future<void> _updateQuestion() async {
    String questionText = _questionTextController.text.trim();

    if (questionText.isNotEmpty) {
      Question updatedQuestion = widget.question.copyWith(
        quizQuestion: questionText,
      );

      try {
        if (isConnected) {
          // Update directly in Firestore if online
          await syncService.syncUpdatedQuestions(updatedQuestion);
           await QuestionDB().updateQuestion(updatedQuestion);
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Question updated and synced with Firestore',
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
          // Update locally if offline
          await QuestionDB().updateQuestion(updatedQuestion);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Question updated locally',
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
      } catch (error) {
        print('Error: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error updating question',
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
            'Please enter question text',
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
        title: Text('Update Question'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _questionTextController,
                decoration: InputDecoration(
                  labelText: 'Question Text',
                  border: OutlineInputBorder(),
                  hintText: 'Enter the question text',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateQuestion,
                child: Text('Update Question'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                isConnected ? 'Connected' : 'Not Connected',
                style: TextStyle(
                  fontSize: 18,
                  color: isConnected ? Colors.green : Colors.red,
                ),
              ),
              SizedBox(height: 32.0),
              Text(
                'Answers:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FutureBuilder<List<Answer>>(
                future: AnswerDB().fetchAnswersByQuestionId(widget.question.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No answers available.'));
                  } else {
                    return Column(
                      children: snapshot.data!.map((answer) {
                        return ListTile(
                          title: Text(answer.answerText),
                          subtitle: Text(answer.isCorrect ? 'Correct Answer' : 'Incorrect Answer'),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Navigate to update answer page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateAnswerPage(answer: answer),
                                ),
                              );
                            },
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class UpdateAnswerPage extends StatefulWidget {
  final Answer answer;

  const UpdateAnswerPage({Key? key, required this.answer}) : super(key: key);

  @override
  _UpdateAnswerPageState createState() => _UpdateAnswerPageState();
}

class _UpdateAnswerPageState extends State<UpdateAnswerPage> {
  final TextEditingController _answerTextController = TextEditingController();
  final TextEditingController _isCorrectController = TextEditingController();
  final SyncService syncService = SyncService();
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _answerTextController.text = widget.answer.answerText;
    _isCorrectController.text = widget.answer.isCorrect ? 'true' : 'false';
    checkConnectionStatus();
  }

  Future<void> checkConnectionStatus() async {
    bool connected = await InternetConnectionChecker().hasConnection;
    setState(() {
      isConnected = connected;
    });
  }

Future<void> _updateAnswer() async {
  String answerText = _answerTextController.text.trim();
  bool isCorrect = _isCorrectController.text.trim().toLowerCase() == 'true';
  String id = widget.answer.id; // Assuming the answer object has an 'id' property
  String questionId = widget.answer.questionId; // Assuming the answer object has a 'questionId' property

  if (answerText.isNotEmpty) {
    Answer updatedAnswer = widget.answer.copyWith(
      answerText: answerText,
      isCorrect: isCorrect,
    );

    try {
      if (isConnected) {
        // Update directly in Firestore if online
        await syncService.syncUpdatedAnswers(updatedAnswer);
                await AnswerDB().update(
          id: id,
          answerText: answerText,
          isCorrect: isCorrect,
          questionId: questionId,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Answer updated and synced with Firestore',
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
        // Update locally if offline
        await AnswerDB().update(
          id: id,
          answerText: answerText,
          isCorrect: isCorrect,
          questionId: questionId,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Answer updated locally',
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
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error updating answer',
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
          'Please enter answer text',
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
        title: Text('Update Answer'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _answerTextController,
                decoration: InputDecoration(
                  labelText: 'Answer Text',
                  border: OutlineInputBorder(),
                  hintText: 'Enter the answer text',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _isCorrectController,
                decoration: InputDecoration(
                  labelText: 'Is Correct (true/false)',
                  border: OutlineInputBorder(),
                  hintText: 'Enter true or false',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateAnswer,
                child: Text('Update Answer'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
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
      ),
    );
  }
}


// class UpdateQuestionPage extends StatefulWidget {
//   final Question question;

//   const UpdateQuestionPage({Key? key, required this.question}) : super(key: key);

//   @override
//   _UpdateQuestionPageState createState() => _UpdateQuestionPageState();
// }

// class _UpdateQuestionPageState extends State<UpdateQuestionPage> {
//   final TextEditingController _questionTextController = TextEditingController();
//   final TextEditingController _answerController = TextEditingController();
//   final SyncService syncService = SyncService();
//   bool isConnected = false;

//   @override
//   void initState() {
//     super.initState();
//     _questionTextController.text = widget.question.quizQuestion;
//     checkConnectionStatus();
//   }

//   Future<void> checkConnectionStatus() async {
//     bool connected = await InternetConnectionChecker().hasConnection;
//     setState(() {
//       isConnected = connected;
//     });
//   }

// Future<void> _updateQuestion() async {
//   String questionText = _questionTextController.text.trim();

//   if (questionText.isNotEmpty) {
//     Question updatedQuestion = widget.question.copyWith(
//       quizQuestion: questionText,
//     );

//     try {
//       if (isConnected) {
//         // Update directly in Firestore if online
//         await syncService.syncUpdatedQuestions(updatedQuestion);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Question updated and synced with Firestore',
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
//       } else {
//         // Update locally if offline
//         await QuestionDB().updateQuestion(updatedQuestion);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Question updated locally',
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
//       }
//     } catch (error) {
//       print('Error: $error');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(
//             'Error updating question',
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
//     }
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           'Please enter question text',
//           style: TextStyle(fontSize: 16.0, color: Colors.white),
//         ),
//         backgroundColor: Color(0xFF5271FF),
//         elevation: 8.0,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         margin: EdgeInsets.all(16.0),
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Update Question'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 controller: _questionTextController,
//                 decoration: InputDecoration(
//                   labelText: 'Question Text',
//                   border: OutlineInputBorder(),
//                   hintText: 'Enter the question text',
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _updateQuestion,
//                 child: Text('Update Question'),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 isConnected ? 'Connected' : 'Not Connected',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: isConnected ? Colors.green : Colors.red,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }