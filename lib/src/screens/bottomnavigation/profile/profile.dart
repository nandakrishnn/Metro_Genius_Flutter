import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/src/screens/Logins/users/users_login.dart';
import 'package:metrogeniusapp/src/widgets/profile/profile_container.dart';
import 'package:metrogeniusapp/src/widgets/profile/profile_tiles.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: AppColors.mainBlueColor,
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(250, 142, 144, 149),
                          offset: Offset(0, 0),
                          spreadRadius: 2.5,
                          blurRadius: 1)
                    ]),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .42,
                child: const Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 60, horizontal: 21),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 60,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nandakrishnan',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(249, 250, 250, 250)),
                              ),
                              Text(
                                'nandakrishnan@gmail.com',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(248, 139, 132, 132)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: AppColors.primaryColor),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .58,
              ),
            ],
          ),
          Positioned(
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
                child: Column(
                  children: [
                    AppConstants.kheight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ProfileContainers(
                          text: 'Edit Profile',
                          imgurl:
                              'assets/b26797ebb855cd42387411734e28b73c-removebg-preview.png',
                        ),
                        ProfileContainers(
                          text: 'Invite ',
                          imgurl:
                              'assets/refer-friend-badge-design-template-260nw-2082857296.jpg',
                        ),
                        ProfileContainers(
                          text: 'Settings',
                          imgurl:
                              'assets/settings-icon-gear-3d-render-png.webp',
                        )
                      ],
                    ),
                    AppConstants.kheight20,
                    ProfileTiles(title: 'Privacy Policy',Subtitle: 'Privacy policy of MetroGenius',icons: const Icon(Icons.privacy_tip,size: 25,),action: (){}),
                    ProfileTiles(title: 'Terms And Conditions', Subtitle: 'Terms and conditions', icons: const Icon(Icons.terminal_sharp,),action: (){},),
                    ProfileTiles(title: 'Logout', Subtitle: 'Logging Out From MetroGenius', icons: const Icon(Icons.logout),action: (){
                      FirebaseAuth.instance.signOut().then((value){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>CommonLoginPage()));
                      });
                    },),
                    
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
