// import 'package:navigations/user_db.dart';
// import 'package:navigations/model/user.dart';

// class AuthService {
//   final UserDB _userDB = UserDB();

//   Future<bool> login(String email, String password) async {
//     Users? user = await _userDB.getUserByEmail(email);
//     if (user != null && user.password == password) {
//       // User found and password matches, login successful
//       return true;
//     } else {
//       // User not found or password does not match, login failed
//       return false;
//     }
//   }


//   Future<bool> signUp(String email, String password) async {
//     // Check if user already exists
//     Users? existingUser = await _userDB.getUserByEmail(email);
//     if (existingUser != null) {
//       // User already exists, signup failed
//       return false;
//     }

//     // Generate a unique ID for the user
//     String id = UniqueKey().toString();

//     // Create user and save to database
//     Users newUser = Users(id: id, email: email, password: password);
//     int result = await _userDB.createUser(
//       id: newUser.id,
//       email: newUser.email,
//       password: newUser.password,
//     );

//     return result > 0; // Return true if user creation was successful
//   }
// }



// import 'package:navigations/user_db.dart';
// import 'package:navigations/model/user.dart';
// import 'package:uuid/uuid.dart';

// class AuthService {
//   final UserDB _userDB = UserDB();

//   Future<bool> login(String email, String password) async {
//     Users? user = await _userDB.getUserByEmail(email);
//     if (user != null && user.password == password) {
//       // User found and password matches, login successful
//       return true;
//     } else {
//       // User not found or password does not match, login failed
//       return false;
//     }
//   }

//   Future<bool> signUp(String email, String password) async {
//     // Check if the email is already registered
//     Users? existingUser = await _userDB.getUserByEmail(email);
//     if (existingUser != null) {
//       // Email already exists, signup failed
//       return false;
//     }

//     // Email does not exist, proceed with signup
//     String id = Uuid().v4();
//     await _userDB.createUser(id: id, email: email, password: password);
//     return true;
//   }
// }
