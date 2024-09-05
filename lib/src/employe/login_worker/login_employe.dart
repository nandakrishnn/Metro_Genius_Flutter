import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/worker/sigin_worker/worker_sign_in_bloc.dart';
import 'package:metrogeniusapp/src/employe/bottom_navigation/employe_bottom_nav.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/src/user/widgets/custom_snackbar.dart';
import 'package:metrogeniusapp/src/user/widgets/textfeild.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import 'package:metrogeniusapp/utils/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeLogin extends StatelessWidget {
  const EmployeLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _codeController = TextEditingController();
    final GlobalKey<FormState> formkey = GlobalKey<FormState>();
    bool _snackBarShown = false;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocConsumer<WorkerSignInBloc, WorkerSignInState>(
        listener: (context, state) async {
          if (state.status == WorkerSigninFormStatus.sucess) {
               _snackBarShown = false;
                SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setString('EmployeAssigned', _codeController.text);
               _emailController.clear();
                _codeController.clear();
                  context.read<WorkerSignInBloc>().add(WorkerReset());
            Navigator.of(context)
                .push(createRoute(const WorkerBottomNavigation()));
        
          }
          if (state.status == WorkerSigninFormStatus.pending) {}

          if (state.status == WorkerSigninFormStatus.error&& !_snackBarShown) {
      _snackBarShown = true; 
            ScaffoldMessenger.of(context).showSnackBar(customSnack(
                'Invalid Login',
                'Sorry,invalid login credentials',
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 28,
                ),
                Colors.red));
          }
        },
        builder: (context, state) {
          return Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .08,
                        ),
                        const Text(
                          'Welcome back Worker! Glad to see you, Again!',
                          style: TextStyle(
                              fontSize: 31, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .06,
                        ),
                        CustomTextFeild(
                          onChanged: (p0) => context
                              .read<WorkerSignInBloc>()
                              .add(WorkerEmailChanges(p0)),
                          controller: _emailController,
                          obscure: false,
                          hinttext: 'Enter your Email',
                          validator: (value) => Validators.validateEmail(value),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .04,
                        ),
                        CustomTextFeild(
                          onChanged: (p0) => context
                              .read<WorkerSignInBloc>()
                              .add(WorkerPassChanges(p0)),
                          obscure: true,
                          hinttext: 'Enter your EmployeeCode',
                          controller: _codeController,
                          sufixbutton: const Icon(Icons.remove_red_eye_sharp),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your EmployeCode';
                            }

                            return null;
                          },
                        ),
                        AppConstants.kheight10,
                        const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Facing Problem Contact Us?',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(106, 112, 124, .99)),
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .04,
                        ),
                        AppConstants.kheight30,
                        GestureDetector(
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                 _snackBarShown = false; 
                                context
                                    .read<WorkerSignInBloc>()
                                    .add(WorkerFormSubmit());
                              }
                            },
                            child: LoginContainer(content: 'Login')),
                        AppConstants.kheight30,
                        AppConstants.kheight60,
                        AppConstants.kheight30,
                        AppConstants.kheight30,
                        AppConstants.kheight30,
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Plans are only good intentions unless they\n immediately degenerate into hard work.',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(106, 112, 124, .99),
                              ),
                            ),
                            AppConstants.kheight10,
                            Text(
                              'Work More Earn More !',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(53, 194, 193, 1)),
                            ),
                          ],
                        )
                      ]),
                ),
              ));
        },
      ),
    );
  }


}
