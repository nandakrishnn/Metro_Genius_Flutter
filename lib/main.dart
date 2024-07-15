import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrogeniusapp/firebase_options.dart';
import 'package:metrogeniusapp/src/screens/Logins/users/users_login.dart';
import 'package:metrogeniusapp/utils/colors.dart';



void main() async{


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
    return  MaterialApp(
      theme: ThemeData(fontFamily:GoogleFonts.poppins().fontFamily),
      debugShowCheckedModeBanner: false,
      color: AppColors.primaryColor,
      home: CommonLoginPage()
    );
  }
}