import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/details_subcategory/details_sub_catgeory_bloc.dart';
import 'package:metrogeniusapp/src/user/widgets/home/sub_catgeory/custom_checkbox.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/constants.dart';

class SubCategoryViewContent extends StatelessWidget {
  SubCategoryViewContent({
    super.key,
    required this.data,
    required this.trueKeys,
    required this.selectedCheckboxNotifier,
  });

  final dynamic data;
  final ValueNotifier<String?> selectedCheckboxNotifier;
  final List<String> trueKeys;

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
                  '₹ ${data['CatPrice']}',
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
                      '${data['CatName']}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AppConstants.kwidth20,
                        Text(
                          '4.5',
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
                ...trueKeys.map((key) {
                  return Column(
                    children: [
                      AppConstants.kheight10,
                      CustomCheckboxListTile(
                        title: key,
                        initialValue: selectedCheckboxNotifier.value == key,
                        onChanged: (bool? value) {
                          if (value == true) {
                            selectedCheckboxNotifier.value = key;
                          } else {
                            if (selectedCheckboxNotifier.value == key) {
                              selectedCheckboxNotifier.value = null;
                            }
                          }
                          // Optionally, you can dispatch an event to the Bloc
                          context.read<DetailsSubCatgeoryBloc>().add(
                            CheckBoxChnages(key, value!),
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
                  data['CatDes'],
                  style: const TextStyle(
                    color: AppColors.greyColor,
                    fontSize: 16,
                  ),
                ),
                AppConstants.kheight60,
                const SizedBox(
                  height: 130,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
