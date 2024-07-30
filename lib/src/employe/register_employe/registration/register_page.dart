// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/Admin/get_category/get_category_bloc.dart';
import 'package:metrogeniusapp/bloc/job_application/job_application_employe_bloc.dart';
import 'package:metrogeniusapp/functions/project_functions.dart';
import 'package:metrogeniusapp/services/admin/converters/image_converter.dart';
import 'package:metrogeniusapp/src/employe/widgets/custom_textfeild.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/users_login.dart';
import 'package:metrogeniusapp/src/user/widgets/custom_snackbar.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import 'package:metrogeniusapp/utils/validators.dart';

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
    String? proofimage;

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
            if (state.status == FormStatus.pending) {
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/uniformed-technician-utilizing-tablet-inspect-air-conditioning-filter-maintenance-cleaning-ac-maintenance-home-service-concept_117038-31199.jpg'))),
                child: const Center(
                  child: CupertinoActivityIndicator(
                    radius: 50,
                    color: Colors.green,
                  ),
                ),
              );
            }
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
            }
          },
          builder: (context, state) {
            // if (state.status == FormStatus.pending) {
            //   return const Center(
            //     child: CupertinoActivityIndicator(
            //       radius: 50,
            //       color: Colors.green,
            //     ),
            //   );
            // }

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
                                final img = await ProjectFunctionalites()
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
                              validator: (value) =>Validators.validateName(value)
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
                              validator: (value) =>Validators.validatePhoneNumber(value),
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
                              validator: (value) =>Validators.validateEmail(value)
                            ),
                            AppConstants.kheight20,
                            CustomTextFeild2(
                            readOnly: true,
                                  //  onChanged: (value) => context.read<JobApplicationEmployeBloc>().add(UserWorkType(workController.text)),
                              sufixbutton: const Icon(
                                Icons.arrow_drop_down,
                                size: 40,
                              ),
                              tap: () {
                                showBottomSheet(
                                    showDragHandle: true,
                                    enableDrag: true,
                                    context: context,
                                    builder: (context) {
                                      context
                                          .read<GetCategoryBloc>()
                                          .add(FetchDataCategory());

                                      return BlocBuilder<GetCategoryBloc,
                                              GetCategoryState>(
                                          builder: (context, state) {
                                        if (state is GetCategoryStateLoading) {
                                          return const Center(
                                            child: CupertinoActivityIndicator(),
                                          );
                                        }
                                        if (state is GetCategoryStateLoaded) {
                                          final data = state.data;
                                          return SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .5,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ListView.builder(
                                                    itemCount: data.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                          final doc=data[index];
                                                      return GestureDetector(
                                                        onTap: () {
                                                          workController
                                                              .text =doc['CatgeoryName'];
                                                             context.read<JobApplicationEmployeBloc>().add(UserWorkType(doc['CatgeoryName']));
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: ListTile(
                                                          minVerticalPadding: 2,
                                                          autofocus: true,
                                                          hoverColor:
                                                              Colors.blue,
                                                          leading: CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(data[
                                                                        index][
                                                                    'CategoryImage']),
                                                            radius: 25,
                                                          ),
                                                          title: Text(data[
                                                                  index]
                                                              ['CatgeoryName']),
                                                        ),
                                                      );
                                                    }),
                                              ));
                                        } else {
                                          return Container();
                                        }
                                      });
                                    });
                              },
                              controller: workController,
                              heading: ' Work type',
                              hinttext: 'e.g. Plumber, Electrician etc',
                              
                              validator: (p0) {
                                
                                if(p0==null||p0.isEmpty){
                                  return 'Selec work type';
                                }return null;
                              },
                              
                         
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
                              validator:(value)=>Validators.validateYearsOfExperience(value)
                            ),
                            AppConstants.kheight20,
                            CustomTextFeild2(
                              readOnly: true,
                              controller: idProofController,
                              sufixbutton: const Icon(Icons.attachment),
                              tap: () async {
                                final proofUrl = await ProjectFunctionalites()
                                    .imagePickercir();
                                if (proofUrl != null) {
                                  final File idProofFile = File(proofUrl.path);
                                  proofimage = proofUrl.path;

                                  idProofController.text = idProofFile.path;
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
                            AppConstants.kheight10,
                            Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                                child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .9,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .4,
                                                    child: proofimage != null
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            child: DecoratedBox(
                                                              decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: FileImage(File(
                                                                        proofimage!,
                                                                      )),
                                                                      fit: BoxFit.cover)),
                                                            ),
                                                          )
                                                        : const Center(
                                                            child: Text(
                                                                'Select proof to preview here'),
                                                          )));
                                          });
                                    },
                                    child: const Text(
                                      'View proof',
                                      style: TextStyle(
                                          color: AppColors.primaryColor),
                                    ))),
                            AppConstants.kheight30,
                            GestureDetector(
                                onTap: () async {
                                  if (formkey.currentState!.validate()) {
                                    if (profileimg == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(customSnack(
                                              'Choose Image',
                                              'Choose an image to continue',
                                              const Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                              Colors.red));
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        customSnack(
                                            'Uploading Details',
                                            'Please wait for confirmation',
                                            const Icon(Icons.pending),
                                            Colors.blue));
                                    // context.read<JobApplicationEmployeBloc>().add(form)
                                    String? imageDownloadUrl;
                                    String? idDownloadUrl;
                                    imageDownloadUrl =
                                        await uploadImageToFirebase(
                                            File(profileimg!));
                                    idDownloadUrl = await uploadImageToFirebase(
                                        File(idProofController.text));

                                    if (imageDownloadUrl != null) {
                                      context
                                          .read<JobApplicationEmployeBloc>()
                                          .add(ImageChanges(imageDownloadUrl));
                                    }
                                    if (idDownloadUrl != null) {
                                      context
                                          .read<JobApplicationEmployeBloc>()
                                          .add(IdProof(idDownloadUrl));
                                    }
                                    context
                                        .read<JobApplicationEmployeBloc>()
                                        .add(FormSubmit());
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        customSnack(
                                            'Sucess',
                                            ' Details Submitted',
                                            const Icon(Icons.done),
                                            Colors.green));
                                    await Future.delayed(
                                        const Duration(milliseconds: 700));
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
