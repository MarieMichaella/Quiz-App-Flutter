// import 'package:flutter/material.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffedf3f6),
//       body: SingleChildScrollView(
//         child: Container(

        //   margin:EdgeInsets.only(bottom: 30.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Stack(
        //         children:[ Container(
        //           height: 220,
        //           padding: EdgeInsets.only(left: 20.0, top: 50.0),
        //           decoration: BoxDecoration(
        //             color: Color(0xFF2a2b31), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
        //           ),
        //           child: Row (
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             ClipRRect(
        //               borderRadius: BorderRadius.circular(60),
        //               child: Image.asset(
        //                 "images/assets/Icon.png", 
        //                 height: 50, 
        //                 width:50, 
        //                 fit: BoxFit.cover,
        //                 )),
        //                 SizedBox(width: 20.0,),
        //                 Padding(
        //                   padding: const EdgeInsets.only(top: 10.0),
        //                   child: Text("Marie Michaella", style: TextStyle(color: Colors.white, fontSize:20.0, fontWeight: FontWeight.bold ),),
        //                 )
        //           ]),
        //         ),
        //         Container(
        //           height:170,
        //           width: MediaQuery.of(context).size.width,
        //           decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)), 
        //           margin: EdgeInsets.only(top: 120.0, left: 20.0, right: 20.0),
        //           child: Row(
        //             children: [
        //               ClipRRect(
        //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        //                 child: Image.asset("images/assets/Icon.png")),
        //                 SizedBox(width: 30.0),
        //                 Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Text("Play and Win", style: TextStyle(color: Colors.white, fontSize:20.0, fontWeight: FontWeight.bold ),),
        //                     Text("Play Quiza by guessing\n the image", style: TextStyle(color: Color(0xFFa4a4a4), fontSize:15.0, fontWeight: FontWeight.w500 ),),
        //                   ],
        //                 ),
            
        //             ]
        //           )
        //         )
        //         ]),
        //         SizedBox(height: 30.0),
        //         Padding(
        //           padding: const EdgeInsets.only(left: 20.0),
        //           child: Text("Top quiz Categories", style: TextStyle(color: Colors.black, fontSize:23.0, fontWeight: FontWeight.w500 ),),
        //         ),
        //         SizedBox(height: 20.0,),
        //         Padding(
        //           padding: const EdgeInsets.only(left:20.0, right: 20.0),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             children: [
        //             Material(
        //               borderRadius:BorderRadius.circular(20),
        //               elevation: 5.0,
        //               child: Container(
        //                 width: 150,
        //                 padding: EdgeInsets.all(10),
        //                 decoration: BoxDecoration(color: Colors.white, borderRadius:BorderRadius.circular(20)),
        //                 child: Column(
        //                   children: [
        //                     Image.asset(
        //                       "images/assets/Icon.png", 
        //                       height: 80, 
        //                       width: 80, 
        //                       fit:BoxFit.cover,
        //                       ),
        //                     SizedBox(
        //                       height:20.0
        //                       ),
        //                     Text(
        //                       "Animals", 
        //                       style: TextStyle(
        //                         color: Colors.black, 
        //                         fontSize:22.0, 
        //                         fontWeight: FontWeight.w500 ),),
        //                   ],
        //                 )),
        //             ),
        //               Material(
        //               borderRadius:BorderRadius.circular(20),
        //               elevation: 5.0,
        //               child: Container(
        //                 width: 150,
        //                 padding: EdgeInsets.all(10),
        //                 decoration: BoxDecoration(color: Colors.white, borderRadius:BorderRadius.circular(20)),
        //                 child: Column(
        //                   children: [
        //                     Image.asset(
        //                       "images/assets/Icon.png", 
        //                       height: 80, 
        //                       width: 80, 
        //                       fit:BoxFit.cover,
        //                       ),
        //                     SizedBox(
        //                       height:20.0
        //                       ),
        //                     Text(
        //                       "Place", 
        //                       style: TextStyle(
        //                         color: Colors.black, 
        //                         fontSize:22.0, 
        //                         fontWeight: FontWeight.w500 ),),
        //                   ],
        //                 )),
        //             ),
        
        //           ],),
        //         ),
        //         SizedBox(height: 20.0,),
        //         Padding(
        //           padding: const EdgeInsets.only(left:20.0, right: 20.0),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             children: [
        //             Material(
        //               borderRadius:BorderRadius.circular(20),
        //               elevation: 5.0,
        //               child: Container(
        //                 width: 150,
        //                 padding: EdgeInsets.all(10),
        //                 decoration: BoxDecoration(color: Colors.white, borderRadius:BorderRadius.circular(20)),
        //                 child: Column(
        //                   children: [
        //                     Image.asset(
        //                       "images/assets/Icon.png", 
        //                       height: 80, 
        //                       width: 80, 
        //                       fit:BoxFit.cover,
        //                       ),
        //                     SizedBox(
        //                       height:20.0
        //                       ),
        //                     Text(
        //                       "Animals", 
        //                       style: TextStyle(
        //                         color: Colors.black, 
        //                         fontSize:22.0, 
        //                         fontWeight: FontWeight.w500 ),),
        //                   ],
        //                 )),
        //             ),
        //               Material(
        //               borderRadius:BorderRadius.circular(20),
        //               elevation: 5.0,
        //               child: Container(
        //                 width: 150,
        //                 padding: EdgeInsets.all(10),
        //                 decoration: BoxDecoration(color: Colors.white, borderRadius:BorderRadius.circular(20)),
        //                 child: Column(
        //                   children: [
        //                     Image.asset(
        //                       "images/assets/Icon.png", 
        //                       height: 80, 
        //                       width: 80, 
        //                       fit:BoxFit.cover,
        //                       ),
        //                     SizedBox(
        //                       height:20.0
        //                       ),
        //                     Text(
        //                       "Place", 
        //                       style: TextStyle(
        //                         color: Colors.black, 
        //                         fontSize:22.0, 
        //                         fontWeight: FontWeight.w500 ),),
        //                   ],
        //                 )),
        //             ),
        //           ],),
        //         ),
        //         SizedBox(height: 20.0,),
        //         Padding(
        //           padding: const EdgeInsets.only(left:20.0, right: 20.0),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             children: [
        //             Material(
        //               borderRadius:BorderRadius.circular(20),
        //               elevation: 5.0,
        //               child: Container(
        //                 width: 150,
        //                 padding: EdgeInsets.all(10),
        //                 decoration: BoxDecoration(color: Colors.white, borderRadius:BorderRadius.circular(20)),
        //                 child: Column(
        //                   children: [
        //                     Image.asset(
        //                       "images/assets/Icon.png", 
        //                       height: 80, 
        //                       width: 80, 
        //                       fit:BoxFit.cover,
        //                       ),
        //                     SizedBox(
        //                       height:20.0
        //                       ),
        //                     Text(
        //                       "Animals", 
        //                       style: TextStyle(
        //                         color: Colors.black, 
        //                         fontSize:22.0, 
        //                         fontWeight: FontWeight.w500 ),),
        //                   ],
        //                 )),
        //             ),
        //               Material(
        //               borderRadius:BorderRadius.circular(20),
        //               elevation: 5.0,
        //               child: Container(
        //                 width: 150,
        //                 padding: EdgeInsets.all(10),
        //                 decoration: BoxDecoration(color: Colors.white, borderRadius:BorderRadius.circular(20)),
        //                 child: Column(
        //                   children: [
        //                     Image.asset(
        //                       "images/assets/Icon.png", 
        //                       height: 80, 
        //                       width: 80, 
        //                       fit:BoxFit.cover,
        //                       ),
        //                     SizedBox(
        //                       height:20.0
        //                       ),
        //                     Text(
        //                       "Place", 
        //                       style: TextStyle(
        //                         color: Colors.black, 
        //                         fontSize:22.0, 
        //                         fontWeight: FontWeight.w500 ),),
        //                   ],
        //                 )),
        //             ),
        //           ],),
        //         )
        //     ],
        //   ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:quizapp/savequiz.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffedf3f6),
//       body: SingleChildScrollView(
//         child: Container(
//           // Add a button to navigate to the quiz page
//           child: ElevatedButton(
//             onPressed: () {
//               // Navigate to the quiz page
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => CreateQuizScreen()),
//               );
//             },
//             child: Text('Start Quiz'), // Button text
//           ),

