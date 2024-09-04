import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class ProfileRefactoredWidget extends StatelessWidget {
  const ProfileRefactoredWidget({
    super.key,
    required this.data,
  });

  final DocumentSnapshot<Object?> data;

  @override
  Widget build(BuildContext context) {
    // Check if the 'UserImage' field exists and is not null, otherwise use the default image URL
    final String defaultImageUrl =
        'https://i.pinimg.com/280x280_RS/2a/24/b4/2a24b4279590128b04a67ce4ff898c8b.jpg';
    final String userImageUrl = data.data().toString().contains('UserImage') && data['UserImage'] != null
        ? data['UserImage']
        : defaultImageUrl;

    // Check if the 'UserName' field exists and is not null, otherwise use 'No user name'
    final String userName = data.data().toString().contains('UserName') && data['UserName'] != null
        ? data['UserName']
        : 'Google User';

    // Check if the 'Email' field exists and is not null, otherwise use 'Unknown Mail'
    final String userEmail = data.data().toString().contains('Email') && data['Email'] != null
        ? data['Email']
        : 'Confidential';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[200], // Background color while loading
              child: ClipOval(
                child: Image.network(
                  userImageUrl, // Use the valid user image URL or the default
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }
                  },
                  errorBuilder: (context, error, stackTrace) {
                    // Display an icon if there's an error loading the image
                    return Icon(
                      Icons.account_circle,
                      size: 120, // Display an icon in case of error
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),
            AppConstants.kwidth10,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName, // Display the user name or 'No user name' if null
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(249, 250, 250, 250),
                  ),
                ),
                Text(
                  userEmail, // Display the email or 'Unknown Mail' if null
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(248, 139, 132, 132),
                  ),
                ),
              ],
            ),
          ],
        ),
        AppConstants.kheight10,
      ],
    );
  }
}
