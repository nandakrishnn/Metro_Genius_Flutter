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
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/profile/user_service.dart';
import 'package:metrogeniusapp/src/user/widgets/textfeild.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class UserProfileDetails extends StatelessWidget {
  const UserProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller = TextEditingController();
    TextEditingController passcontroller = TextEditingController();
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
            passcontroller.text = state.data.first['Password'];
            final data = state.data;

            return BlocConsumer<UserSignupBloc, UserSignupState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                print(FirebaseAuth.instance.currentUser!.uid);
                return Scaffold(
                  body: SingleChildScrollView(
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
                              child: Container(
                                height: 200,
                                width: 200,
                                child: userImage != null
                                    ? Image.file(File(userImage!))
                                    : Image.network(
                                        'https://www.shutterstock.com/image-vector/add-photo-icon-vector-line-260nw-1039350133.jpg'),
                              ),
                            ),
                            AppConstants.kheight10,
                            CustomTextFeild(
                              onChanged: (p0) => context
                                  .read<UserSignupBloc>()
                                  .add(UserNameChanges(p0)),
                              hinttext: 'UserName',
                              obscure: false,
                              controller: namecontroller,
                            ),
                            AppConstants.kheight10,
                            CustomTextFeild(
                              onChanged: (p0) => context
                                  .read<UserSignupBloc>()
                                  .add(PassChanges(p0)),
                              hinttext: 'Password',
                              obscure: false,
                              controller: passcontroller,
                            ),
                            AppConstants.kheight10,
                            LoginContainer(
                                ontap: () async {
                                  print('dsfds');
                                  print(FirebaseAuth.instance.currentUser!.uid);
                                  final image = await uploadImageToFirebase(
                                      File(userImage!));
                                  context
                                      .read<UserSignupBloc>()
                                      .add(UserImageChanges(image!));
                                  context
                                      .read<UserSignupBloc>()
                                      .add(UpdateFormSubmit());
                                  Navigator.of(context).pop();
                                },
                                content: 'Save Details')
                          ],
                        ),
                      ),
                    ),
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
