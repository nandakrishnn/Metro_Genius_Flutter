import 'package:flutter/material.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/src/employe/register_employe/registration/register_page.dart';

import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class RegisterEmployee extends StatelessWidget {
  const RegisterEmployee({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .37,
            decoration: const BoxDecoration(),
            child: Image.asset(
              'assets/depositphotos_2781769-stock-photo-detail-of-toolbelt-on-handyman.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                // height: MediaQuery.of(context).size.height * .6,
                child: Column(
                  children: [
                    AppConstants.kheight20,
                    const Text(
                      'BECOME A WORKER WITH US?',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Join Our Workforce Today',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(106, 112, 124, .99)),
                    ),
                    AppConstants.kheight5,
                    RegisterContainer(maintext: ' Increased Job Opportunities', subtext: ' Expand your client base and enjoy\n flexible working hours.', imgurl: 'assets/[removal.ai]_0a336b84-a7fd-4baf-b067-e750a000c843-images.png',bottom: const EdgeInsets.only(bottom: 20),),
                    RegisterContainer(maintext: ' Enhanced Professional Reputation', imgurl: 'assets/resized.png', subtext: ' Build credibility through user\n reviews and showcase your work.',bottom: const EdgeInsets.only(bottom: 5),),
                    RegisterContainer(maintext: ' Convenient Business Management', imgurl: 'assets/[removal.ai]_fa5e21de-27bd-4562-a2a2-b4256c1abffc_download.png', subtext: ' Enjoy a hassle-free payment direct\n earningsdeposited into your account.',bottom:const EdgeInsets.only(bottom: 0) ,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(createRoute(const EmployeeForm()));
                        },
                        child: LoginContainer(content: 'Register Now')),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RegisterContainer extends StatelessWidget {
  String maintext;
  String subtext;
  String imgurl;
  EdgeInsetsGeometry? bottom;
   RegisterContainer({
    required this.maintext,
    required this.imgurl,
    required this.subtext,
    this.bottom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5,right: 5,top: 5,bottom: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .13,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Row(
          children: [
            Padding(
              padding: bottom!,
              child: SizedBox(
                height: 80,
                width: 80,
                child: Image.asset(
                  imgurl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 3,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppConstants.kheight20,
                Text(
                  maintext,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                AppConstants.kheight5,
                Text(
                  subtext,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500,color: Color.fromRGBO(73, 76, 83, 0.984)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


