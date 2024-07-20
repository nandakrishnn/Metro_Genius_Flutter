// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/job_application/job_application_employe_bloc.dart';
import 'package:metrogeniusapp/functions/project_functions.dart';
import 'package:metrogeniusapp/src/employe/widgets/custom_textfeild.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/users_login.dart';
import 'package:metrogeniusapp/src/user/widgets/custom_snackbar.dart';
import 'package:metrogeniusapp/utils/constants.dart';


class EmployeeForm extends StatelessWidget {
  const EmployeeForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController workController = TextEditingController();
    TextEditingController yearsController = TextEditingController();
    TextEditingController idProofController = TextEditingController();
    GlobalKey<FormState> formkey = GlobalKey<FormState>();
    String? profileimg;

    return BlocProvider(
      create: (context) => JobApplicationEmployeBloc(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'BECOME A WORKER',
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
        ),
        body:
            BlocConsumer<JobApplicationEmployeBloc, JobApplicationEmployeState>(
          listener: (context, state) {
            if (state.status == FormStatus.sucess) {
              ScaffoldMessenger.of(context).showSnackBar(customSnack(
                  'Registration Sucessfull',
                  'Application Submitted',
                  const Icon(
                    Icons.done_all_outlined,
                    size: 28,
                    color: Colors.green,
                  ),
                  Colors.green));
              Navigator.of(context)
                  .pushReplacement(createRoute(const CommonLoginPage()));
              context.read<JobApplicationEmployeBloc>().add(FormReset());
            } else if (state.status == FormStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnack(
                    'Application Not Submitted',
                    'Sorry, Try Again ',
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 28,
                    ),
                    Colors.green),
              );
              //  context.read<JobApplicationEmployeBloc>().add(FormReset());
            } else if (state.status == FormStatus.pending) {
              const CupertinoActivityIndicator();
            }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Stack(
                children: [
                  SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/uniformed-technician-utilizing-tablet-inspect-air-conditioning-filter-maintenance-cleaning-ac-maintenance-home-service-concept_117038-31199.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            AppConstants.kheight60,
                            AppConstants.kheight20,
                            GestureDetector(
                              onTap: () async {
                                final img = await ProjectFunctionalites
                                    .imagePickercir();

                                if (img != null) {
                                  context
                                      .read<JobApplicationEmployeBloc>()
                                      .add(ImageChanges(img.path));
                                  profileimg = img.path;
                                }
                              },
                              child: CircleAvatar(
                                  radius: 90,
                                  backgroundColor:
                                      const Color.fromARGB(255, 216, 214, 214),
                                  foregroundColor:
                                      const Color.fromARGB(255, 132, 132, 132),
                                  backgroundImage: profileimg != null
                                      ? FileImage(File(profileimg!))
                                      : null,
                                  child: profileimg == null
                                      ? const Icon(Icons.camera)
                                      : null),
                            ),
                            AppConstants.kheight20,
                            CustomTextFeild2(
                              onChanged: (p0) => context
                                  .read<JobApplicationEmployeBloc>()
                                  .add(UNameChanges(p0)),
                              controller: nameController,
                              heading: 'Full Name',
                              hinttext: 'Full Name',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your full name';
                                }
                                if (value.length < 2) {
                                  return 'Name must be at least 2 characters long';
                                }
                                if (value.length > 50) {
                                  return 'Name must not exceed 50 characters';
                                }
                                return null;
                              },
                            ),
                            AppConstants.kheight20,
                            CustomTextFeild2(
                              onChanged: (p0) => context
                                  .read<JobApplicationEmployeBloc>()
                                  .add(UserPhone(int.parse(p0))),
                              controller: phoneController,
                              heading: 'Phone Number',
                              hinttext: 'Phone Number',
                              keybordtype: TextInputType.phone,
                              validator: (value) {
                                String pattern = r'^\d{10}$';
                                RegExp regExp = RegExp(pattern);

                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                } else if (!regExp.hasMatch(value)) {
                                  return 'Please enter a valid 10-digit phone number';
                                }
                                return null;
                              },
                            ),
                            AppConstants.kheight20,
                            CustomTextFeild2(
                              
                              onChanged: (p0) => context
                                  .read<JobApplicationEmployeBloc>()
                                  .add(UserEmail(p0)),
                              controller: emailController,
                              heading: 'Email Address',
                              hinttext: 'Email Address',
                              keybordtype: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter the email';
                                }
                                String pattern = r'^[^@]+@[^@]+\.[^@]+$';
                                RegExp regex = RegExp(pattern);
                                if (!regex.hasMatch(value)) {
                                  return 'Enter a valid email address';
                                }
                                return null;
                              },
                            ),
                            AppConstants.kheight20,
                            CustomTextFeild2(
                             readOnly: true,
                              sufixbutton: const Icon(
                                Icons.arrow_drop_down,
                                size: 40,
                              ),
                              tap: () {
                                showBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .5,
                                        child: ListView(
                                          children: [
                                            ListTile(
                                              onTap: () {
                                                workController.text = 'Plumber';
                                                context
                                                    .read<
                                                        JobApplicationEmployeBloc>()
                                                    .add(UserWork(
                                                        workController.text));
                                                Navigator.pop(context);
                                              },
                                              title: const Text('Plumber'),
                                            ),
                                            ListTile(
                                              onTap: () {
                                                workController.text = 'Gardner';
                                                context
                                                    .read<
                                                        JobApplicationEmployeBloc>()
                                                    .add(UserWork(
                                                        workController.text));
                                                Navigator.pop(context);
                                              },
                                              title: const Text('Gardner'),
                                            )
                                          ],
                                        ),
                                      );
                                    });
                              },
                              controller: workController,
                              heading: ' Work type',
                              hinttext: 'e.g. Plumber, Electrician etc',
                            ),
                            AppConstants.kheight20,
                            CustomTextFeild2(
                              onChanged: (p0) => context
                                  .read<JobApplicationEmployeBloc>()
                                  .add(UserExperience(int.parse(p0))),
                              controller: yearsController,
                              heading: 'Years of experience',
                              hinttext: 'Years of experience',
                              keybordtype: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your years of experience';
                                }
                                final numericValue = int.tryParse(value);
                                if (numericValue == null) {
                                  return 'Please enter a valid number';
                                } else if (numericValue < 0 ||
                                    numericValue > 20) {
                                  return 'Please enter a value between 0 and 20';
                                }
                                return null;
                              },
                            ),
                            AppConstants.kheight20,
                            CustomTextFeild2(
                             readOnly: true,
                              controller: idProofController,
                              sufixbutton: const Icon(Icons.attachment),
                              tap: () async {
                                final proofUrl = await ProjectFunctionalites
                                    .imagePickercir();
                                if (proofUrl != null) {
                                  final imgurl = proofUrl.path;
                                  context
                                      .read<JobApplicationEmployeBloc>()
                                      .add(IdProof(imgurl));
                                  idProofController.text = state.proofUser!;
                                }
                              },
                              hinttext: 'Add Id Proof',
                              heading: 'ID-Proof',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your years of experience';
                                }
                                return null;
                              },
                            ),
                            AppConstants.kheight30,
                            GestureDetector(
                                onTap: () {
                                  if (formkey.currentState!.validate()) {
                                    context
                                        .read<JobApplicationEmployeBloc>()
                                        .add(FormSubmit());
                                    formkey.currentState!.reset();
                                  }
                                },
                                child: LoginContainer(content: 'Submit')),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
