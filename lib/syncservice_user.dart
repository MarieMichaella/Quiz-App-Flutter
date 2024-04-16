import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizapp/database/database_service.dart';
import 'package:quizapp/model/user.dart'; 
import 'package:quizapp/user_db.dart';

class UserSyncService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserDB _userDB = UserDB();

Future<void> saveUserToSQLite(Users user) async {
  final database = await DatabaseService().database;
  await database.transaction((txn) async {
    await txn.rawInsert('''
      INSERT OR REPLACE INTO user (id,email, password) 
      VALUES (?, ?, ?)
    ''', [user.id, user.email, user.password]);
  });
}

Future<Users?> fetchUserFromSQLite(String email) async {
  try {
    final List<Users> usersFromSQLite = await getAllUsersFromSQLite();
    if (usersFromSQLite.isNotEmpty) {
      final existingUser = usersFromSQLite.firstWhere(
        (user) => user.email == email,

      );
      return existingUser;
    } else {
      print("No users found in SQLite.");
      return null;
    }
  } catch (error) {
    print("Error fetching user from SQLite: $error");
    return null;
  }
}

Future<Users?> fetchUserFromFirebase(String uid) async {
  try {
    final DocumentSnapshot docSnapshot = await _firestore.collection('users').doc(uid).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      return Users(
        id: docSnapshot.id,
        email: data['email'],
        password: data['password'], // Consider not storing password in Firestore for security reasons
      );
    } else {
      print("User document not found in Firestore for ID: $uid");
      return null;
    }
  } catch (error) {
    print("Error fetching user from Firestore: $error");
    return null;
  }
}




  Future<List<Users>> getAllUsersFromSQLite() async {
    final database = await DatabaseService().database;
    final List<Map<String, dynamic>> maps = await database.query('user');
    return List.generate(maps.length, (i) {
      return Users(
        id: maps[i]['id'],
        email: maps[i]['email'],
        password: maps[i]['password'],
      );
    });
  }



Future<Users?> signInWithEmailAndPassword(String email, String password) async {
  try {
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User? firebaseUser = userCredential.user;
    if (firebaseUser != null) {
      final Users user = Users(
        id: firebaseUser.uid, 
        email: firebaseUser.email ?? '',
        password: password,
      );
      final List<Users> usersFromSQLite = await UserDB().getAllUsers();
      if (usersFromSQLite.isNotEmpty) { 
        final existingUser = usersFromSQLite.firstWhere(
          (user) => user.email == email && user.password == password,
          // orElse: () => null, // Return null if no matching user is found
        );
        if (existingUser != null) {
          return existingUser;
        } else {
          print("User not found in SQLite.");
          return null;
        }
      } else {
        print("No users found in SQLite.");
        return null;
      }
    } else {
      print("Firebase authentication failed.");
      return null;
    }
  } catch (error) {
    print("Error signing in: $error");
    return null;
  }
}


// Future<Users?> signInWithEmailAndPassword(String email, String password) async {
//   try {
//     final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     final User? firebaseUser = userCredential.user;
//     if (firebaseUser != null) {
//       final Users user = Users(
//         id: firebaseUser.uid,
//         email: firebaseUser.email ?? '',
//         password: password,
//       );

//       bool isConnected = await InternetConnectionChecker().hasConnection;

//       if (isConnected) {
//         // Online sign-in
//         final Users? onlineUser = await _userSyncService.signInWithEmailAndPassword(email, password);
//         if (onlineUser != null) {
//           // Save user to SQLite if signed in online
//           await _userSyncService.saveUserToSQLite(onlineUser);
//           return onlineUser;
//         } else {
//           print("Error signing in online.");
//           return null;
//         }
//       } else {
//         // Offline sign-in
//         final Users? offlineUser = await _userSyncService.fetchUserFromSQLite(email);
//         if (offlineUser != null && offlineUser.password == password) {
//           return offlineUser;
//         } else {
//           print("Error signing in offline.");
//           return null;
//         }
//       }
//     } else {
//       print("Firebase authentication failed.");
//       return null;
//     }
//   } catch (error) {
//     print("Error signing in: $error");
//     return null;
//   }
// }





