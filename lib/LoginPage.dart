// import 'package:navigations/homescreen.dart';
// import 'package:navigations/model/user.dart';
// import 'package:navigations/signin.dart';
// import 'package:navigations/syncservice_user.dart';
// import 'package:navigations/quizlist.dart';
// import 'package:navigations/home.dart';
// import 'package:navigations/savequiz.dart';
// import 'package:uuid/uuid.dart';
// import 'package:navigations/adminhome.dart';
// import 'package:navigations/model/user.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';



// class LoginPage extends StatefulWidget {

//   const LoginPage({super.key});
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {

//   final UserSyncService _userSyncService = UserSyncService();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//     String token = 'uTwbhjsbnsdniubbhJnnsbWhhsW';

//   StoredToken() async{
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('token', '${token}');
//   }

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
//                 image: AssetImage('assets/images/signin.png'), // Replace with your background image path
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
//       fillColor: Colors.grey.shade200, 
//           border: OutlineInputBorder( 
//         borderRadius: BorderRadius.circular(10.0),
//         borderSide: BorderSide.none, 
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
//       fillColor: Colors.grey.shade200, 
//           border: OutlineInputBorder( 
//         borderRadius: BorderRadius.circular(10.0),
//         borderSide: BorderSide.none, 
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
//             StoredToken();
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
//           // Log the error here
//           print('Error signing in: $error');
//           // You can also show an error message to the user if needed
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
