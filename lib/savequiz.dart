// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart'; // Import your Quiz model class
// import 'package:quizapp/syncservices.dart'; // Import your SyncService class

// class CreateQuizScreen extends StatefulWidget {
//   @override
//   _CreateQuizScreenState createState() => _CreateQuizScreenState();
// }

// class _CreateQuizScreenState extends State<CreateQuizScreen> {
//   final TextEditingController _quizNameController = TextEditingController();
//   final TextEditingController _quizDescriptionController = TextEditingController(); // Added

// void _createQuiz() async {
//   String quizName = _quizNameController.text.trim();
//   String quizDescription = _quizDescriptionController.text.trim();

//   if (quizName.isNotEmpty && quizDescription.isNotEmpty) {
//     // Create a new Quiz object without specifying the ID
//     Quiz newQuiz = Quiz(
//       quizName: quizName,
//       quiz_description: quizDescription,
//     );

//     // Save the quiz to SQLite and get the generated ID
    

//     // if (id != 0) {
//       // Quiz added successfully, you can navigate to another screen or show a success message
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Quiz created successfully')));

//       // Clear the text fields
//       _quizNameController.clear();
//       _quizDescriptionController.clear();
//     // } else {
//       // Failed to add quiz
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create quiz')));
//     // }
//   // } else {
//     // Show error message if any field is empty
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a quiz name and description')));
//   }
// }



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
//               controller: _quizNameController,
//               decoration: InputDecoration(labelText: 'Quiz Name'),
//             ),
//             SizedBox(height: 16.0),
//             TextField( // Added
//               controller: _quizDescriptionController,
//               decoration: InputDecoration(labelText: 'Quiz Description'), // Added
//             ), // Added
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: _createQuiz,
//               child: Text('Create Quiz'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:navigations/model/syncModel.dart'; 
// import 'package:navigations/syncservices.dart'; 
// import 'package:navigations/savequestion.dart';
// import 'package:uuid/uuid.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// class CreateQuizScreen extends StatefulWidget {
//   @override
//   _CreateQuizScreenState createState() => _CreateQuizScreenState();
// }

// class _CreateQuizScreenState extends State<CreateQuizScreen> {
//   final TextEditingController _quizNameController = TextEditingController();
//   final TextEditingController _quizDescriptionController = TextEditingController(); 
//   String? _createdQuizId; 
//   bool isConnected = false;

// void initState() {
//   super.initState();
//   checkConnectionStatus();
// }

// Future<void> checkConnectionStatus() async {
//   bool connected = await InternetConnectionChecker().hasConnection;
//   setState(() {
//     isConnected = connected;
//   });
// }



// void _createQuiz() async {
//   String quizName = _quizNameController.text.trim();
//   String quizDescription = _quizDescriptionController.text.trim();
//   String quizId = Uuid().v4();

//   bool isConnected = await InternetConnectionChecker().hasConnection;

//   if (quizName.isNotEmpty && quizDescription.isNotEmpty) {
//     Quiz newQuiz = Quiz(id: quizId, quizName: quizName, quiz_description: quizDescription);

//     try {
//       if (isConnected) {
//         // Save directly to Firestore if online
//         await SyncService().saveQuizToFirestore(newQuiz);
//         _createdQuizId = quizId; // Assign the quiz ID after saving
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Quiz created and synced with Firestore')));
//       } else {
//         // Save locally if offline
//         _createdQuizId = await SyncService().saveQuizToSQLite(newQuiz);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Quiz saved locally')));
//       }

//       // Check internet connectivity again after the save operation
//       bool isReconnected = await InternetConnectionChecker().hasConnection;

//       if (_createdQuizId != null && isConnected && isReconnected) {
//         _quizNameController.clear();
//         _quizDescriptionController.clear();
//       }
//     } catch (error) {
//       // Handle any errors that occur during the save or sync process
//       print('Error: $error');
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error syncing quiz')));
//     }
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a quiz name and description')));
//   }
// }

