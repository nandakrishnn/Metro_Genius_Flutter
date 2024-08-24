import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/add_cart_user/add_cart_user_bloc.dart';
import 'package:metrogeniusapp/bloc/details_subcategory/details_sub_catgeory_bloc.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/saved/like_button.dart';
import 'package:metrogeniusapp/src/user/widgets/home/sub_catgeory/sub_catgeory.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';



class SubCategoryViewFooter extends StatelessWidget {
  SubCategoryViewFooter({
    super.key,
    required this.categoryHeading,
    required this.data,
    required this.state,
    required this.bookNow,
    required this.cartNow,
  });

  final data;
  String categoryHeading;
  void Function()? bookNow;
  void Function()? cartNow;
  final DetailsSubCatgeoryState state;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        
        width: double.infinity,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 0),
              blurRadius: 1,
              spreadRadius: .1,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 30, top: 15),
            //   child: Text(
            //     'Total: INR ${data['CatPrice'] * state.numberOfUnits}',
            //     style: const TextStyle(
            //       color: Colors.black,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 18,
            //     ),
            //   ),
            // ),
            AppConstants.kheight10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BlocConsumer<AddCartUserBloc, AddCartUserState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return FutureBuilder<bool>(
                      future: AddressServiceUser().isAlreadyFavourited(
                        data['CatName'],
                        FirebaseAuth.instance.currentUser!.uid,
                      ),
                      builder: (context, snapshot) {
                        bool isFavorited =
                            snapshot.hasData && snapshot.data == true;

                        return Container(
                          height: 55,
                          width: 160,
                          decoration: BoxDecoration(
                            color: AppColors.mainBlueColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomLikeButton(
                                  isFavorited: isFavorited,
                                  onLikeButtonTapped: (bool isLiked) async {
                                    if (isLiked) {
                
                                      final removalSuccess =
                                          await AddressServiceUser()
                                              .removeUserSaved(data['Id']);
                                      if (removalSuccess) {
                                        context.read<AddCartUserBloc>().add(
                                            CartCheckBoxUnSave(
                                                data['Id'],
                                                FirebaseAuth.instance
                                                    .currentUser!.uid));
                                      }
                                      return !removalSuccess;
                                    } else {
                                      // Add to favorites
                                      context.read<AddCartUserBloc>().add(
                                          SubCategoryIdChanges(data['Id']));
                                      context.read<AddCartUserBloc>().add(
                                          SubCatgeoryImage(data['CatImage']));
                                      context.read<AddCartUserBloc>().add(
                                          SubCategoryHeading(data['CatName']));
                                      context
                                          .read<AddCartUserBloc>()
                                          .add(ItemPrice(data['CatPrice']));
                                      context
                                          .read<AddCartUserBloc>()
                                          .add(CategoryName(categoryHeading));
                                      context
                                          .read<AddCartUserBloc>()
                                          .add(CategoryDes(data['CatDes']));
                                      context
                                          .read<AddCartUserBloc>()
                                          .add(FormSubmit());

                                      return true;
                                    }
                                  },
                                ),
                                AppConstants.kwidth5,
                                Text(
                                  isFavorited ? 'Favorited' : 'Favourite',
                                  style: TextStyle(
                                    color:
                                        isFavorited ? Colors.red : Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                LoginContainer1(
                  onTap: bookNow,
                  content: 'Book Now',
                ),
                
              ],
            ),
            AppConstants.kheight15
          ],
        ),
      ),
    );
  }
}
