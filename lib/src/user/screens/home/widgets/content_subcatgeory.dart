import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/add_cart_user/add_cart_user_bloc.dart';
import 'package:metrogeniusapp/bloc/details_subcategory/details_sub_catgeory_bloc.dart';
import 'package:metrogeniusapp/bloc/get_user_rating/get_user_rating_bloc.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';
import 'package:metrogeniusapp/src/user/widgets/home/sub_catgeory/custom_checkbox.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';

class SubCategoryViewContent extends StatefulWidget {
  SubCategoryViewContent({
    super.key,
    this.checkBoxData,
    required this.data,
    required this.trueKeys,
    required this.selectedCheckboxNotifier,
  });

  final Map<String, bool>? checkBoxData;
  final dynamic data;
  final ValueNotifier<String?> selectedCheckboxNotifier;
  final List<String> trueKeys;

  @override
  _SubCategoryViewContentState createState() => _SubCategoryViewContentState();
}

class _SubCategoryViewContentState extends State<SubCategoryViewContent> {
  bool _showAllRatings = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 285,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(90)),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .7,
        child: Padding(
          padding: const EdgeInsets.only(left: 37, top: 40, right: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '₹ ${widget.data['CatPrice']}',
                  style: const TextStyle(
                    color: AppColors.mainBlueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                AppConstants.kheight10,
                Row(
                  children: [
                    Text(
                      '${widget.data['CatName']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppConstants.kwidth20,
                        Text(
                          '${widget.data['CatRating']}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  ],
                ),
                AppConstants.kheight10,
                ...widget.trueKeys.map((key) {
                  return Column(
                    children: [
                      AppConstants.kheight10,
                      CustomCheckboxListTile(
                        title: key,
                        initialValue: widget.selectedCheckboxNotifier.value == key,
                        onChanged: (bool? value) {
                          if (value == true) {
                            widget.selectedCheckboxNotifier.value = key;
                          } else {
                            if (widget.selectedCheckboxNotifier.value == key) {
                              widget.selectedCheckboxNotifier.value = null;
                            }
                          }

                          context.read<DetailsSubCatgeoryBloc>().add(
                                CheckBoxChnages(key, value!),
                              );
                          context.read<AddCartUserBloc>().add(
                                CartCheckBoxChnages(key, value),
                              );
                        },
                        activeColor: AppColors.mainBlueColor,
                        checkColor: Colors.white,
                        titleStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
                AppConstants.kheight10,
                const Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                AppConstants.kheight10,
                Text(
                  widget.data['CatDes'],
                  style: const TextStyle(
                    color: AppColors.greyColor,
                    fontSize: 14,
                  ),
                ),
                AppConstants.kheight10,
                Text(
                  'Reviews & Ratings',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                BlocProvider(
                  create: (context) => GetUserRatingBloc(AddressServiceUser())
                    ..add(FetchUserRaingData(widget.data['CatName'])),
                  child: BlocConsumer<GetUserRatingBloc, GetUserRatingState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is GetUserRatingLoaded) {
                        final ratingsData = state.data;
                        final int ratingsToShow = _showAllRatings
                            ? ratingsData.length
                            : (ratingsData.length > 2 ? 2 : ratingsData.length);

                        return Column(
                          children: [
                            Column(
                              children: List.generate(ratingsToShow, (index) {
                                final userId = ratingsData[index]['UserId'];
                                return FutureBuilder<Map<String, dynamic>>(
                                  future: fetchUserDetails(userId),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(child: CupertinoActivityIndicator());
                                    } else if (snapshot.hasError) {
                                      return Center(child: Text('Error: ${snapshot.error}'));
                                    } else if (!snapshot.hasData || snapshot.data == null) {
                                      return Center(child: Text('User not found'));
                                    } else {
                                      final userData = snapshot.data!;
                                      return ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(userData['UserImage']),
                                          radius: 20,
                                        ),
                                        title: Text(userData['UserName']),
                                        subtitle: Row(
                                          children: [
                                            Text(ratingsData[index]['RatingDes']),
                                            Spacer(),
                                            Row(
                                              children: [
                                                Text('${state.data[index]['RatingStarCount'].toString()}'),
                                                Icon(Icons.star, color: Colors.amber),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                );
                              }),
                            ),
                            if (ratingsData.length > 2)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _showAllRatings = !_showAllRatings;
                                  });
                                },
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(_showAllRatings ? 'View Less' : 'View More ')),
                              ),
                          ],
                        );
                      }
                      return Center(child: Text('Loading'));
                    },
                  ),
                ),
                AppConstants.kheight60,
                AppConstants.kheight60
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> fetchUserDetails(String userId) async {
    final userSnapshot = await FirebaseFirestore.instance
        .collection('UserDetails')
        .doc(userId)
        .get();
    return userSnapshot.data()!;
  }
}
