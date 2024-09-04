import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/worker/edit_details_worker/edit_employe_details_bloc.dart';
import 'package:metrogeniusapp/functions/project_functions.dart';
import 'package:metrogeniusapp/services/admin/converters/image_converter.dart';
import 'package:metrogeniusapp/src/employe/widgets/custom_textfeild.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsWorker extends StatelessWidget {
  final data;
  const DetailsWorker({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController workController = TextEditingController();
    TextEditingController yearsController = TextEditingController();

    nameController.text = data['ApplicantName'];
    phoneController.text = data['ApplicantPhone'].toString();
    emailController.text = data['ApplicantEmail'];
    workController.text = data['ApplicantWorkType'];
    yearsController.text = data['ApplicantExperience'].toString();

    final orgImg = data['ApplicantImage'];
    String? userImage;

    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<EditEmployeDetailsBloc, EditEmployeDetailsState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Form(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    AppConstants.kheight30,
                    GestureDetector(
                      onTap: () async {
                        final img =
                            await ProjectFunctionalites().imagePickercir();
                        if (img != null) {
                          userImage = img.path;
                          context
                              .read<EditEmployeDetailsBloc>()
                              .add(EmployeeImageChanges(userImage!));
                        }
                      },
                      child: CircleAvatar(
                        radius: 90,
                        backgroundImage: userImage != null
                            ? FileImage(File(userImage!)) as ImageProvider
                            : NetworkImage(orgImg),
                      ),
                    ),
                    AppConstants.kheight20,
                    CustomTextFeild2(
                      onChanged: (value) => context
                          .read<EditEmployeDetailsBloc>()
                          .add(EmployeeNameChanges(value)),
                      controller: nameController,
                      heading: 'Full Name',
                      hinttext: 'Full Name',
                    ),
                    AppConstants.kheight20,
                    CustomTextFeild2(
                      onChanged: (value) => context
                          .read<EditEmployeDetailsBloc>()
                          .add(EmployeePhone(int.parse(value))),
                      controller: phoneController,
                      heading: 'Phone Number',
                      hinttext: 'Phone Number',
                      keybordtype: TextInputType.phone,
                    ),
                    AppConstants.kheight20,
                    CustomTextFeild2(
                      readOnly: true,
                      controller: emailController,
                      heading: 'Email Address',
                      hinttext: 'Email Address',
                      keybordtype: TextInputType.emailAddress,
                    ),
                    AppConstants.kheight20,
                    CustomTextFeild2(
                      readOnly: true,
                      controller: workController,
                      heading: 'Work type',
                      hinttext: 'e.g. Plumber, Electrician etc',
                    ),
                    AppConstants.kheight20,
                    CustomTextFeild2(
                      onChanged: (value) => context
                          .read<EditEmployeDetailsBloc>()
                          .add(EmployeeExpChanges(int.parse(value))),
                      readOnly: true,
                      controller: yearsController,
                      heading: 'Years of experience',
                      hinttext: 'Years of experience',
                      keybordtype: TextInputType.number,
                    ),
                    AppConstants.kheight20,
                    LoginContainer(  ontap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        final employeCode = prefs.getString('EmployeAssigned');
                        print(employeCode);
                        print('anwar');
                        String? finalImage;
                        // If a new image is picked, upload it; otherwise, use the original image
                        if (userImage != null) {
                          finalImage =
                              await uploadImageToFirebase(File(userImage!));
                        } else {
                          finalImage = orgImg;
                        }

                        context
                            .read<EditEmployeDetailsBloc>()
                            .add(EmployeeImageChanges(finalImage!));
                        context
                            .read<EditEmployeDetailsBloc>()
                            .add(UpdatedFormSubmit());
                        Navigator.of(context).pop();
                      },content: 'Save'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
