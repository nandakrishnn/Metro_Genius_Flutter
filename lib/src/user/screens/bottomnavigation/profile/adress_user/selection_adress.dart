import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/get_adress_user/get_user_adresses_bloc.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';

class AddressSelectionSheet extends StatelessWidget {
  final Function(Map<String, dynamic>) onAddressSelected;

  AddressSelectionSheet({required this.onAddressSelected});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetUserAdressesBloc(AddressServiceUser())
        ..add(FetchDataAdress(FirebaseAuth.instance.currentUser!.uid)),
      child: BlocBuilder<GetUserAdressesBloc, GetUserAdressesState>(
        builder: (context, state) {
          if (state is GetUserAdressesLoaded) {
            final addresses = state.data;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: addresses.map<Widget>((address) {
                  return ListTile(
                    title: Text(address['AddressName']),
                    subtitle: Text(
                      '${address['AddressLine1']}, ${address['AddressCity']}, ${address['AddressState']}',
                    ),
                    onTap: () {
                      onAddressSelected(address as Map<String, dynamic>);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
