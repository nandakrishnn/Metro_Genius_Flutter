import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/login_bloc/user_login_bloc.dart';
import 'package:metrogeniusapp/services/auth_signin.dart';
import 'package:metrogeniusapp/src/admin/bottom_nav_admin/bottom_nav_employe.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/forgot_pass.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/register_now.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/bottom_nav.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/explore/home_page.dart';
import 'package:metrogeniusapp/src/user/widgets/custom_snackbar.dart';
import 'package:metrogeniusapp/src/user/widgets/social_login_container.dart';
import 'package:metrogeniusapp/src/user/widgets/textfeild.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import 'package:metrogeniusapp/utils/validators.dart';

class UserLoginPage extends StatelessWidget {
  UserLoginPage({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final String adminUserName = 'nandakrishnn@gmail.com';
  final String adminPassCode = 'krishnn';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserLoginBloc(UserSigninAuth()),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: BlocConsumer<UserLoginBloc, UserLoginState>(
                listener: (context, state) {
                  if (state.status == FormStatus.sucess) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavigation()));
                  } else if (state.status == FormStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(customSnack(
                        'Invalid Login',
                        'Sorry,invalid login credentials',
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 28,
                        ),
                        Colors.red));
                  }
                  if (state.status == FormStatus.pending)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CupertinoActivityIndicator(),
                    );
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .08,
                        ),
                        const Text(
                          'Welcome back! Glad to see you, Again!',
                          style: TextStyle(
                              fontSize: 31, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .06,
                        ),
                        CustomTextFeild(
                          onChanged: (p0) => context
                              .read<UserLoginBloc>()
                              .add(EmailChanges(p0)),
                          obscure: false,
                          hinttext: 'Enter your Email',
                          controller: emailController,
                          validator: (value) =>Validators.validateEmail(value)
                          
                          ,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .04,
                        ),
                        CustomTextFeild(
                          onChanged: (p0) => context
                              .read<UserLoginBloc>()
                              .add(PassChanges(p0)),
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
                              onTap: () {
                                Navigator.of(context)
                                    .push(createRoute(const ForgotPassword()));
                              },
                              child: const Text(
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
                              context.read<UserLoginBloc>().add(FormSubmit());
                            }
                            if (state.status == FormStatus.pending) {
                              const CupertinoActivityIndicator();
                            }
                            if (emailController.text == adminUserName &&
                                passController.text == adminPassCode) {
                              Navigator.of(context)
                                  .push(createRoute(AdminBottomNavigation()));
                            }
                          },
                          child: LoginContainer(
                            content: 'Login',
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
                            GestureDetector(
                              onTap: ()async{
                                _signInWithGoogle(context);
                              },
                              child: SocialLoginContainer(
                                  imageurl:
                                      'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png'),
                            )
                          ],
                        ),
                        AppConstants.kheight60,
                        AppConstants.kheight30,
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(createRoute(RegisterNow()));
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
                  );
                },
              ),
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

class LoginContainer extends StatelessWidget {
  String content;
  LoginContainer({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.mainBlueColor,
          borderRadius: BorderRadius.circular(7)),
      child: Center(
          child: Text(
        content,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
      )),
    );
  }
}
