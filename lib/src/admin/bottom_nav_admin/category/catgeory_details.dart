import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/Admin/catgeories_admin/categories_bloc.dart';
import 'package:metrogeniusapp/functions/project_functions.dart';
import 'package:metrogeniusapp/services/admin/converters/image_converter.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/src/user/widgets/custom_snackbar.dart';
import 'package:metrogeniusapp/src/user/widgets/textfeild.dart';
import 'package:metrogeniusapp/utils/constants.dart';

class AddCatgeoryDetails extends StatelessWidget {
  const AddCatgeoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController categoryName = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? catgeoryImage;
    return BlocConsumer<CategoriesBloc, CategoriesState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppConstants.kheight60,
                    GestureDetector(
                      onTap: () async {
                        final img =
                            await ProjectFunctionalites().imagePickercir();
                        if (img != null) {
                          context
                              .read<CategoriesBloc>()
                              .add(CatgeoriesImageChanges(img.path));
                          catgeoryImage = img.path;
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black12,
                            ),
                            height: 200,
                            width: 200,
                            child: catgeoryImage != null
                                ? Image.file(
                                    File(
                                      catgeoryImage!,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    'https://www.shutterstock.com/image-vector/add-photo-icon-vector-line-260nw-1039350133.jpg',
                                    fit: BoxFit.cover,
                                  )),
                      ),
                    ),
                    AppConstants.kheight60,
                    CustomTextFeild(
                        controller: categoryName,
                        onChanged: (p0) => context
                            .read<CategoriesBloc>()
                            .add(TextChanges(categoryName.text)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          if (value.length < 2) {
                            return 'Catgeory Name must be at least 2 characters long';
                          }
                          if (value.length > 50) {
                            return 'Catgeory Name must not exceed 50 characters';
                          }
                          return null;
                        },
                        hinttext: 'Category Name',
                        obscure: false),
                    AppConstants.kheight60,
                    GestureDetector(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            if (catgeoryImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  customSnack(
                                      'Select Image',
                                      'Select Image to Proceed',
                                      Icon(Icons.error),
                                      Colors.red));
                            }
                            if (catgeoryImage != null) {
                              final image = await uploadImageToFirebase(
                                  File(catgeoryImage!));
                              context
                                  .read<CategoriesBloc>()
                                  .add(CatgeoriesImageChanges(image!));
                              context.read<CategoriesBloc>().add(CategoriesFormSubmit());
                                Navigator.of(context).pop();
                            }
                          
                          }
                        },
                        child: LoginContainer(content: 'Submit'))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
