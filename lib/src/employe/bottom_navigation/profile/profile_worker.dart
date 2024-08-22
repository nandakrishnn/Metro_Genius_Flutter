import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/worker/sigin_worker/worker_sign_in_bloc.dart';
import 'package:metrogeniusapp/bloc/worker/workers_listing_user/workers_listing_user_bloc.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/profile/details_worker.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/users_login.dart';
import 'package:metrogeniusapp/src/user/widgets/profile/profile_container.dart';
import 'package:metrogeniusapp/src/user/widgets/profile/profile_tiles.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileWorker1 extends StatelessWidget {
  const ProfileWorker1({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => WorkersListingUserBloc()..add(WorkersFetchData()),
      child: BlocConsumer<WorkersListingUserBloc, WorkersListingUserState>(
        listener: (context, state) {},
        builder: (context, state) {
        if(state is WorkersListingUserLoading){
          Center(child: CupertinoActivityIndicator(),);
        }
          if (state is WorkersListingUserLoaded) {
            
            final data = state.data;
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
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 60, horizontal: 21),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        NetworkImage(data['ApplicantImage']),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data['ApplicantName'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                249, 250, 250, 250)),
                                      ),
                                      Text(
                                        data['ApplicantEmail'],
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                248, 139, 132, 132)),
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
                                  onTap: (){
                                    Navigator.of(context).push(createRoute(DetailsWorker(data: data,)));
                                  },
                                  text: 'Edit Details',
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
                            ProfileTiles(
                                title: 'Privacy Policy',
                                Subtitle: 'Privacy policy of MetroGenius',
                                icons: const Icon(
                                  Icons.privacy_tip,
                                  size: 25,
                                ),
                                action: () {}),
                            ProfileTiles(
                              title: 'Terms And Conditions',
                              Subtitle: 'Terms and conditions',
                              icons: const Icon(
                                Icons.terminal_sharp,
                              ),
                              action: () {},
                            ),
                            ProfileTiles(
                              title: 'Logout',
                              Subtitle: 'Logging Out From MetroGenius',
                              icons: const Icon(Icons.logout),
                              action: () {
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
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            try {
                                             await logoutUser(context);

                                             
                                            } catch (e) {
                                              print(
                                                  'Error removing preferences: $e');
                                       
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.redAccent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey[300],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
  Future<void> logoutUser(BuildContext context) async {
 try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool removed = await prefs.remove('WorkerId');
    
    if (removed) {
      print('WorkerId removed successfully');
    } else {
      print('Failed to remove WorkerId');
    }
  bool exists = prefs.containsKey('WorkerId');
    print('WorkerId exists after removal attempt: $exists');
    // Ensure any BLoC or state management is reset
    context.read<WorkersListingUserBloc>().add(WorkersDataCleared());

    // Navigate to login page and clear the navigation stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => CommonLoginPage()),
      (route) => false, // Clear all previous routes
    );
  } catch (e) {
    print('Error during logout: $e');
  }

}}
