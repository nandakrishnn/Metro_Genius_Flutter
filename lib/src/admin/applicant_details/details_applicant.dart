import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/Admin/accept_reject/accept_reject_bloc.dart';
import 'package:metrogeniusapp/src/admin/applicant_details/applicant_deatils.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';

// ignore: must_be_immutable
class ApplicantDetails extends StatelessWidget {
  final data;

  ApplicantDetails({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<AcceptRejectBloc, AcceptRejectState>(
        listener: (context, state) {
          // if (state.rejectstatus == FormStatusReject.sucess) {
          //   ScaffoldMessenger.of(context).showSnackBar(customSnack(
          //       'Deleted',
          //       'Application rejected sucessfully!',
          //       const Icon(
          //         Icons.delete_forever,
          //         color: Colors.green,
          //       ),
          //       Colors.green));
          // }
          // if (state.rejectstatus == FormStatusReject.error) {
          //   ScaffoldMessenger.of(context).showSnackBar(customSnack(
          //       'Error in deletion',
          //       'Application not rejected !',
          //       const Icon(
          //         Icons.delete_forever,
          //         color: Colors.red,
          //       ),
          //       Colors.red));
          // }
          // if (state.acceptstatus == FormStatusAccpet.sucess) {
          //   ScaffoldMessenger.of(context).showSnackBar(customSnack(
          //       'Added',
          //       'Employee  accpected sucessfully!',
          //       const Icon(
          //         Icons.add,
          //         color: Colors.green,
          //       ),
          //       Colors.green));
          // }
          // if (state.acceptstatus == FormStatusAccpet.error) {
          //   ScaffoldMessenger.of(context).showSnackBar(customSnack(
          //       'Not added',
          //       'Employee not added !',
          //       const Icon(
          //         Icons.error,
          //         color: Colors.red,
          //       ),
          //       Colors.red));
          // }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.48,
                    width: MediaQuery.of(context).size.width * 0.6,
                    color: AppColors.lightPurple,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppConstants.kheight40,
                        CircleAvatar(
                            radius: 95,
                            backgroundImage:
                                NetworkImage(data['ApplicantImage'])),
                        AppConstants.kheight15,
                        Text(
                          data['ApplicantName'],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 7, top: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.42,
                      width: MediaQuery.of(context).size.width * 0.38,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppConstants.kheight30,
                          const Text(
                            'Positon applied',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          AppConstants.kheight5,
                          Text(
                            data['ApplicantWorkType'],
                            style: const TextStyle(
                                color: AppColors.mainBlueColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          AppConstants.kheight30,
                          const Text(
                            'Contact Number',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          AppConstants.kheight5,
                          Text(
                            data['ApplicantPhone'].toString(),
                            style: const TextStyle(
                                color: AppColors.mainBlueColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          AppConstants.kheight30,
                          const Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          AppConstants.kheight5,
                          Text(
                            data['ApplicantEmail'].toString(),
                            style: const TextStyle(
                                color: AppColors.mainBlueColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          AppConstants.kheight30,
                          const Text(
                            'Experience',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          AppConstants.kheight5,
                          Text(
                            data['ApplicantExperience'].toString(),
                            style: const TextStyle(
                                color: AppColors.mainBlueColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                color: AppColors.mainBlueColor,
                height: MediaQuery.of(context).size.height * 0.52,
                width: MediaQuery.of(context).size.width * 0.85,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            AlertBoxCustom(context,
                                'Are you sure you want to delete this employee request',
                                () {
                              Navigator.of(context).pop();
                            }, () {
                              context
                                  .read<AcceptRejectBloc>()
                                  .add(Rejected(data['Id']));
                              Navigator.of(context).pushReplacement(
                                  createRoute(ApplicantDeatils()));
                            });
                          },
                          child: const Text('Reject')),
                      AppConstants.kwidth20,
                      ElevatedButton(
                          onPressed: () {
                            AlertBoxCustom(context,
                                'Are you sure to appoint this employee', () {
                              Navigator.of(context).pop();
                            }, () {
                              context
                                  .read<AcceptRejectBloc>()
                                  .add(Accepted(data));
                              Navigator.of(context).pushReplacement(
                                  createRoute(ApplicantDeatils()));
                            });
                          },
                          child: const Text('Accept'))
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Future<dynamic> AlertBoxCustom(BuildContext context, String mainText,
      void Function()? onPressNo, void Function()? onPressYes) {
    return showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text(mainText),
            actions: [
              TextButton(onPressed: onPressNo, child: Text('NO')),
              TextButton(onPressed: onPressYes, child: Text('YES'))
            ],
          );
        });
  }
}
