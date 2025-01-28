import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Instance of auth

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Get current user

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // Email sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      // Sign user in
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Email sign up
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      // Create user
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign Out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  // Google sign in
  signInWithGoogle() async {
    // Begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    // If the user cancels the pop up screen
    if (gUser == null) return;

    // Obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    // Create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Finally sign in
    return await _firebaseAuth.signInWithCredential(credential);
  }

  // Possible Error Messages
  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'Exception: wrong-password':
        return 'The password is incorrect. Please try again.';
      case 'Exception: user-not-found':
        return 'No user found with this email. Please sign up.';
      case 'Exception: invalid-email':
        return 'This email does not exist.';

      default:
        return 'An unexpexted error occurred. Please try again later.';
    }
  }
}
