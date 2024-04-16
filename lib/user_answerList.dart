// import 'package:flutter/material.dart';
// import 'package:quizapp/model/user.dart';
// import 'package:quizapp/model/userAnswer.dart'; // Import your UserAnswer model
// import 'package:quizapp/syncservices.dart'; // Import your SyncService class

// class AnswerListScreen extends StatefulWidget {
//   final Users loggedInUser;

//   const AnswerListScreen({Key? key, required this.loggedInUser}) : super(key: key);

//   @override
//   _AnswerListScreenState createState() => _AnswerListScreenState();
// }

// class _AnswerListScreenState extends State<AnswerListScreen> {
//   final SyncService _syncService = SyncService();
//   List<UserAnswer> userAnswers = [];

//   @override
//   void initState() {
//     super.initState();
//     loadUserAnswers();
//   }

//   Future<void> loadUserAnswers() async {
//     // Get the email of the logged-in user
//     String userEmail = widget.loggedInUser.email;

//     // Fetch user answers from the database based on the user's email
//     List<UserAnswer> fetchedUserAnswers = await _syncService.getUserAnswersByEmail(userEmail);

//     setState(() {
//       userAnswers = fetchedUserAnswers;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Answers'),
//       ),
//       body: ListView.builder(
//         itemCount: userAnswers.length,
//         itemBuilder: (context, index) {
//           UserAnswer answer = userAnswers[index];
//           // Build UI for each user answer here
//           return ListTile(
//             title: Text('Quiz ID: ${answer.quizId}'),
//             subtitle: Text('Question ID: ${answer.questionId}'),
//             trailing: Text('Correct: ${answer.isCorrect}'),
//           );
//         },
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:quizapp/model/user.dart';
// import 'package:quizapp/model/userAnswer.dart'; 
// import 'package:quizapp/syncservices.dart'; 

// class AnswerListScreen extends StatefulWidget {
//   final Users loggedInUser;

//   const AnswerListScreen({Key? key, required this.loggedInUser}) : super(key: key);

//   @override
//   _AnswerListScreenState createState() => _AnswerListScreenState();
// }

// class _AnswerListScreenState extends State<AnswerListScreen> {
//   final SyncService _syncService = SyncService();
//   List<UserAnswer> userAnswers = [];

//   @override
//   void initState() {
//     super.initState();
//     loadUserAnswers();
//   }

//   Future<void> loadUserAnswers() async {
//     String userEmail = widget.loggedInUser.email;
//     List<UserAnswer> fetchedUserAnswers = await _syncService.getUserAnswerByEmail(userEmail);

