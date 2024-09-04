import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/adress_add_user/add_address_user_bloc.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/profile/adress_user/refact_add_adress.dart';

class AddAdressPage extends StatelessWidget {
  const AddAdressPage({super.key});

  @override
  Widget build(BuildContext context) {
 
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocConsumer<AddAddressUserBloc, AddAddressUserState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add Address'),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AddressContentWidget(formKey: formKey),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
