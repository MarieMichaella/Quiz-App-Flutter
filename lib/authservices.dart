// import 'package:firebase_auth/firebase_auth.dart'; 
// import 'package:navigations/model/user.dart';
// import 'package:navigations/syncservice_user.dart';
// import 'package:navigations/quizlist.dart';
// import 'package:navigations/home.dart';
// import 'package:navigations/savequiz.dart';
// import 'package:uuid/uuid.dart';
// import 'package:navigations/adminhome.dart';
// import 'package:navigations/model/user.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:flutter/services.dart';


// class AuthService {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final Firestore _db = Firestore.instance;

//   Observable<FirebaseUser> user;
//   Observable<Map<String, dynamic>> profile;
//   PublishSubject loading = PublishSubject();

//   AuthService() {
//     user = Observable(_auth.onAuthStateChanged);
//     profile = user.switchMap((FirebaseUser user) {
//       if (user != null) {
//         return _db
//             .collection('user')
//             .document(user.uid)
//             .snapshots()
//             .map((snap) => snap.data);
//       } else {
//         return Observable.just({});
//       }
//     });
//   }

//   Future<FirebaseUser> googleSignIn() async {
//     loading.add(true);
//     GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//     GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//     // FirebaseUser user = await _auth.signInWithGoogle(
//         // accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
//     final AuthCredential credential = GoogleAuthProvider.getCredential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//     FirebaseUser user = await _auth.signInWithCredential(credential);
//     updateUserData(user);
//     print("Sign in" + user.displayName);

//     loading.add(false);

//     return user;
//   }
// }