import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/colors.dart';

class SubCatgeoryViewHeader extends StatelessWidget {
  const SubCatgeoryViewHeader({
    super.key,
    required this.data,
  });

  final  data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.mainBlueColor,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .45,
          child: Image.network(
            data['CatImage'],
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: Colors.blue,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .55,
        ),
      ],
    );
  }
}
