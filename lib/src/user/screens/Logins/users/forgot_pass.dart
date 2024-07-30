import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/forgot_pass/frogot_password_bloc.dart';
import 'package:metrogeniusapp/src/user/widgets/custom_snackbar.dart';
import 'package:metrogeniusapp/src/user/widgets/textfeild.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController=TextEditingController();
    GlobalKey<FormState>formkey=GlobalKey<FormState>();
        bool isSuccessSnackBarShown = false;
    bool isErrorSnackBarShown = false;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      backgroundColor: AppColors.primaryColor,
      body: BlocConsumer<FrogotPasswordBloc, FrogotPasswordState>(
        listener: (context, state) {
          if (state.status == UserFormStatus.sucess && !isSuccessSnackBarShown) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnack(
                'Password reset link sent                     ',
                'Kindly check your email to get the reset link',
                Icon(Icons.done),
                Colors.green,
              ),
            );
            isSuccessSnackBarShown = true; 
          } else if (state.status == UserFormStatus.error && !isErrorSnackBarShown) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnack(
                'Sorry',
                'Kindly try again',
                Icon(Icons.error),
                Colors.red,
              ),
            );
            isErrorSnackBarShown = true;
          }
        },
        builder: (context, state) {
        
          if (state.status != UserFormStatus.sucess) {
            isSuccessSnackBarShown = false;
          }
          if (state.status != UserFormStatus.error) {
            isErrorSnackBarShown = false;
          }
          
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                child: Form(
                  key: formkey,
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
                      CustomTextFeild(hinttext: 'Enter Your Email', obscure: false,controller: emailController,
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
                      onChanged: (p0) => context.read<FrogotPasswordBloc>().add(UserEmailChanges(emailController.text)),
                      ),
                      AppConstants.kheight60,
                      GestureDetector(
                        onTap: (){
                          if(formkey.currentState!.validate()){
                            context.read<FrogotPasswordBloc>().add(PassFormSubmit());
                                //  Navigator.pop(context);
                            // if(state.status==UserFormStatus.sucess){
                         
                            // }
                          }
                        },
                        child: Container(
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
            ),
          );
        },
      ),
    );
  }
}
