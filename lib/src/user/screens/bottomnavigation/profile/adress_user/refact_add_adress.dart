import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/adress_add_user/add_address_user_bloc.dart';
import 'package:metrogeniusapp/src/employe/widgets/custom_textfeild.dart';
import 'package:metrogeniusapp/src/user/screens/Logins/users/login_user.dart';
import 'package:metrogeniusapp/src/user/widgets/custom_snackbar.dart';
import 'package:metrogeniusapp/utils/colors.dart';
import 'package:metrogeniusapp/utils/constants.dart';
import 'package:metrogeniusapp/utils/validators.dart';

class AddressContentWidget extends StatelessWidget {
  const AddressContentWidget({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFeild2(
          
            hinttext: 'Name',
            heading: 'Name',
            onChanged: (p0) => context.read<AddAddressUserBloc>().add(AddName(p0)),
            validator: (p0) => Validators.validateName(p0)),
        AppConstants.kheight15,
        //  CustomTextFeild2(hinttext: 'Adressline1', heading: 'Address'),
        //   AppConstants.kheight15,
        CustomTextFeild2(
          onChanged: (p0) => context.read<AddAddressUserBloc>().add(AddAdress(p0)),
            hinttext: 'Apartment,suite,etc.',
            heading: 'Address',
            validator: (p0) =>
                Validators.validateAddressLine(p0)),
        AppConstants.kheight15,
        CustomTextFeild2(
          onChanged: (p0) => context.read<AddAddressUserBloc>().add(AddCity(p0)),
            hinttext: 'City',
            heading: 'City',
            validator: (p0) => Validators.validateCity(p0)),
        AppConstants.kheight15,
        CustomTextFeild2(
          onChanged: (p0) => context.read<AddAddressUserBloc>().add(AddPhone(int.parse(p0))),
            hinttext: 'Phone No',
            heading: 'Phone No',
            keybordtype: TextInputType.number,
            validator: (p0) =>
                Validators.validatePhoneNumber(p0)),
        AppConstants.kheight20,
        Row(
          children: [
            Expanded(
              child: CustomTextFeild2(
                hinttext: 'State',
                onChanged: (p0) => context.read<AddAddressUserBloc>().add(AddState(p0)),
                validator: (p0) => Validators.validateState(p0),
                heading: 'State',
              ),
            ),
            AppConstants.kwidth10,
            Expanded(
              child: CustomTextFeild2(
                keybordtype: TextInputType.number,
                onChanged: (p0) => context.read<AddAddressUserBloc>().add(AddZipcode(int.parse(p0))),
                validator: (p0) => Validators.validateZipcode(p0),
                hinttext: 'Zipcode/PostCode',
                heading: 'Zipcode/PostCode',
              ),
            ),
          ],
        ),
                  AppConstants.kheight20,
        CustomTextFeild2(
                hinttext: 'Home,Work,etc..',
                onChanged: (p0) => context.read<AddAddressUserBloc>().add(AdressType(p0)),
                validator: (p0) => Validators.validateState(p0),
                heading: 'Adress Type',
              ),
        AppConstants.kheight30,
        GestureDetector(
          onTap: () {
            if (formKey.currentState!.validate()) {
              customSnack('Adding Adress', 'Adding adress', const Icon(Icons.pending), AppColors.mainBlueColor);
              context.read<AddAddressUserBloc>().add(AddressFormSubmit());
              Navigator.of(context).pop();
            }
          },
          child: LoginContainer(content: 'Add Address'),
        )
      ],
    );
  }
}
