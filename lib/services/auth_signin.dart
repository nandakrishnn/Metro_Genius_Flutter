import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserSigninAuth {
  final auth = FirebaseAuth.instance;
  final googleAuth = FirebaseAuth.instance;
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final creads = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return creads.user;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');
      switch (e.code) {
        case 'user-not-found':
          print('No user found for that email.');
          throw Exception('No user found for that email.');
        case 'wrong-password':
          print('Wrong password provided for that user.');
          throw Exception('Wrong password provided for that user.');
        case 'invalid-email':
          print('The email address is invalid.');
          throw Exception('The email address is invalid.');
        case 'user-disabled':
          print('User with this email has been disabled.');
          throw Exception('User with this email has been disabled.');
        case 'too-many-requests':
          print('Too many attempts. Try again later.');
          throw Exception('Too many attempts. Try again later.');
        default:
          print('An unknown error occurred: ${e.message}');
          throw Exception('An unknown error occurred: ${e.message}');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<bool> forogotPasswordRest(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User?> signInWithGoogle(AuthCredential credential) async {
    try {
      final creds = await googleAuth.signInWithCredential(credential);
      return creds.user;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');
      switch (e.code) {
        case 'user-not-found':
          print('No user found for that email.');
          throw Exception('No user found for that email.');
        case 'wrong-password':
          print('Wrong password provided for that user.');
          throw Exception('Wrong password provided for that user.');
        case 'invalid-email':
          print('The email address is invalid.');
          throw Exception('The email address is invalid.');
        case 'user-disabled':
          print('User with this email has been disabled.');
          throw Exception('User with this email has been disabled.');
        case 'too-many-requests':
          print('Too many attempts. Try again later.');
          throw Exception('Too many attempts. Try again later.');
        default:
          print('An unknown error occurred: ${e.message}');
          throw Exception('An unknown error occurred: ${e.message}');
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<void> signOutWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      await _googleSignIn.signOut();
      print('User signed out successfully.');
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
