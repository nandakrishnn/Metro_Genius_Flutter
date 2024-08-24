
// ignore: must_be_immutable
import 'package:flutter/widgets.dart';
import 'package:metrogeniusapp/utils/colors.dart';

// ignore: must_be_immutable
class LoginCards extends StatelessWidget {
  LoginCards(
      {super.key,
      required this.heading,
      required this.content,
      required this.imageurl,
      this.action,
      required this.radius});
  String heading;
  String content;
  String imageurl;
  BorderRadius radius;
  void Function()?action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        height: MediaQuery.of(context).size.height * .2,
        width: MediaQuery.of(context).size.width * .94,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 75, 72, 72).withOpacity(.2),
            spreadRadius: 5,
            blurRadius: 7,
          )
        ], color: AppColors.secondryColor, borderRadius: radius),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                    shadows:[Shadow(
                          offset: Offset(1.0, 1.0),
                      color: AppColors.primaryColor
                    )]),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    content,
                    style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500,color: Color.fromARGB(255, 107, 104, 104)),
                  )
                ],
              ),
            ),
      
            Image.asset(imageurl,fit: BoxFit.cover,)
          ],
        ),
      ),
    );
  }
}    