//           child: ElevatedButton(
//             onPressed: () {
//               // Navigate to the quiz page
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => CreateQuizScreen()),
//               );
//             },
//             child: Text('Start Quiz'), // Button text
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:quizapp/savequiz.dart';
// import 'package:quizapp/quizlist.dart';
// import 'package:quizapp/model/user.dart';

// class Home extends StatefulWidget {
//   // const Home({Key? key}) : super(key: key);
//   late Users user;
//   const Home({Key? key, required this.user,}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffedf3f6),
//       body: SingleChildScrollView(
//         child: Container(
//           // Wrap the ElevatedButton widgets with a Column
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   // Navigate to the quiz page
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => CreateQuizScreen()),
//                   );
//                 },
//                 child: Text('Start Quiz'), // Button text
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   // Navigate to the quiz page
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => QuizListScreen(user: user)),
//                   );
//                 },
//                 child: Text('Quiz List'), // Button text
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:quizapp/model/syncModel.dart'; // Import your Quiz model class
// import 'package:quizapp/questionList.dart'; // Import the QuestionListScreen
// import 'package:quizapp/syncservices.dart';
// import 'package:quizapp/model/user.dart';

// class Home extends StatefulWidget {
//   final Users user;
//   final Quiz quiz;

//   const Home({Key? key, required this.user, required this.quiz}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   late Future<List<Question>> _questionsFuture;
//   int _currentPageIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _questionsFuture = SyncService().getAllQuestionsFromSQLiteForQuiz(widget.quiz);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffedf3f6),
//       body: SingleChildScrollView(
//         child: Container(
//           // Wrap the ElevatedButton widgets with a Column
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   // Navigate to the question list page
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => QuestionListScreen(user: widget.user, quiz: widget.quiz)),
//                   );
//                 },
//                 child: Text('Start Quiz'), // Button text
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:quizapp/homescreen.dart';
import 'package:quizapp/user_answer.dart';
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
import 'package:quizapp/deletedItem.dart';
import 'package:quizapp/simple_map_screen.dart';



