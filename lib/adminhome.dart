import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'CalculatorView.dart';
import 'Aboutscreen.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'themeprovider.dart';
import 'signin.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'api/google_signin_api.dart';
import 'NewScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contactlist.dart';
import 'Gallery.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quizapp/savequiz.dart';
import 'package:quizapp/quizlist.dart';
import 'package:quizapp/model/user.dart';
import 'package:quizapp/user_answerList.dart';
import "package:quizapp/quizlistpage.dart";
import 'package:quizapp/syncservices.dart';
import 'package:quizapp/quiz_db.dart';
import 'package:quizapp/question_db.dart';
import 'package:quizapp/answers_db.dart';
import 'package:quizapp/model/syncModel.dart';

class AdminHome extends StatefulWidget {
  

  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
    Uint8List? _selectedImageBytes;
  File ? _selectedImage;
  int _selectedIndex = 0;
  String _connectionStatus = 'Unknown';
  int _currentIndex = 0;


void _syncAllUnsyncedData() async {
  bool isConnected = await InternetConnectionChecker().hasConnection;
  if (isConnected) {
    try {
      await SyncService().syncUnsyncedAnswers();
      await SyncService().syncUnsyncedQuestions();
      await SyncService().syncUnsyncedQuizzes();
      List<Quiz> updatedQuizzes = await QuizDB().fetchUnsyncedQuizzes();
      for (Quiz quiz in updatedQuizzes) {
        await SyncService().syncUpdatedQuizzes(quiz);
      }

      List<Question> updatedQuestions = await QuestionDB().fetchUnsyncedQuestions();
      for (Question question in updatedQuestions) {
        await SyncService().syncUpdatedQuestions(question);
      }
      
      await SyncService().syncUnsyncedUserAnswers();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Synced all unsynced data with Firestore',
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

      // Clear sync status for all synced data
      await AnswerDB().clearSyncStatus();
      await QuestionDB().clearSyncStatus();
      await QuizDB().clearSyncStatus();
    } catch (error) {
      print('Error syncing unsynced data: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error syncing unsynced data',
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
          'No internet connection. Cannot sync data.',
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
        title: const Text('Welcome Admin'),
          actions: [
    PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: ListTile(
            title: Text('Sign Out'), 
            onTap: () async {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
          ),
        ),
      ],
    ),
  ],
      ),
      backgroundColor: Colors.white,
body: SingleChildScrollView(
child: Center(
  child: Padding(
    padding: const EdgeInsets.only(top: 240),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateQuizScreen()),
            );
          },
          child: Text('Create Quiz'),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(300, 50), 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), 
            ),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizListPage(),
              ),
            );
          },
          
          child: Text('Modify Quiz'),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(300, 50), // Adjust width and height as needed
            shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(15), // Add a small curve
            ),
            textStyle: TextStyle(fontSize: 18)
             // Adjust text style as needed
          ),
        ),
                SizedBox(height: 20), // Add spacing between buttons
        ElevatedButton(
          onPressed: _syncAllUnsyncedData,
          child: Text('Sync with Firestore'),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(300, 50), // Adjust width and height as needed
            shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(15), // Add a small curve
            ),
            textStyle: TextStyle(fontSize: 18)
             // Adjust text style as needed
          ),
        ),
      ],
    ),
  ),
),

),

          bottomNavigationBar: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: BottomNavigationBar(
items: <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          child: Icon(Icons.home),
          backgroundColor: Color(0xFF5271FF),
        ),
      ),
      label: 'Home', // Add label for the Home item
    ),
    BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          child: Icon(Icons.calculate),
          backgroundColor: Color(0xFF5271FF),
        ),
      ),
      label: 'Calculator', // Add label for the Calculator item
    ),
    BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          child: Icon(Icons.info),
          backgroundColor: Color(0xFF5271FF),
        ),
      ),
      label: 'About', // Add label for the About item
    ),
    BottomNavigationBarItem(
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: CircleAvatar(
          child: Icon(Icons.contacts),
          backgroundColor: Color(0xFF5271FF),
        ),
      ),
      label: 'Contact', // Add label for the Contact item
    ),
  ],
        selectedItemColor: Color(0xFF5271FF),
        currentIndex: _selectedIndex,
        onTap: (int index) {
          // if (index == 0) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => AdminHome(user: widget.user)),
          //   );
          // } else if (index == 1) {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => CalculatorScreen(user: widget.user)),
          //   );
          // } else if (index == 2) {
          //   Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => AboutUs(user :widget.user)),
          //       );
          // }
          // else if (index == 3) {
          //   Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => ContactList(user :widget.user)),
          //       );
          // }
        },
      ),
    ),
    );
  }
}
