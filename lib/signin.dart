import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quizapp/authservice.dart';
import 'package:quizapp/signup.dart';
import 'api/google_signin_api.dart';
import 'homescreen.dart';

// class SignInScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign In'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               // Navigator.pushReplacement(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => HomeScreen()),
//               // );
//             },
//             child: Text('Home'),
//             style: TextButton.styleFrom(
//               primary: Theme.of(context).brightness == Brightness.dark
//                   ? Colors.white
//                   : Colors.black,
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Welcome Back!',
//               style: TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 20.0),
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 prefixIcon: Icon(Icons.email),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 prefixIcon: Icon(Icons.lock),
//               ),
//               obscureText: true,
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () {
//                 // Perform sign-in action
//               },
//               child: Text('Sign In'),
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton.icon(
//               onPressed: () {
//                 signIn(context); // Call the signin function directly
//               },
//               icon: Icon(Icons.account_circle),
//               label: Text('Sign In with Google'),
//               style: ElevatedButton.styleFrom(
//                 primary: Color(0xFF5271FF), 
//                 onPrimary: Colors.white,
//               ),
//             ),
//             SizedBox(height: 20.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Don't have an account?"),
//                 TextButton(
//                   onPressed: () {
//                     // // Navigate to sign-up screen
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(builder: (context) => SignUpScreen()),
//                     // );
//                   },
//                   child: Text('Sign up'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future signIn(BuildContext context) async {
//     final user = await GoogleSignInApi.login();

//     if (user == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Sign in failed')),
//       );
//     } else {
// Navigator.of(context).pushReplacement(
//   MaterialPageRoute(
//     builder: (context) => HomeScreen(user: user),
//   ),
// );



//     }
//   }
// }

// class SignUpScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               // Navigator.pushReplacement(
//               //   context,
//               //   MaterialPageRoute(builder: (context) => HomeScreen()),
//               // );
//             },
//             child: Text('Home'),
//             style: TextButton.styleFrom(
//               primary: Theme.of(context).brightness == Brightness.dark
//                   ? Colors.white
//                   : Colors.black,
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Create an account',
//               style: TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 20.0),
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 prefixIcon: Icon(Icons.email),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 prefixIcon: Icon(Icons.lock),
//               ),
//               obscureText: true,
//             ),
//             SizedBox(height: 20.0),
//             TextFormField(
//               decoration: InputDecoration(
//                 labelText: 'Confirm Password',
//                 prefixIcon: Icon(Icons.lock),
//               ),
//               obscureText: true,
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () {
//                 // Perform sign-up action
//               },
//               child: Text('Sign Up'),
//             ),
//             SizedBox(height: 20.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Already have an account?'),
//                 TextButton(
//                   onPressed: () {
//                     // Navigate to sign-in screen
//                     Navigator.pop(context);
//                   },
//                   child: Text('Sign in'),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton.icon(
//               onPressed: () {
//                 signIn(context); // Pass the current context to signIn function
//               },
//               icon: Icon(Icons.account_circle),
//               label: Text('Sign In with Google'),
//               style: ElevatedButton.styleFrom(
//                 primary: Color(0xFF5271FF), 
//                 onPrimary: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future signIn(BuildContext context) async {
//     final user = await GoogleSignInApi.login();

//     if (user == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Sign in failed')),
//       );
//     } else {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => HomeScreen(user: user),
//         ),
//       );
//     }
//   }
// }



// import 'package:navigations/model/user.dart';
// import 'package:navigations/syncservice_user.dart';
// import 'package:navigations/quizlist.dart';
// import 'package:navigations/home.dart';
// import 'package:navigations/savequiz.dart';
// import 'package:uuid/uuid.dart';
// import 'package:navigations/adminhome.dart';
// import 'package:navigations/model/user.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// class SignInScreen extends StatefulWidget {

//   const SignInScreen({super.key});
//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final UserSyncService _userSyncService = UserSyncService();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       body: Stack(
      
//       children: [
//         Container(
//           decoration: BoxDecoration(
            
//                             image: DecorationImage(
//                 image: AssetImage('assets/images/signin.png'),
//                 fit: BoxFit.cover,
//         )
//           )
//     ),
      
//         SingleChildScrollView(
          
//           child: Padding(
//             padding: EdgeInsets.only(top: 160.0, right: 20.0, left:20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Sign In',
//                   style: TextStyle(
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 40.0),
// Container(
//   width:330,
//   child: TextFormField(
//     controller: emailController,
//     decoration: InputDecoration(
  
//       labelText: 'Enter email',
//       prefixIcon: Icon(Icons.email, color: Colors.black), 
//       filled: true,
//       fillColor: Colors.white, 
//           border: OutlineInputBorder( 
//         borderRadius: BorderRadius.circular(10.0),
//         borderSide: BorderSide(color: Colors.black, width: 1),
//       ),
//       contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), 
//     ),
//     style: TextStyle(color: Colors.black), 
//   ),
// ),


//                 SizedBox(height: 20.0),
//                 Container(
//                   width:330,
//                   child: TextFormField(
                    
//                     controller: passwordController,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                             prefixIcon: Icon(Icons.email, color: Colors.black), 
//       filled: true,
//       fillColor: Colors.white, 
//           border: OutlineInputBorder( 
//         borderRadius: BorderRadius.circular(10.0),
//         borderSide: BorderSide(color: Colors.black, width: 1),
//       ),
//       contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), 
//                     ),
//                     obscureText: true,
//                   ),
//                 ),
//                 SizedBox(height: 30.0),
//         ElevatedButton(
//           onPressed: () async {
//             String email = emailController.text;
//             String password = passwordController.text;
        
//             if (email == 'michaadmin@gmail.com' && password == 'micha123') {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => AdminHome(), 
//           ),
//         );
//             } else {
//         try {
//           Users? user = await _userSyncService.signInWithEmailAndPassword(email, password);
//           if (user != null) {
//             await _userSyncService.saveUserToSQLite(user);
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Signed in successfully as ${user.email}'),
//               ),
//             );
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => HomeScreen(user: user),
//               ),
//             );
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Failed to sign in. Please check your credentials.'),
//               ),
//             );
//           }
//         } catch (error) {
//           print('Error signing in: $error');
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('An error occurred while signing in. Please try again later.'),
//             ),
//           );
//         }
//             }
//           },
//             style: ElevatedButton.styleFrom(
              
//     primary: Color(0xFF705AFA), 
//     onPrimary: Colors.white, 
//     minimumSize: Size(200, 50), 
//     padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), 
    
//   ),
//             child: Text(
//     'Sign In',
//     style: TextStyle(
//       fontSize: 16.0,
//       fontWeight: FontWeight.bold,
//       letterSpacing: 1.2,
//       color: Colors.white,


//     ),
//   ),
//         ),
        
        
//                 SizedBox(height: 30.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Don't have an account?"),
//                     TextButton(
//                       onPressed: () {
//                         // Navigate to sign-up screen
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => SignUpScreen()),
//                         );
//                       },
//                       child: Text('Sign up'),
//                     ),
//                   ],
//                 ),
//                             SizedBox(height: 30.0),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   signIn(context); // Pass the current context to signIn function
//                 },
//                 icon: Icon(Icons.account_circle),
//                 label: Text('Sign In with Google'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.white, 
//                   onPrimary: Colors.black,
//                 ),
//               ),
//               ],
//             ),
//           ),
//         ),
//         ]
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:quizapp/model/user.dart';
import 'package:quizapp/syncservice_user.dart';
import 'package:quizapp/quizlist.dart';
import 'package:quizapp/home.dart';
import 'package:quizapp/savequiz.dart';
import 'package:uuid/uuid.dart';
import 'package:quizapp/adminhome.dart';
import 'package:quizapp/model/user.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/services.dart';
import 'package:quizapp/auth_servicete.dart';
import 'dart:async';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();

  static GlobalKey<_SignInScreenState> signInScreenStateKey = GlobalKey<_SignInScreenState>();
}