//   void _navigateToCreateQuestion() {
//     if (_createdQuizId != null) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => CreateQuestionScreen(quizId: _createdQuizId!)),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please create the quiz first')));
//     }
//   }
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Create Quiz'),
//     ),
//     body: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           TextField(
//             controller: _quizNameController,
//             decoration: InputDecoration(labelText: 'Quiz Name'),
//           ),
//           SizedBox(height: 16.0),
//           TextField( 
//             controller: _quizDescriptionController,
//             decoration: InputDecoration(labelText: 'Quiz Description'), 
//           ), 
//           SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: _createQuiz,
//             child: Text('Create Quiz'),
//           ),
//           SizedBox(height: 16.0),
//           ElevatedButton(
//             onPressed: _navigateToCreateQuestion,
//             child: Text('Add Question'),
//           ),
//           SizedBox(height: 16.0),
//           Text(
//             isConnected ? 'Connected' : 'Not Connected',
//             style: TextStyle(
//               fontSize: 18,
//               color: isConnected ? Colors.green : Colors.red,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// }



//   void _createQuiz() async {
//     String quizName = _quizNameController.text.trim();
//     String quizDescription = _quizDescriptionController.text.trim();
//     String minutesText = _minutesController.text.trim();
//     String quizId = Uuid().v4();

//     bool isConnected = await InternetConnectionChecker().hasConnection;

//     if (quizName.isNotEmpty && quizDescription.isNotEmpty) {
//       int minutes = int.parse(minutesText);
//       Quiz newQuiz = Quiz(minutesToComplete: minutes, id: quizId, quizName: quizName, quiz_description: quizDescription);

//       try {
//         if (isConnected) {
//           // Save directly to Firestore if online
//           await SyncService().saveQuizToFirestore(newQuiz);
//           await SyncService().saveQuizToSQLite(newQuiz);
//           _createdQuizId = quizId; 
//                 ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//     content: Text(
//       'Quiz created and synced with Firestore',
//       style: TextStyle(fontSize: 16.0, color: Colors.white),
//     ),
//     backgroundColor: Color(0xFF5271FF), 
//     elevation: 8.0, 
//     behavior: SnackBarBehavior.floating, 
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8.0),
//     ),
//     margin: EdgeInsets.all(16.0), 
//     duration: Duration(seconds: 3), 
//   ),
// );
          
//         } else {
//           // Save locally if offline
//           _createdQuizId = await SyncService().saveQuizToSQLite(newQuiz);
//                           ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//     content: Text(
//       'Quiz saved locally',
//       style: TextStyle(fontSize: 16.0, color: Colors.white),
//     ),
//     backgroundColor: Color(0xFF5271FF), 
//     elevation: 8.0, 
//     behavior: SnackBarBehavior.floating, 
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8.0),
//     ),
//     margin: EdgeInsets.all(16.0), 
//     duration: Duration(seconds: 3), 
//   ),
// );
//           await QuizDB().setSyncStatus(quizId, 'unsynced');
//         }

//         // Check internet connectivity again after the save operation
//         bool isReconnected = await InternetConnectionChecker().hasConnection;

//         if (_createdQuizId != null && isConnected && isReconnected) {
//           _quizNameController.clear();
//           _quizDescriptionController.clear();
//         }
//       } catch (error) {
//         // Handle any errors that occur during the save or sync process
//         print('Error: $error');


//               ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//     content: Text(
//       'Error syncing quiz',
//       style: TextStyle(fontSize: 16.0, color: Colors.white),
//     ),
//     backgroundColor: Color(0xFF5271FF), 
//     elevation: 8.0, 
//     behavior: SnackBarBehavior.floating, 
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8.0),
//     ),
//     margin: EdgeInsets.all(16.0), 
//     duration: Duration(seconds: 3), 
//   ),
// );
        
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//   SnackBar(
//     content: Text(
//       'Please enter a quiz name and description',
//       style: TextStyle(fontSize: 16.0, color: Colors.white),
//     ),
//     backgroundColor: Color(0xFF5271FF), 
//     elevation: 8.0, 
//     behavior: SnackBarBehavior.floating, 
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(8.0),
//     ),
//     margin: EdgeInsets.all(16.0), 
//     duration: Duration(seconds: 3), 
//   ),
// );

