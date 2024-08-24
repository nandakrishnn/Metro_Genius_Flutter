import 'package:flutter/material.dart';
import 'package:metrogeniusapp/src/user/screens/home/rating/star_widget.dart';

class RatingHome extends StatelessWidget {
  String workerId;
  String userId;
String subcatgeoryName;
   RatingHome({super.key,required this.userId,required this.workerId,required this.subcatgeoryName});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Rating'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            StarRatingWidget()
          ],
        ),
      )
    );
  }
}