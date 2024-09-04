
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileTiles extends StatelessWidget {
  String title;
  String Subtitle;
  Icon icons;
  VoidCallback? action;
  void Function()?ontap;
   ProfileTiles({
    required this.title,
    required this.Subtitle,
    required this.icons,
     this.action,
     this.ontap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: MediaQuery.of(context).size.height * .111,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromARGB(156, 248, 246, 246),
              boxShadow: [
                BoxShadow(
                    color: Color.fromARGB(248, 210, 211, 214),
                    offset: Offset(0, 0),
                    spreadRadius: .7,
                    blurRadius: 1)
              ],
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: ListTile(
              title: Text(title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              subtitle: Text(Subtitle),
              trailing: icons,
              
            ),
          ),
        ),
      ),
    );
  }
}

