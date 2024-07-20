import 'package:flutter/material.dart';

class ProfileContainers extends StatelessWidget {
  String imgurl;
  String text;
  ProfileContainers({
    required this.imgurl,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 92,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color.fromARGB(248, 210, 211, 214),
              offset: Offset(0, 0),
              spreadRadius: .7,
              blurRadius: 1)
        ],
        borderRadius: BorderRadius.circular(14),
        color: Color.fromARGB(156, 248, 246, 246),
      ),
      child: Column(
        children: [
          SizedBox(
              height: 70,
              width: 80,
              child: Image.asset(
                imgurl,
                fit: BoxFit.cover,
              )),
          Text(
            text,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(248, 114, 109, 109)),
          )
        ],
      ),
    );
  }
}
