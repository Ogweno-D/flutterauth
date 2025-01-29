// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   // Instance of auth

//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   // Get current user

//   User? getCurrentUser() {
//     return _firebaseAuth.currentUser;
//   }

//   // Email sign in
//   Future<UserCredential> signInWithEmailPassword(String email, password) async {
//     try {
//       // Sign user in
//       UserCredential userCredential = await _firebaseAuth
//           .signInWithEmailAndPassword(email: email, password: password);
//       return userCredential;
//     } on FirebaseAuthException catch (e) {
//       throw Exception(e.code);
//     }
//   }

//   // Email sign up
//   Future<UserCredential> signUpWithEmailPassword(String email, password) async {
//     try {
//       // Create user
//       UserCredential userCredential = await _firebaseAuth
//           .createUserWithEmailAndPassword(email: email, password: password);

//       return userCredential;
//     } on FirebaseAuthException catch (e) {
//       throw Exception(e.code);
//     }
//   }

//   // Sign Out
//   Future<void> signOut() async {
//     return await _firebaseAuth.signOut();
//   }

//   // Google sign in
//   signInWithGoogle() async {
//     // Begin interactive sign in process
//     final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

//     // If the user cancels the pop up screen
//     if (gUser == null) return;

//     // Obtain auth details from request
//     final GoogleSignInAuthentication gAuth = await gUser.authentication;

//     // Create a new credential for user
//     final credential = GoogleAuthProvider.credential(
//       accessToken: gAuth.accessToken,
//       idToken: gAuth.idToken,
//     );

//     // Finally sign in
//     return await _firebaseAuth.signInWithCredential(credential);
//   }

//   // Possible Error Messages
//   String getErrorMessage(String errorCode) {
//     switch (errorCode) {
//       case 'Exception: wrong-password':
//         return 'The password is incorrect. Please try again.';
//       case 'Exception: user-not-found':
//         return 'No user found with this email. Please sign up.';
//       case 'Exception: invalid-email':
//         return 'This email does not exist.';
//       default:
//         return 'An unexpexted error occurred. Please try again later.';
//     }
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthException implements Exception {
  final String code;
  AuthException(this.code);

  @override
  String toString() => code;
}

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    } catch (e) {
      throw AuthException('unknown-error');
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    } catch (e) {
      throw AuthException('unknown-error');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
      if (gUser == null) throw AuthException('sign-in-cancelled');

      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code);
    } catch (e) {
      throw AuthException('google-sign-in-failed');
    }
  }


  // Forgot Password: Send a password reset email
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      // Handle specific error cases
      throw AuthException(e.code);
    } catch (e) {
      // Handle any other errors
      throw Exception("An error occurred while sending the password reset email. Please try again later.");
    }
  }

  static String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'wrong-password':
        return 'The password is incorrect. Please try again.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'weak-password':
        return 'Please choose a stronger password.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'sign-in-cancelled':
        return 'Sign in process was cancelled.';
      case 'google-sign-in-failed':
        return 'Google sign in failed. Please try again.';
      case 'unknown-error':
        return 'An unexpected error occurred. Please try again.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}