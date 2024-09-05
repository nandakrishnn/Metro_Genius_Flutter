import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/src/splash/get_started_2.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/users_login.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class GestStartedOne extends StatelessWidget {
  const GestStartedOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/1 (1).png',
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
                    'From Cleaning to Repairs, We’ve Got You Covered',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
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
                      content: 'Next',
                      ontap: () {
                        Navigator.of(context).push(createRoute(GetStarted2()));
                      },
                    ),
                  ),
                  AppConstants.kheight10,
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(createRoute(CommonLoginPage()));
                    },
                    child: Text('Skip >', style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
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
