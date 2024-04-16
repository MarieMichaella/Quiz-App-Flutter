import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class Users {
  final String id;
  final String email;
  final String password;

  Users({
    required this.id,
    required this.email,
    required this.password,
  });

  // Convert user object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }

  // Convert a map to a user object
  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'],
      email: map['email'],
      password: map['password'],
    );
  }

  // Factory constructor to create a user from Firebase User object
  factory Users.fromFirebaseUser(User firebaseUser) {
    return Users(
      id: firebaseUser.uid, // Accessing the uid property from Firebase User
      email: firebaseUser.email ?? '', // Accessing the email property from Firebase User
      password: '', // Password may not be directly accessible from Firebase User
    );
  }

  // Convert user object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
    };
  }
}
