// import 'package:flutter/material.dart';
// import 'package:navigations/authservice.dart';

// class SignInScreen1 extends StatefulWidget {
//   const SignInScreen1({Key? key}) : super(key: key);

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen1> {
//   final AuthService _authService = AuthService();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign In'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   prefixIcon: Icon(Icons.email),
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   prefixIcon: Icon(Icons.lock),
//                 ),
//                 obscureText: true,
//               ),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: () async {
//                   String email = _emailController.text;
//                   String password = _passwordController.text;

//                   bool isLoggedIn = await _authService.login(email, password);
//                   if (isLoggedIn) {
//                     // Navigate to home screen or any other screen
//                     Navigator.pushReplacementNamed(context, '/home');
//                   } else {
//                     // Show error message or handle unsuccessful login
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Invalid email or password.'),
//                       ),
//                     );
//                   }
//                 },
//                 child: Text('Sign In'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:navigations/authservice.dart';



// class SignInScreen1 extends StatefulWidget {
//   const SignInScreen1({Key? key}) : super(key: key);

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen1> {
//   final AuthService _authService = AuthService();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign In'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   prefixIcon: Icon(Icons.email),
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   prefixIcon: Icon(Icons.lock),
//                 ),
//                 obscureText: true,
//               ),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: () async {
//                   String email = _emailController.text;
//                   String password = _passwordController.text;

//                   bool isLoggedIn = await _authService.login(email, password);
//                   if (isLoggedIn) {
//                     // Navigate to home screen or any other screen
//                     Navigator.pushReplacementNamed(context, '/home');
//                   } else {
//                     // Show error message or handle unsuccessful login
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Invalid email or password.'),
//                       ),
//                     );
//                   }
//                 },
//                 child: Text('Sign In'),
//               ),
//               SizedBox(height: 20.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Don't have an account?"),
//                   TextButton(
//                     onPressed: () {
//                       // Navigate to sign-up screen
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => SignUpScreen1()),
//                       );
//                     },
//                     child: Text('Sign up'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// class SignUpScreen1 extends StatefulWidget {
//   const SignUpScreen1({Key? key}) : super(key: key);

//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen1> {
//   final AuthService _authService = AuthService();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   prefixIcon: Icon(Icons.email),
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   prefixIcon: Icon(Icons.lock),
//                 ),
//                 obscureText: true,
//               ),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: () async {
//                   String email = _emailController.text;
//                   String password = _passwordController.text;

//                   bool isSignedUp = await _authService.signUp(email, password);
//                   if (isSignedUp) {
//                     // Navigate to sign-in screen or any other screen
//                     Navigator.pushReplacementNamed(context, '/signin');
//                   } else {
//                     // Show error message or handle unsuccessful signup
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('Email already exists or signup failed.'),
//                       ),
//                     );
//                   }
//                 },
//                 child: Text('Sign Up'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }