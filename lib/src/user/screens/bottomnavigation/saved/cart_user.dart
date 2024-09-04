import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/add_cart_user/add_cart_user_bloc.dart';
import 'package:metrogeniusapp/bloc/get_cart_user/get_cart_details_user_bloc.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';
import 'package:metrogeniusapp/src/user/screens/home/sub_catgeories/details_subcatgeory.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class UserCart extends StatelessWidget {
  const UserCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Saved'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: BlocProvider(
          create: (context) => GetCartDetailsUserBloc(AddressServiceUser())
            ..add(FetchCartData(FirebaseAuth.instance.currentUser!.uid)),
          child: BlocConsumer<GetCartDetailsUserBloc, GetCartDetailsUserState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetCartDetailsUserLoaded) {
                if (state.data.isEmpty) {
                  return Center(
                    child: Text('Add to favourites to view here ;)'),
                  );
                }
                final data = state.data;

                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      print(data[index]['Id']);
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(createRoute(InsideSubCatgeory(
                            categoryType: data[index]['ServiceType'],
                            data: data[index],
                          )));
                        },
                        child: CartUserViewWidget(
                            onTap: () {
                              context.read<AddCartUserBloc>().add(
                                  CartCheckBoxUnSave(data[index]['Id'],
                                      FirebaseAuth.instance.currentUser!.uid));
                            },
                            data: data[index],
                              catRating: data[index]['CatRating'],
                            des: data[index]['CatDes'],
                            categorytype: data[index]['CatName'],
                            heading: data[index]['ServiceType'],
                            price: data[index]['CatPrice'],
                            image: data[index]['CatImage']),
                      );
                    });
              }
              return Center(
                child: Text('sorry'),
              );
            },
          ),
        ));
  }
}

class CartUserViewWidget extends StatelessWidget {
  final data;
  String heading;
  String? des;
  int price;
  String image;
  String categorytype;
  double catRating;
  void Function()? onTap;
  CartUserViewWidget({
    required this.catRating,
    this.onTap,
    required this.data,
    this.des,
    required this.categorytype,
    required this.heading,
    required this.price,
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 1),
              blurRadius: 1,
              spreadRadius: 1,
              color: AppColors.greyColor.withOpacity(0.5),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primaryColor,
        ),
        height: 260,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.lightPurple,
                    ),
                    height: 180,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                        ))),
                Positioned(
                    top: 13,
                    right: 16,
                    child: IconButton(
                        onPressed: onTap,
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        ))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 5, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        categorytype,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      AppConstants.kwidth10,
                    
                    ],
                  ),
                  AppConstants.kheight5,
                  Row(
                    children: [
                      Text(
                        '₹' + price.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainBlueColor),
                      ),
                      AppConstants.kwidth10,
                        Row(
                        children: [
                          Icon(Icons.star,color: Colors.amber,),
                          Text(catRating.toString())
                        ],
                      )
                    ],
                  ),
                  Text(
                      style: TextStyle(color: AppColors.greyColor),
                      overflow: TextOverflow.ellipsis,
                      des!),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
