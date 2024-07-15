import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/src/screens/Logins/users/forgot_pass.dart';
import 'package:metrogeniusapp/src/screens/Logins/users/register_now.dart';
import 'package:metrogeniusapp/src/screens/bottomnavigation/bottom_nav.dart';
import 'package:metrogeniusapp/src/widgets/social_login_container.dart';
import 'package:metrogeniusapp/src/widgets/textfeild.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class UserLoginPage extends StatelessWidget {
  UserLoginPage({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .08,
                  ),
                  const Text(
                    'Welcome back! Glad to see you, Again!',
                    style: TextStyle(fontSize: 31, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .06,
                  ),
                  TextFeild(
                     obscure: false,
                    hinttext: 'Enter your Email',
                    controller: emailController,
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .04,
                  ),
                  TextFeild(
                    obscure: true,
                    hinttext: 'Enter your Password',
                    controller: passController,
                    sufixbutton: const Icon(Icons.remove_red_eye_sharp),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 8 characters long';
                      }

                      return null;
                    },
                  ),
                  AppConstants.kheight10,
                   Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(createRoute(ForgotPassword()));
                          },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(106, 112, 124, .99)),
                        ),
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .04,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formkey.currentState!.validate()) {
                        try {
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passController.text)
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('SIgning you in')));
                                  Navigator.of(context)
                            .push(createRoute(const BottomNavigation()));
                          }).onError((error,stackTree){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid User'),backgroundColor: Colors.red,),);
                          });
                        } catch (e) {
                          print(e);
                        }
                      
                      }
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.mainBlueColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      )),
                    ),
                  ),
                  AppConstants.kheight30,
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          indent: 2,
                          endIndent: 4,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          'Or Login With',
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
                          thickness: 1,
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
                  AppConstants.kheight60,
                  AppConstants.kheight30,
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(createRoute(RegisterNow()));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t have an account?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(106, 112, 124, .99),
                          ),
                        ),
                        Text(
                          ' Register Now',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(53, 194, 193, 1)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
