import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/src/employe/register_employe/registration/employe_home.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/utils/colors.dart';

import '../../../widgets/login_card.dart';

class CommonLoginPage extends StatelessWidget {
  const CommonLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .4,
                width: double.infinity,
                decoration:
                    const BoxDecoration(color: Color.fromRGBO(40, 56, 145, 1)),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .6,
                width: double.infinity,
                decoration: const BoxDecoration(color: AppColors.primaryColor),
              ),
            ],
          ),
          Positioned(
              left: MediaQuery.of(context).size.width * 0.031,
              top: MediaQuery.of(context).size.height * 0.3,
              child: LoginCards(
                action: () {
                  Navigator.of(context).push(createRoute(UserLoginPage()));
                },
                heading: 'Looking for a Service',
                content: 'To place any type of order\nwith the help of our app',
                imageurl: 'assets/Group.jpg',
                radius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
              )),
          Positioned(
            
              left: MediaQuery.of(context).size.width * 0.031,
              top: MediaQuery.of(context).size.height * 0.53,
              child: LoginCards(
                action: (){
                  Navigator.of(context).push(createRoute(const RegisterEmployee()));
                },
                  heading: 'I want to find a job    ',
                  content:
                      'Search and apply for jobs in\nyour field of activity',
                  imageurl: 'assets/n993177.jpg',
                  radius: const BorderRadius.all(Radius.zero))),
          Positioned(
              left: MediaQuery.of(context).size.width * 0.031,
              top: MediaQuery.of(context).size.height * 0.76,
              child: LoginCards(
                  heading: 'Currently working\non MetroGenius       ',
                  content: 'This is for the login of\nemployees of MetroGenius',
                  imageurl:
                      'assets/[removal.ai]_17b63808-1185-4be3-b5d5-4000e386fbfa-png-transparent-plumbing-maintenance-handyman-plumber-miscellaneous-hand-home-repair-thumbnail.png',
                  radius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)))),
        ],
      ),
    ));
  }
}
