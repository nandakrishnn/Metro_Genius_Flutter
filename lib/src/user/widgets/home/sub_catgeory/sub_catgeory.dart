import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/colors.dart';

class AddElevatedButtonCustom extends StatelessWidget {
  String? text;
  void Function()? onPressed;

  AddElevatedButtonCustom({
    this.text,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text!,
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainBlueColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        minimumSize: Size(40, 40),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }
}

class LoginContainer1 extends StatelessWidget {
  String content;
  void Function()? onTap;
  LoginContainer1({
    required this.content,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 160,
        decoration: BoxDecoration(
            color: AppColors.mainBlueColor,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          content,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        )),
      ),
    );
  }
}