class Home extends StatefulWidget {
  final Users user;
  final GoogleSignIn? googleSignIn;

  const Home({Key? key, required this.user, this.googleSignIn}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    Uint8List? _selectedImageBytes;
  File ? _selectedImage;
  int _selectedIndex = 0;
  String _connectionStatus = 'Unknown';
  int _currentIndex = 0;
  GoogleSignIn? _googleSignIn;

    @override
  void initState() {
    super.initState();
    _googleSignIn = widget.googleSignIn;
  }


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
      await AnswerDB().clearSyncStatus();
      await QuestionDB().clearSyncStatus();
      await QuizDB().clearSyncStatus();
      await UserAnswerDB().clearSyncStatus();
      await DeleteItemsFromFirestore().deleteFromFirestore();
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

    bool isGoogleUser = _googleSignIn != null && _googleSignIn!.currentUser != null;
    return Scaffold(
      backgroundColor: Colors.white,
body: SingleChildScrollView(
child: Center(
  child: Padding(
    padding: const EdgeInsets.only(top: 120),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        isGoogleUser
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizListScreen(user: widget.user),
                            ),
                          );
                        },
                        child: Text('Quiz List'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(300, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      )
                    : Container(),
                SizedBox(height: 20),
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizListScreen(user: widget.user)),
    );
  },
  child: Text('Quiz List'),
  style: ElevatedButton.styleFrom(
    minimumSize: Size(300, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    textStyle: TextStyle(fontSize: 18),
  ),
),
// SizedBox(height: 20),
// ElevatedButton(
//   onPressed: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CreateQuizScreen()),
//     );
//   },
//   child: Text('Create Quiz'),
//   style: ElevatedButton.styleFrom(
//     minimumSize: Size(300, 50),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(15),
//     ),
//     textStyle: TextStyle(fontSize: 18),
//   ),
// ),
// SizedBox(height: 20),
// ElevatedButton(
//   onPressed: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => QuizListPage()),
//     );

//   },
//   child: Text('Quiz List'),
//   style: ElevatedButton.styleFrom(
//     minimumSize: Size(300, 50),
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(15),
//     ),
//     textStyle: TextStyle(fontSize: 18),
//   ),
// ),

        SizedBox(height: 20), 
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AnswerListScreen(loggedInUser: widget.user),
              ),
            );
          },
          child: Text('Answer List'),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(300, 50),
            shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(15), 
            ),
            textStyle: TextStyle(fontSize: 18), 
          ),
        ),      
        // SizedBox(height: 20),
        // ElevatedButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => QuizListPage(),
        //       ),
        //     );
        //   },
          
        //   child: Text('Modify Quiz'),
        //   style: ElevatedButton.styleFrom(
        //     minimumSize: Size(300, 50),
        //     shape: RoundedRectangleBorder(
        //        borderRadius: BorderRadius.circular(15),
        //     ),
        //     textStyle: TextStyle(fontSize: 18)
        //   ),
        // ),
        //         SizedBox(height: 20),
        // ElevatedButton(
        //   onPressed: _syncAllUnsyncedData,
        //   child: Text('Sync with Firestore'),
        //   style: ElevatedButton.styleFrom(
        //     minimumSize: Size(300, 50), 
        //     shape: RoundedRectangleBorder(
        //        borderRadius: BorderRadius.circular(15), 
        //     ),
        //     textStyle: TextStyle(fontSize: 18)
        //   ),
        // ),

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
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(user: widget.user)),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalculatorScreen(user: widget.user)),
            );
          } else if (index == 2) {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUs(user :widget.user)),
                );
          }
          else if (index == 3) {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactList(user :widget.user)),
                );
          }
        },
      ),
    ),
    );
  }
}