//     }
//   }

import 'package:flutter/material.dart';
import 'package:quizapp/model/syncModel.dart';
import 'package:quizapp/syncservices.dart';
import 'package:quizapp/savequestion.dart';
import 'package:uuid/uuid.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quizapp/quiz_db.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:quizapp/notification_controller.dart';

class CreateQuizScreen extends StatefulWidget {
  @override
  _CreateQuizScreenState createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final TextEditingController _quizNameController = TextEditingController();
  final TextEditingController _quizDescriptionController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();

  String? _createdQuizId;
  bool isConnected = false;

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

void _createQuiz() async {
  String quizName = _quizNameController.text.trim();
  String quizDescription = _quizDescriptionController.text.trim();
  String minutesText = _minutesController.text.trim();
  String quizId = Uuid().v4();

  bool isConnected = await InternetConnectionChecker().hasConnection;

  if (quizName.isNotEmpty && quizDescription.isNotEmpty) {
    int minutes = int.parse(minutesText);
    Quiz newQuiz = Quiz(minutesToComplete: minutes, id: quizId, quizName: quizName, quiz_description: quizDescription);

    try {
      if (isConnected) {
        await SyncService().saveQuizToFirestore(newQuiz);
        await SyncService().saveQuizToSQLite(newQuiz);
        _createdQuizId = quizId;

        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 1,
            channelKey: "basic_channel",
            title: "Quiz App",
            body: "You have a new quiz uploaded: $quizName",
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Quiz created and synced with Firestore',
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
        _navigateToCreateQuestion(); 
      } 
      else {
        _createdQuizId = await SyncService().saveQuizToSQLite(newQuiz);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Quiz saved locally',
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
        await QuizDB().setSyncStatus(quizId, 'unsynced');
        _navigateToCreateQuestion(); 
      }

      // Check internet connectivity again after the save operation
      bool isReconnected = await InternetConnectionChecker().hasConnection;

      if (_createdQuizId != null && isConnected && isReconnected) {
        _quizNameController.clear();
        _quizDescriptionController.clear();
      }
    } catch (error) {
      // Handle any errors that occur during the save or sync process
      print('Error: $error');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error syncing quiz',
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
          'Please enter a quiz name and description',
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


  void _navigateToCreateQuestion() {
    if (_createdQuizId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreateQuestionScreen(quizId: _createdQuizId!)),
      );
    } else {
            ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(
      'Please create the quiz first',
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

  void _syncUnsyncedQuizzes() async {
    // Check internet connectivity before attempting to sync
    bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected) {
      try {
        await SyncService().syncUnsyncedQuizzes(); // Implement this method in SyncService
                    ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(
      'Synced unsynced quizzes with Firestore',
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
        await QuizDB().clearSyncStatus(); // Clear the sync status after successful sync
      } catch (error) {
        print('Error syncing unsynced quizzes: $error');
                            ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(
      'Error syncing unsynced quizzes',
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
      'No internet connection. Cannot sync.',
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
        title: Text('Create Quiz'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 70, left: 16.0, right: 16.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                TextFormField(
                  controller: _minutesController,
                  keyboardType: TextInputType.number, 
                  decoration: InputDecoration(
                    labelText: 'Minutes to Complete',
                    border: OutlineInputBorder(),
                    hintText: 'Enter the minutes to complete the quiz',
                  ),
                ),
              SizedBox(height: 22.0),
ElevatedButton(
  onPressed: () async {
    _createQuiz();
    _navigateToCreateQuestion();
  },
  child: Text('Create Quiz'),
  style: ElevatedButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 16.0),
  ),
),

              
              // SizedBox(height: 16.0),
              // ElevatedButton(
              //   onPressed: _navigateToCreateQuestion,
              //   child: Text('Add Question'),
              //   style: ElevatedButton.styleFrom(
              //     padding: EdgeInsets.symmetric(vertical: 16.0), // Adjust padding as needed
              //   ),
              // ),
              // SizedBox(height: 16.0),
              // ElevatedButton(
              //   onPressed: _syncUnsyncedQuizzes,
              //   child: Text('Sync with Firestore'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void _createQuiz() async {
//   String quizName = _quizNameController.text.trim();
//   String quizDescription = _quizDescriptionController.text.trim();

//   // Generate a unique ID for the quiz
//   String quizId = Uuid().v4();

//   // Check internet connectivity
//   bool isConnected = await InternetConnectionChecker().hasConnection;

//   if (quizName.isNotEmpty && quizDescription.isNotEmpty) {
//     Quiz newQuiz = Quiz(id: quizId, quizName: quizName, quiz_description: quizDescription);

//     if (isConnected) {
//       // Save to Firestore directly if online
//       _createdQuizId = await SyncService().saveQuizToFirestore(newQuiz);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Quiz created successfully')));
//     } else {
//       // Save to SQLite if offline
//       _createdQuizId = await SyncService().saveQuizToSQLite(newQuiz);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Quiz saved locally')));
//     }

//     if (_createdQuizId != null && isConnected) {
//       // Clear text fields if successfully synced with Firestore
//       _quizNameController.clear();
//       _quizDescriptionController.clear();
//     }
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a quiz name and description')));
//   }
// }




// void _createQuiz() async {
//   String quizName = _quizNameController.text.trim();
//   String quizDescription = _quizDescriptionController.text.trim();

//   // Generate a unique ID for the quiz
//   String quizId = Uuid().v4(); // Using the uuid package to generate a UUID

//   // Debug logging
//   print('Creating quiz with ID: $quizId, name: $quizName, description: $quizDescription');

//   if (quizName.isNotEmpty && quizDescription.isNotEmpty) {
//     Quiz newQuiz = Quiz(id: quizId, quizName: quizName, quiz_description: quizDescription);
//     _createdQuizId = await SyncService().saveQuizToSQLite(newQuiz);
//     SyncService().saveQuizToFirestore(newQuiz);

//     if (_createdQuizId != null) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Quiz created successfully')));
//       _quizNameController.clear();
//       _quizDescriptionController.clear();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create quiz')));
//     }
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a quiz name and description')));
//   }
// }








  // void _createQuiz() async {
  //   String quizName = _quizNameController.text.trim();
  //   String quizDescription = _quizDescriptionController.text.trim(); // Added
  //   if (quizName.isNotEmpty && quizDescription.isNotEmpty) { // Modified
  //     // Create a new Quiz object
  //     Quiz newQuiz = Quiz(quizName: quizName, quiz_description: quizDescription); // Modified

  //     // Save the quiz to both SQLite and Firestore
  //     SyncService().saveQuizToSQLite(newQuiz);
  //     SyncService().saveQuizToFirestore(newQuiz);

  //     // Show a confirmation message
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Quiz created successfully')));

  //     // Clear the text fields
  //     _quizNameController.clear();
  //     _quizDescriptionController.clear(); // Added
  //   } else {
  //     // Show an error message if the quiz name or description is empty
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a quiz name and description')));
  //   }
  // }



// void _createQuiz() async {
//   String quizName = _quizNameController.text.trim();
//   String quizDescription = _quizDescriptionController.text.trim();
//     if (quizName.isNotEmpty && quizDescription.isNotEmpty) { // Modified
//       // Create a new Quiz object
//       Quiz newQuiz = Quiz(id: 0, quizName: quizName, quiz_description: quizDescription); // Modified
//       _createdQuizId = await SyncService().saveQuizToSQLite(newQuiz);
//       // Save the quiz to both SQLite and Firestore
//       SyncService().saveQuizToSQLite(newQuiz);
//       SyncService().saveQuizToFirestore(newQuiz);

//           if (_createdQuizId != null) {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Quiz created successfully')));

//             _quizNameController.clear();
//             _quizDescriptionController.clear();
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to create quiz')));
//           }
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a quiz name and description')));
//         }
// }