Future<Users?> signUpWithEmailAndPassword(String id, String email, String password) async {
  try {
    final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User? firebaseUser = userCredential.user;
    
    if (firebaseUser != null) {
      Users newUser = Users(id: id, email: email, password: password);
      await UserDB().createUser(id: id, email: email, password: password);
      return newUser;
    } else {
      print("Firebase authentication failed.");
      return null;
    }
  } catch (error) {
    print("Error signing up: $error");
    return null;
  }
}


  Future<void> saveUserToFirestore(Users user) async {
    await _firestore.collection('users').add(user.toMap());
  }

  Future<List<Users>> getAllUsersFromFirestore() async {
    final querySnapshot = await _firestore.collection('users').get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Users(
        id: doc.id,
        email: data['email'],
        password: data['password'],
      );
    }).toList();
  }


}







// Future<Users?> signInWithEmailAndPassword(String email, String password) async {
//   try {
//     final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     final User? firebaseUser = userCredential.user;
//     if (firebaseUser != null) {
//       final Users user = Users(
//         id: firebaseUser.uid, 
//         email: firebaseUser.email ?? '',
//         password: password, 
//       );
//       return user;
//     } else {
//       print("Firebase authentication failed.");
//       return null;
//     }
//   } catch (error) {
//     print("Error signing in: $error");
//     return null;
//   }
// }




  // // Firebase authentication methods
  // Future<User?> signInWithEmailAndPassword(String email, String password) async {
  //   try {
  //     final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     final User? user = userCredential.user;
  //     return user;
  //   } catch (error) {
  //     print("Error signing in: $error");
  //     return null;
  //   }
  // }

// Future<Users?> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       final User? user = userCredential.user;
//       if (user != null) {
//         // Check SQLite for user data
//         final List<Users> usersFromSQLite = await getAllUsersFromSQLite();
//         final existingUser = usersFromSQLite.firstWhere(
//           (user) => user.email == email && user.password == password,
//           // orElse: () => null,
//         );
//         if (existingUser != null) {
//           return existingUser;
//         } else {
//           print("User not found in SQLite.");
//           return null;
//         }
//       } else {
//         print("Firebase authentication failed.");
//         return null;
//       }
//     } catch (error) {
//       print("Error signing in: $error");
//       return null;
//     }
//   }

// Future<Users?> signInWithEmailAndPassword(String email, String password) async {
//   try {
//     final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     final User? user = userCredential.user;
//     if (user != null) {
//       // Check SQLite for user data
//       final List<Users> usersFromSQLite = await UserDB().getAllUsers();
//       if (usersFromSQLite.isNotEmpty) { // Check if list is not empty
//         final existingUser = usersFromSQLite.firstWhere(
//           (user) => user.email == email && user.password == password,
//           // orElse: () => null, // Return null if no matching user is found
//         );
//         if (existingUser != null) {
//           return existingUser;
//         } else {
//           print("User not found in SQLite.");
//           return null;
//         }
//       } else {
//         print("No users found in SQLite.");
//         return null;
//       }
//     } else {
//       print("Firebase authentication failed.");
//       return null;
//     }
//   } catch (error) {
//     print("Error signing in: $error");
//     return null;
//   }
// }


  // // SQLite methods for User
  // Future<void> saveUserToSQLite(Users user) async {
  //   final database = await DatabaseService().database;
  //   await database.insert('users', user.toMap());
  // }

//   Future<void> saveUserToSQLite(Users user) async {
//   final database = await DatabaseService().database;
//   await UserDB().createTable(database); // Ensure table creation
//   await database.insert('users', user.toMap());
// }