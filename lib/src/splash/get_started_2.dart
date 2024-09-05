import 'package:flutter/material.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/users_login.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class GetStarted2 extends StatelessWidget {
  const GetStarted2({super.key});

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/snapedit_1725535604165.jpeg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(1.0), // Dark at the bottom
                Colors.transparent,
              ],
              stops: [
                0.0,
                0.7,
              ],
            )),
          ),
          Positioned(
              left: 10,
              right: 15,
              child: Center(
                  child: SizedBox(
                height: 300,
                width: 300,
                child: Image.asset(
                  'assets/Screenshot_2024-09-05_171248-removebg-preview.png',
                ),
              ))),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Expert Home Services, Just a Click Away',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                  ),
                  AppConstants.kheight20,
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: LoginContainer(
                      content: 'Welcome',
                      ontap: () {
                          Navigator.of(context).push(createRoute(CommonLoginPage()));
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

