import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/services/auth_signin.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/users_login.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/profile/adress_user/adress_user.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/profile/delete_usser.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/profile/details_profile.dart';
import 'package:metrogeniusapp/src/user/screens/terms_conditons/privacy_policy.dart';
import 'package:metrogeniusapp/src/user/screens/terms_conditons/terms_conditions.dart';
import 'package:metrogeniusapp/src/user/widgets/profile/profile_container.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/profile/profile_tiles.dart';

class ProfileContentWidget extends StatelessWidget {
  const ProfileContentWidget({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: screenHeight * 0.28,
      right: screenWidth * 0.05,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 220, 210, 210),
                    offset: Offset(0, 0),
                    spreadRadius: 1,
                    blurRadius: .5)
              ]),
          height: screenHeight * 0.58,
          width: screenWidth * 0.9,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppConstants.kheight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(createRoute(AdressUser()));
                      },
                      child: ProfileContainers(
                        text: 'Edit Adress',
                        imgurl:
                            'assets/b26797ebb855cd42387411734e28b73c-removebg-preview.png',
                      ),
                    ),
                    ProfileContainers(
                      text: 'Invite ',
                      imgurl:
                          'assets/refer-friend-badge-design-template-260nw-2082857296.jpg',
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(createRoute(UserProfileDetails()));
                      },
                      child: ProfileContainers(
                        text: 'Settings',
                        imgurl: 'assets/settings-icon-gear-3d-render-png.webp',
                      ),
                    )
                  ],
                ),
                AppConstants.kheight20,
                ProfileTiles(
                    title: 'Privacy Policy',
                    Subtitle: 'Privacy policy of MetroGenius',
                    icons: const Icon(
                      Icons.privacy_tip,
                      size: 25,
                    ),
                    ontap: () {
                      Navigator.of(context)
                          .push(createRoute(PrivacyPolicyPage()));
                    }),
                ProfileTiles(
                  ontap: () {
                    Navigator.of(context)
                        .push(createRoute(TermsAndConditionsScreen()));
                  },
                  title: 'Terms And Conditions',
                  Subtitle: 'Terms and conditions',
                  icons: const Icon(
                    Icons.terminal_sharp,
                  ),
                  action: () {},
                ),
              
                ProfileTiles(
                  textcolor: Colors.red,
                  title: 'Logout',
                  Subtitle: 'Logging Out From MetroGenius',
                  icons: const Icon(Icons.logout),
                  ontap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.white,
                          title: Column(
                            children: [
                              Icon(
                                Icons.logout,
                                size: 50,
                                color: Colors.redAccent,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Are you sure you want to Logout?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          content: Text(
                            'You will need to login again to access your account.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[300],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                'No',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final UserSigninAuth _auth = UserSigninAuth();
                                _auth.signOutWithGoogle().then((value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CommonLoginPage()));
                                });
                                FirebaseAuth.instance
                                    .signOut()
                                    .then((value) async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  bool removed = await prefs.remove('UserId');
                                  print(removed);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CommonLoginPage(),
                                    ),
                                  );
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                   ProfileTiles(
                    textcolor: Colors.red,
                  title: 'Delete Your account',
                  
                  Subtitle: 'Permanently Delete your account',
                  icons: const Icon(
                    Icons.delete_forever,
                  ),
                  ontap: () async {
                    await showDeleteConfirmationDialog(context,
                        onDeleteSuccess: () async{
                          
                 });
                             
             
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
