import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/user_details/get_user_details_bloc.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/profile/ref_profile.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/profile/ref_profile_content.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/profile/user_service.dart';
import 'package:metrogeniusapp/utils/colors.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
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
                        padding:
                            EdgeInsets.symmetric(vertical: 60, horizontal: 15),
                        child: BlocProvider(
                          create: (context) =>
                              GetUserDetailsBloc(UserServices())
                                ..add(UserDataFetchData(
                                    FirebaseAuth.instance.currentUser!.uid)),
                          child: BlocConsumer<GetUserDetailsBloc,
                                  GetUserDetailsState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is GetUserDetailsLoading) {
                                  Center(
                                    child: CupertinoActivityIndicator(),
                                  );
                                }
                                print(FirebaseAuth.instance.currentUser!.uid);
                                if (state is GetUserDetailsLoaded) {
                                  final data = state.data.first;
                                  return ProfileRefactoredWidget(data: data);
                                }
                                return Container();
                              }),
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
          ),
          ProfileContentWidget(screenHeight: screenHeight, screenWidth: screenWidth)
        ],
      ),
    );
  }
}