//     setState(() {
//       userAnswers = fetchedUserAnswers;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Answers'),
//       ),
//       body: ListView.builder(
//         itemCount: userAnswers.length,
//         itemBuilder: (context, index) {
//           return FutureBuilder(
//             future: _buildListTile(context, index),
//             builder: (BuildContext context, AsyncSnapshot<ListTile> snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator(); // Placeholder for loading state
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else {
//                 return snapshot.data!;
//               }
//             },
//           );
//         },
//       ),
//     );
//   }

//   Future<ListTile> _buildListTile(BuildContext context, int index) async {
//     UserAnswer answer = userAnswers[index];
//     String? quizName = await _syncService.getQuizNameById(answer.quizId);
//     String? questionText = await _syncService.getQuestionTextById(answer.questionId);
//     String? answerText = await _syncService.getAnswerTextById(answer.answerId);

//     return ListTile(
//       title: Text('Quiz Name: ${quizName ?? 'Unknown'}'),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Question: ${questionText ?? 'Unknown'}'),
//           Text('Answer: ${answerText ?? 'Unknown'}'),
//         ],
//       ),
//       trailing: Text('Correct: ${answer.isCorrect}'),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:quizapp/model/user.dart';
// import 'package:quizapp/model/userAnswer.dart'; 
// import 'package:quizapp/syncservices.dart'; 

// class AnswerListScreen extends StatefulWidget {
//   final Users loggedInUser;

//   const AnswerListScreen({Key? key, required this.loggedInUser}) : super(key: key);

//   @override
//   _AnswerListScreenState createState() => _AnswerListScreenState();
// }

// class _AnswerListScreenState extends State<AnswerListScreen> {
//   final SyncService _syncService = SyncService();
//   List<UserAnswer> userAnswers = [];
//   Map<String, List<UserAnswer>> groupedAnswers = {};

//   @override
//   void initState() {
//     super.initState();
//     loadUserAnswers();
//   }

//   Future<void> loadUserAnswers() async {
//     String userEmail = widget.loggedInUser.email;
//     List<UserAnswer> fetchedUserAnswers = await _syncService.getUserAnswerByEmail(userEmail);

//     setState(() {
//       userAnswers = fetchedUserAnswers;
//       groupUserAnswersByQuizId();
//     });
//   }

//   void groupUserAnswersByQuizId() {
//     groupedAnswers.clear();
//     for (UserAnswer answer in userAnswers) {
//       if (!groupedAnswers.containsKey(answer.quizId)) {
//         groupedAnswers[answer.quizId] = [];
//       }
//       groupedAnswers[answer.quizId]!.add(answer);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Answers'),
//       ),
//       body: ListView.builder(
//         itemCount: groupedAnswers.length,
//         itemBuilder: (context, index) {
//           String quizId = groupedAnswers.keys.elementAt(index);
//           List<UserAnswer> answers = groupedAnswers[quizId]!;
//           return ExpansionTile(
//             title: Text('Quiz ID: $quizId'),
//             children: [
//               for (UserAnswer answer in answers)
//                 ListTile(
//                   title: Text('Question ID: ${answer.questionId}'),
//                   subtitle: Text('Answer ID: ${answer.answerId}'),
//                   trailing: Text('Correct: ${answer.isCorrect}'),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:quizapp/model/user.dart';
// import 'package:quizapp/model/userAnswer.dart';
// import 'package:quizapp/syncservices.dart';

// class AnswerListScreen extends StatefulWidget {
//   final Users loggedInUser;

//   const AnswerListScreen({Key? key, required this.loggedInUser}) : super(key: key);

//   @override
//   _AnswerListScreenState createState() => _AnswerListScreenState();
// }

// class _AnswerListScreenState extends State<AnswerListScreen> {
//   final SyncService _syncService = SyncService();
//   List<UserAnswer> userAnswers = [];

//   @override
//   void initState() {
//     super.initState();
//     loadUserAnswers();
//   }

//   Future<void> loadUserAnswers() async {
//     String userEmail = widget.loggedInUser.email;
//     List<UserAnswer> fetchedUserAnswers = await _syncService.getUserAnswerByEmail(userEmail);

//     setState(() {
//       userAnswers = fetchedUserAnswers;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Answers'),
//       ),
//       body: ListView.builder(
//         itemCount: userAnswers.length,
//         itemBuilder: (context, index) {
//           return FutureBuilder(
//             future: _buildListTile(context, index),
//             builder: (BuildContext context, AsyncSnapshot<ListTile> snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator(); // Placeholder for loading state
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else {
//                 return snapshot.data!;
//               }
//             },
//           );
//         },
//       ),
//     );
//   }

//   Future<ListTile> _buildListTile(BuildContext context, int index) async {
//     UserAnswer answer = userAnswers[index];
//     String? quizName = await _syncService.getQuizNameById(answer.quizId);
//     String? questionText = await _syncService.getQuestionTextById(answer.questionId);
//     String? answerText = await _syncService.getAnswerTextById(answer.answerId);

//     return ListTile(
//       title: Text('Quiz Name: ${quizName ?? 'Unknown'}'),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Question: ${questionText ?? 'Unknown'}'),
//           Text('Answer: ${answerText ?? 'Unknown'}'),
//         ],
//       ),
//       trailing: Text('Correct: ${answer.isCorrect}'),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:quizapp/model/user.dart';
// import 'package:quizapp/model/userAnswer.dart';
// import 'package:quizapp/syncservices.dart';

// class AnswerListScreen extends StatefulWidget {
//   final Users loggedInUser;

//   const AnswerListScreen({Key? key, required this.loggedInUser}) : super(key: key);

//   @override
//   _AnswerListScreenState createState() => _AnswerListScreenState();
// }

// class _AnswerListScreenState extends State<AnswerListScreen> {
//   final SyncService _syncService = SyncService();
//   Map<String, List<UserAnswer>> groupedUserAnswers = {};

//   @override
//   void initState() {
//     super.initState();
//     loadUserAnswers();
//   }

//   Future<void> loadUserAnswers() async {
//     String userEmail = widget.loggedInUser.email;
//     List<UserAnswer> fetchedUserAnswers = await _syncService.getUserAnswerByEmail(userEmail);

//     // Group user answers by quizId
//     groupedUserAnswers = {};
//     for (UserAnswer answer in fetchedUserAnswers) {
//       if (!groupedUserAnswers.containsKey(answer.quizId)) {
//         groupedUserAnswers[answer.quizId] = [];
//       }
//       groupedUserAnswers[answer.quizId]!.add(answer);
//     }

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Answers'),
//       ),
//       body: ListView.builder(
//         itemCount: groupedUserAnswers.length,
//         itemBuilder: (context, index) {
//           String quizId = groupedUserAnswers.keys.elementAt(index);
//           List<UserAnswer> userAnswers = groupedUserAnswers[quizId]!;

//           return ExpansionTile(
//             title: FutureBuilder(
//               future: _syncService.getQuizNameById(quizId),
//               builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Text('Loading...'); // Placeholder for loading state
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return Text('Quiz Name: ${snapshot.data ?? 'Unknown'}');
//                 }
//               },
//             ),
//             children: userAnswers.map((answer) => _buildListTile(answer)).toList(),
//           );
//         },
//       ),
//     );
//   }

// Widget _buildListTile(UserAnswer answer) {
//   String grade = answer.isCorrect ? '1' : '0';

//   return ListTile(
//     title: FutureBuilder(
//       future: _syncService.getQuestionTextById(answer.questionId),
//       builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text('Loading...'); // Placeholder for loading state
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return Text('Question: ${snapshot.data ?? 'Unknown'}');
//         }
//       },
//     ),
//     subtitle: FutureBuilder(
//       future: _syncService.getAnswerTextById(answer.answerId),
//       builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text('Loading...'); 
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return Text('Answer: ${snapshot.data ?? 'Unknown'}');
//         }
//       },
//     ),
//     trailing: Text('Grade: $grade'),
//   );
// }

// Map<String, int> calculateQuizGrades(List<UserAnswer> userAnswers) {
//   Map<String, int> quizGrades = {};

//   for (UserAnswer answer in userAnswers) {
//     if (!quizGrades.containsKey(answer.quizId)) {
//       quizGrades[answer.quizId] = 0;
//     }
//     if (answer.isCorrect) {
//       quizGrades[answer.quizId] = quizGrades[answer.quizId]! + 1;
//     }
//   }

//   return quizGrades;
// }


// Widget _buildQuizGrade(String quizId, int grade) {
//   return ListTile(
//     title: FutureBuilder(
//       future: _syncService.getQuizNameById(quizId),
//       builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text('Loading...'); // Placeholder for loading state
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return Text('Quiz Name: ${snapshot.data ?? 'Unknown'}');
//         }
//       },
//     ),
//     subtitle: Text('Total Grade: $grade'),
//   );
// }

// }

import 'package:flutter/material.dart';
import 'package:quizapp/model/user.dart';
import 'package:quizapp/model/userAnswer.dart';
import 'package:quizapp/syncservices.dart';

class AnswerListScreen extends StatefulWidget {
  final Users loggedInUser;

  const AnswerListScreen({Key? key, required this.loggedInUser}) : super(key: key);

  @override
  _AnswerListScreenState createState() => _AnswerListScreenState();
}

class _AnswerListScreenState extends State<AnswerListScreen> {
  final SyncService _syncService = SyncService();
  Map<String, List<UserAnswer>> groupedUserAnswers = {};

  @override
  void initState() {
    super.initState();
    loadUserAnswers();
  }

  Future<void> loadUserAnswers() async {
    String userEmail = widget.loggedInUser.email;
    List<UserAnswer> fetchedUserAnswers = await _syncService.getUserAnswerByEmail(userEmail);

    // Group user answers by quizId
    groupedUserAnswers = {};
    for (UserAnswer answer in fetchedUserAnswers) {
      if (!groupedUserAnswers.containsKey(answer.quizId)) {
        groupedUserAnswers[answer.quizId] = [];
      }
      groupedUserAnswers[answer.quizId]!.add(answer);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Answers'),
      ),
      body: ListView.builder(
        itemCount: groupedUserAnswers.length,
        itemBuilder: (context, index) {
          String quizId = groupedUserAnswers.keys.elementAt(index);
          List<UserAnswer> userAnswers = groupedUserAnswers[quizId]!;

          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
                title: FutureBuilder(
                  future: _syncService.getQuizNameById(quizId),
                  builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('Loading...', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold));
                    } else {
                      return Text('Quiz Name: ${snapshot.data ?? 'Unknown'}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold));
                    }
                  },
                ),
                children: [
                  ...userAnswers.map((answer) => _buildListTile(answer)).toList(),
                  _buildQuizGrade(quizId, calculateQuizGrades(userAnswers)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListTile(UserAnswer answer) {
    String grade = answer.isCorrect ? '1' : '0';

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      title: FutureBuilder(
        future: _syncService.getQuestionTextById(answer.questionId),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...', style: TextStyle(fontWeight: FontWeight.bold));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}', style: TextStyle(fontWeight: FontWeight.bold));
          } else {
            return Text('Question: ${snapshot.data ?? 'Unknown'}', style: TextStyle(fontWeight: FontWeight.bold));
          }
        },
      ),
      subtitle: FutureBuilder(
        future: _syncService.getAnswerTextById(answer.answerId),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading...');
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text('Answer: ${snapshot.data ?? 'Unknown'}');
          }
        },
      ),
      trailing: Text('Grade: $grade', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Map<String, double> calculateQuizGrades(List<UserAnswer> userAnswers) {
    Map<String, double> quizGrades = {};
    Map<String, int> totalQuestions = {};

    for (UserAnswer answer in userAnswers) {
      if (!quizGrades.containsKey(answer.quizId)) {
        quizGrades[answer.quizId] = 0.0;
        totalQuestions[answer.quizId] = 0;
      }
      if (answer.isCorrect) {
        quizGrades[answer.quizId] = quizGrades[answer.quizId]! + 1;
      }
      totalQuestions[answer.quizId] = totalQuestions[answer.quizId]! + 1;
    }

    for (String quizId in quizGrades.keys) {
      int totalQuestionsForQuiz = totalQuestions[quizId]!;
      double gradeOverTen = (quizGrades[quizId]! / totalQuestionsForQuiz) * 10;
      quizGrades[quizId] = gradeOverTen;
    }

    return quizGrades;
  }

  Widget _buildQuizGrade(String quizId, Map<String, double> quizGrades) {
    double grade = quizGrades.containsKey(quizId) ? quizGrades[quizId]! : 0.0;

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      title: Text('Total Grade (out of 10): ${grade.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

  // Widget _buildListTile(UserAnswer answer) {
  //   return ListTile(
  //     title: FutureBuilder(
  //       future: _syncService.getQuestionTextById(answer.questionId),
  //       builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Text('Loading...'); // Placeholder for loading state
  //         } else if (snapshot.hasError) {
  //           return Text('Error: ${snapshot.error}');
  //         } else {
  //           return Text('Question: ${snapshot.data ?? 'Unknown'}');
  //         }
  //       },
  //     ),
  //     subtitle: FutureBuilder(
  //       future: _syncService.getAnswerTextById(answer.answerId),
  //       builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Text('Loading...'); 
  //         } else if (snapshot.hasError) {
  //           return Text('Error: ${snapshot.error}');
  //         } else {
  //           return Text('Answer: ${snapshot.data ?? 'Unknown'}');
  //         }
  //       },
  //     ),
  //     trailing: Text('Correct: ${answer.isCorrect}'),
  //   );
  // }

//   Widget _buildListTile1(UserAnswer answer) {
//   String grade = answer.isCorrect ? '1' : '0';

//   return ListTile(
//     title: FutureBuilder(
//       future: _syncService.getQuestionTextById(answer.questionId),
//       builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text('Loading...'); // Placeholder for loading state
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return Text('Question: ${snapshot.data ?? 'Unknown'}');
//         }
//       },
//     ),
//     subtitle: FutureBuilder(
//       future: _syncService.getAnswerTextById(answer.answerId),
//       builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text('Loading...'); 
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else {
//           return Text('Answer: ${snapshot.data ?? 'Unknown'}');
//         }
//       },
//     ),
//     trailing: Text('Grade: $grade'),
//   );
// }
