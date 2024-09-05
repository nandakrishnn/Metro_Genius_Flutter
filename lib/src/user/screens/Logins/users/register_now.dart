import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/signup_bloc/bloc/user_signup_bloc.dart';
import 'package:metrogeniusapp/services/auth.dart';
import 'package:metrogeniusapp/services/auth_signin.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/google_button.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/bottom_nav.dart';
import 'package:metrogeniusapp/src/user/widgets/social_login_container.dart';
import 'package:metrogeniusapp/src/user/widgets/textfeild.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class RegisterNow extends StatelessWidget {
  RegisterNow({super.key});

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserSignupBloc(AuthRepo()),
      child: GestureDetector(
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
                  child: BlocConsumer<UserSignupBloc, UserSignupState>(
                    listener: (context, state) {
                      if (state.status == FormStatus.success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Signup successful')),
                        );
                        Navigator.of(context)
                            .push(createRoute(UserLoginPage()));
                      } else if (state.status == FormStatus.error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(state.errorMsg ?? 'Signup failed')),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          AppConstants.kheight30,
                          AppConstants.kheight20,
                          const Text(
                            'Hello! Register to get started',
                            style: TextStyle(
                                fontSize: 31, fontWeight: FontWeight.w800),
                          ),
                          AppConstants.kheight30,
                          CustomTextFeild(
                            onChanged: (p0) => context.read<UserSignupBloc>().add(UserNameChanges(p0)),
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
                          CustomTextFeild(
                            onChanged: (value) => context
                                .read<UserSignupBloc>()
                                .add(EmailChanges(value)),
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
                          CustomTextFeild(
                            onChanged: (value) => context
                                .read<UserSignupBloc>()
                                .add(PassChanges(value)),
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
                          CustomTextFeild(
                            obscure: false,
                            hinttext: 'Confirm Password',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm your password';
                              }
                              if (value != passController.text) {
                                return 'Password does not match';
                              }
                              return null;
                            },
                          ),
                          AppConstants.kheight30,
                          GestureDetector(
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                context.read<UserSignupBloc>().add(UserImageChanges(''));
                                context
                                    .read<UserSignupBloc>()
                                    .add(FormSubmit());
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
                                'Register',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
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
                         GoogleButton(
                          onPressed: () async {
                            _signInWithGoogle(context);
                          },
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
                      );
                    },
                  )),
            ),
          ),
        ),
      ),
    );
  }
    _signInWithGoogle(context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final UserSigninAuth auth = UserSigninAuth();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential creadential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        await auth.signInWithGoogle(creadential);
        Navigator.of(context).push(createRoute(BottomNavigation()));
      }
    } catch (e) {
      print(e.toString());
    }
  }
}


