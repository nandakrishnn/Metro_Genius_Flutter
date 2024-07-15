import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/src/widgets/textfeild.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppConstants.kheight60,
              const Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 29, fontWeight: FontWeight.w800),
              ),
              AppConstants.kheight10,
              const Text(
                'Dont worry! It occurs. Please enter the email address linked with your account',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(106, 112, 124, .99)),
              ),
              AppConstants.kheight30,
              TextFeild(hinttext: 'Enter Your Email', obscure: false),
              AppConstants.kheight60,
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.mainBlueColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child: Text(
                  'Send Code',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800),
                )),
              ),
              AppConstants.kheight60,
              AppConstants.kheight60,
              AppConstants.kheight60,
              AppConstants.kheight60,
              AppConstants.kheight60,
              AppConstants.kheight60,
              AppConstants.kheight30,
              const Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Remember Password?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(106, 112, 124, .99),
                      ),
                    ),
                    Text(
                      ' Login',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(53, 194, 193, 1)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
