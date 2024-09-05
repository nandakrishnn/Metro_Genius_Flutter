import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:metrogeniusapp/bloc/signup_bloc/bloc/user_signup_bloc.dart';
import 'package:metrogeniusapp/bloc/user_details/get_user_details_bloc.dart';
import 'package:metrogeniusapp/functions/project_functions.dart';
import 'package:metrogeniusapp/services/admin/converters/image_converter.dart';
import 'package:metrogeniusapp/src/employe/widgets/custom_textfeild.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/profile/user_service.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class UserProfileDetails extends StatelessWidget {
  const UserProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller = TextEditingController();
    TextEditingController passcontroller = TextEditingController();
        TextEditingController emailcontroller = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String? userImage;
    return BlocProvider(
      create: (context) => GetUserDetailsBloc(UserServices())
        ..add(UserDataFetchData(FirebaseAuth.instance.currentUser!.uid)),
      child: BlocConsumer<GetUserDetailsBloc, GetUserDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetUserDetailsLoaded) {
            namecontroller.text = state.data.first['UserName'];
               emailcontroller.text = state.data.first['Email'];
            final orgImg=state.data.first['UserImage'];
            passcontroller.text = state.data.first['Password'];
            final data = state.data;

            return BlocConsumer<UserSignupBloc, UserSignupState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                print(FirebaseAuth.instance.currentUser!.uid);
                return Scaffold(
                  appBar: AppBar(
                    title: Text('User Details'),
                    centerTitle: true,
                  ),

                  body: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  AppConstants.kheight10,
                                  GestureDetector(
                                    onTap: () async {
                        
                                      final img = await ProjectFunctionalites()
                                          .imagePickercir();
                                      if (img != null) {
                                        context
                                            .read<UserSignupBloc>()
                                            .add(UserImageChanges(img.path));
                                      }
                                      userImage = img.path;
                                    },
                                    child: SizedBox(
                                      height: 200,
                                      width: 200,
                                      child: userImage != null
                                       ? ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.file(File(userImage!)  , fit: BoxFit.cover,))
                                          : orgImg != null && orgImg.isNotEmpty
                                              ? ClipRRect(
                                                        borderRadius: BorderRadius.circular(30),
                                                child: Image.network(   fit: BoxFit.cover,orgImg))
                                              : ClipRRect(
                                                       borderRadius: BorderRadius.circular(30),
                                                child: Image.network(
                                                  fit: BoxFit.cover,
                                                    'https://www.shutterstock.com/image-vector/add-photo-icon-vector-line-260nw-1039350133.jpg'),
                                              ),
                                    ),
                                  ),
                                  AppConstants.kheight10,
                                  CustomTextFeild2(
                                    heading: 'UserName',
                                    onChanged: (p0) => context
                                        .read<UserSignupBloc>()
                                        .add(UserNameChanges(p0)),
                                    hinttext: 'UserName',
                                    obscure: false,
                                    controller: namecontroller,
                                  ),
                                  AppConstants.kheight10,
                                  CustomTextFeild2(
                                    heading: 'Password',
                                    onChanged: (p0) => context
                                        .read<UserSignupBloc>()
                                        .add(PassChanges(p0)),
                                    hinttext: 'Password',
                                    obscure: false,
                                    controller: passcontroller,
                                  ),
                                  AppConstants.kheight10,
                                         AppConstants.kheight10,
                                  CustomTextFeild2(
                                      heading: 'Email',
                                      readOnly: true,
                                    hinttext: 'Email',
                                    obscure: false,
                                    controller: emailcontroller,
                                  ),
                                 
                                
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: LoginContainer(
                              ontap: () async {
                                 String? finalImage;
                              // If a new image is picked, upload it; otherwise, use the original image
                              if (userImage != null) {
                                finalImage = await uploadImageToFirebase(File(userImage!));
                              } else {
                                finalImage = orgImg; 
                              }
                          
                              context.read<UserSignupBloc>().add(UserNameChanges(namecontroller.text));
                              context.read<UserSignupBloc>().add(UserImageChanges(finalImage!));
                              context.read<UserSignupBloc>().add(PassChanges(passcontroller.text));
                              context.read<UserSignupBloc>().add(UpdateFormSubmit());
                              Navigator.of(context).pop();
                              },
                              content: 'Save Details'),
                        )
                    ],
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  Future<XFile?> pickImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    return img;
  }
}
