import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrogeniusapp/bloc/Admin/accept_reject/accept_reject_bloc.dart';
import 'package:metrogeniusapp/bloc/Admin/application_listing/application_listing_bloc.dart';
import 'package:metrogeniusapp/bloc/job_application/job_application_employe_bloc.dart';
import 'package:metrogeniusapp/bloc/login_bloc/user_login_bloc.dart';
import 'package:metrogeniusapp/bloc/signup_bloc/bloc/user_signup_bloc.dart';
import 'package:metrogeniusapp/firebase_options.dart';
import 'package:metrogeniusapp/services/admin/applications/admin_services.dart';
import 'package:metrogeniusapp/services/auth.dart';
import 'package:metrogeniusapp/services/auth_signin.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/users_login.dart';
import 'package:metrogeniusapp/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserSignupBloc(AuthRepo()),
        ),
        BlocProvider(create: (context) => UserLoginBloc(UserSigninAuth())),
        BlocProvider(create: (context) => JobApplicationEmployeBloc()),
        BlocProvider(create: (context)=>ApplicationListingBloc(AdminServices())),
        BlocProvider(
          create: (context) => AcceptRejectBloc(),
        )
      ],
      child: MaterialApp(
          theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
          debugShowCheckedModeBanner: false,
          color: AppColors.primaryColor,
          home: CommonLoginPage()),
    );
  }
}
