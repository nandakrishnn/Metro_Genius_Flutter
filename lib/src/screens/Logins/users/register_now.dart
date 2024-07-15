import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/src/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/src/widgets/social_login_container.dart';
import 'package:metrogeniusapp/src/widgets/textfeild.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';

// ignore: must_be_immutable
class RegisterNow extends StatelessWidget {
  RegisterNow({super.key});

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
   TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Form(
                key: formkey,
                child: Column(
                  children: [
                    AppConstants.kheight30,
                    AppConstants.kheight20,
                    const Text(
                      'Hello! Register to get started',
                      style:
                          TextStyle(fontSize: 31, fontWeight: FontWeight.w800),
                    ),
                    AppConstants.kheight30,
                    TextFeild(
                       obscure: false,
                      controller: userNameController,
                      hinttext: 'Username',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a username';
                        }
                        if (value.length < 3) {
                          return 'Username must be at least 3 characters long';
                        }
                        if (value.length > 20) {
                          return 'Username must be less than 20 characters long';
                        }
                        String pattern = r'^[a-zA-Z0-9_]+$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return 'Username can only contain letters, numbers, and underscores';
                        }
                        return null;
                      },
                    ),
                    AppConstants.kheight20,
                    TextFeild(
                       obscure: false,
                      controller: userEmailController,
                      hinttext: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter the email';
                        }
                        String pattern = r'^[^@]+@[^@]+\.[^@]+$';
                        RegExp regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    AppConstants.kheight20,
                    TextFeild(
                      obscure: false,
                        controller: passController,
                        
                      hinttext: 'Password',
                    
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your password';
                        }
                        if (value.length < 6) {
                        
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    AppConstants.kheight20,
                    TextFeild(
                       obscure: false,
                      hinttext: 'Confirm Password',
                     validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm your password';
                    }
                 if(value!=passController.text){
                  return 'Password does not match';
                 }
                 return null;
  },
                    ),
                    AppConstants.kheight30,

                    AppConstants.kheight30,
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            indent: 2,
                            endIndent: 4,
                            thickness: .5,
                            color: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Or Register with',
                            style: TextStyle(
                                color: Color.fromRGBO(106, 112, 124, .99),
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            indent: 2,
                            endIndent: 4,
                            thickness: .5,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    AppConstants.kheight30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SocialLoginContainer(
                          imageurl:
                              'https://clipground.com/images/facebook-icon-logo-8.png',
                        ),
                        SocialLoginContainer(
                            imageurl:
                                'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png')
                      ],
                    ),
                    AppConstants.kheight30,
                    AppConstants.kheight10,
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(createRoute(UserLoginPage()));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(106, 112, 124, .99),
                            ),
                          ),
                          Text(
                            ' Login Now',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(53, 194, 193, 1)),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
