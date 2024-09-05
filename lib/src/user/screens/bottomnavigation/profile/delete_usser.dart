import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/users_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Reusable function to delete a Firebase user and their data
Future<void> deleteUser(BuildContext context, {required VoidCallback onDeleteSuccess}) async {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      // Delete user data from Firestore or Realtime Database
      await FirebaseFirestore.instance.collection('Users').doc(user.uid).delete();

      // Attempt to delete the user's authentication record
      await user.delete();

      // Optionally sign the user out
      await FirebaseAuth.instance.signOut();

      // Clear SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('UserId');

      // Provide feedback to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User deleted successfully.')),
      );

      // Call the success callback to handle navigation
      onDeleteSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        // Handle reauthentication required error gracefully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reauthentication required to delete the account. Please log in again.')),
        );
        // Optionally, prompt reauthentication here
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting user: ${e.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user data: ${e.toString()}')),
      );
    }
  }
}

// Function to show confirmation dialog before deleting the user
Future<void> showDeleteConfirmationDialog(BuildContext context, {required VoidCallback onDeleteSuccess}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: Text('Delete'),
            onPressed: () {
              Navigator.of(context).pop();
              deleteUser(context, onDeleteSuccess: onDeleteSuccess); 
               Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => CommonLoginPage()),
        );
            },
          ),
        ],
      );
    },
  );
}