class _SignInScreenState extends State<SignInScreen> {
    final AuthService _authService = AuthService();
  final UserSyncService _userSyncService = UserSyncService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  User? user;
  GoogleSignInAccount? googleUser;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  void _checkCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final currentGoogleUser = await GoogleSignIn().signInSilently();

    setState(() {
      user = currentUser;
      googleUser = currentGoogleUser;
    });

  }

  Future<void> _signOut() async {
    if (user != null) {
      await FirebaseAuth.instance.signOut();
      setState(() {
        user = null;
      });
    }

    if (googleUser != null) {
      await GoogleSignIn().signOut();
      setState(() {
        googleUser = null;
      });
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SignInScreen()),
    );
  }
  


Future<void> _signInWithGoogle() async {
  try {
    
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    await _googleSignIn.signOut();

    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        await _userSyncService.saveUserToSQLite(
          Users(
            id: user.uid,
            email: user.email ?? '',
            password: '',
          ),
        );
        _navigateToHomeScreen(user);
      }
    }
  } catch (e) {
  print('Error signing in with Google: $e');
  if (e is PlatformException) {
    print('PlatformException Code: ${e.code}');
    print('PlatformException Details: ${e.details}');
    print('PlatformException Message: ${e.message}');
  }
}
}

void _navigateToHomeScreen(User user) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => HomeScreen(
        user: Users(
          id: user.uid,
          email: user.email ?? '',
          password: '',
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/signin.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 160.0, right: 20.0, left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Container(
                    width: 330,
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Enter email',
                          prefixIcon: Icon(Icons.email, color: Colors.black),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.black, width: 1),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        ),
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          // Trim leading and trailing whitespace characters
                          String trimmedValue = value.trim();
                          // Now use trimmedValue for further processing or validation
                        },
                      ),

                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: 330,
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock, color: Colors.black), // Changed the icon to lock for password
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        // Trim leading and trailing whitespace characters
                        String trimmedValue = value.trim();
                        // Now use trimmedValue for further processing or validation
                      },
                    ),

                  ),
                  SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () async {
                      String email = emailController.text;
                      String password = passwordController.text;
                                  if (email == 'michaadmin@mailsac.com' && password == 'micha123') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminHome(), 
          ),
        );
            } else {
                      bool isConnected = await InternetConnectionChecker().hasConnection;

                      if (isConnected) {
                        try {
          Users? user = await _userSyncService.signInWithEmailAndPassword(email, password);
          if (user != null) {
            await _userSyncService.saveUserToSQLite(user);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Signed in successfully as ${user.email}'),
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(user: user),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to sign in. Please check your credentials.'),
              ),
            );
          }
                        } catch (error) {
                          print('Error signing in with Firebase: $error');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Failed to sign in. Please check your credentials.'),
                            ),
                          );
                        }
                      } else {
                        // Check for user credentials in SQLite if offline
                        Users? user = await _userSyncService.fetchUserFromSQLite(email);
                        if (user != null && user.password == password) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Signed in successfully (offline) as ${user.email}'),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(user: user),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Invalid credentials or user not found offline.'),
                            ),
                          );
                        }
                      }
            }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF705AFA),
                      onPrimary: Colors.white,
                      minimumSize: Size(200, 50),
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    ),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpScreen()),
                          );
                        },
                        child: Text('Sign up'),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  ElevatedButton.icon(
                    onPressed: _signInWithGoogle,
                    icon: Image.asset(
                      'assets/images/icons8-google-24.png', 
                      width: 24,
                      height: 24,
                      color: Colors.black, 
                    ),
                    label: Text('Sign In with Google'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                    ),
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



