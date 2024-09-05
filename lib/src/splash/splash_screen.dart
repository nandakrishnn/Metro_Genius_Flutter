import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Simulate a delay for splash screen
    await Future.delayed(const Duration(seconds: 3)); // Adjust the delay as needed

    // Retrieve shared preferences to determine the next screen
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? workerId = prefs.getString('EmployeAssigned');
    final String? userId = prefs.getString('UserId');

    // Determine the next route
    if (userId != null) {
      Navigator.pushReplacementNamed(context, '/home'); // Navigate to user home
    } else if (workerId != null) {
      Navigator.pushReplacementNamed(context, '/employee_home'); // Navigate to employee home
    } else {
      Navigator.pushReplacementNamed(context, '/login'); // Navigate to login or initial onboarding
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 350,
                height: 100,
                child: Image.asset(
                  'assets/white_metro-removebg-preview.png',
                  fit: BoxFit.cover,
                ),
              ),
              const CustomLoadingAnimation(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: Colors.white,
      size: 30,
    );
  }
}
