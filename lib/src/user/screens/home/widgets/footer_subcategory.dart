import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusapp/bloc/details_subcategory/details_sub_catgeory_bloc.dart';
import 'package:metrogeniusapp/src/user/widgets/home/sub_catgeory/sub_catgeory.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class SubCategoryViewFooter extends StatelessWidget {
   SubCategoryViewFooter({
    super.key,
    required this.data, required this.state,
    required this.bookNow,
    required this.cartNow
  });

  final  data;
  void Function()?bookNow;
  void Function()?cartNow;
  final DetailsSubCatgeoryState state;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: 130,
          width: double.infinity,
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 0),
                    blurRadius: 1,
                    spreadRadius: .1)
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 15),
                child: Text(
                    'Total :' +
                        ' INR '
                            '${data['CatPrice'] * state.numberOfUnits}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
              AppConstants.kheight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LoginContainer1(
                    onTap: cartNow,
                    content: 'To Cart',
                  ),
                  LoginContainer1(
                    onTap:bookNow,
                    content: 'Book Now',
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}