import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/get_adress_user/get_user_adresses_bloc.dart';
import 'package:metrogeniusapp/bloc/order_summary/order_summary_bloc_bloc.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/profile/adress_user/add_adress.dart';
import 'package:metrogeniusapp/utils/colors.dart';

class AddressSelector extends StatefulWidget {
    final String? selectedDay;
  final String? selectedTime;
  const AddressSelector({super.key, this.selectedDay, this.selectedTime});

  @override
  _AddressSelectorState createState() => _AddressSelectorState();
}

class _AddressSelectorState extends State<AddressSelector> {
  String? selectedAddressId;
  bool showAllAddresses = false;
  

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetUserAdressesBloc>().add(FetchDataAdress( FirebaseAuth.instance.currentUser!.uid));
    });

    return BlocConsumer<GetUserAdressesBloc, GetUserAdressesState>(
      listener: (context, state) {
        if (state is GetUserAdressesFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMsg)),
          );
        }
      },
      builder: (context, state) {
        if (state is GetUserAdressesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetUserAdressesLoaded) {
          final addresses = state.data;
          final visibleAddresses = showAllAddresses ? addresses : addresses.take(1).toList();

          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...visibleAddresses.map((address) {
                    return ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      leading: selectedAddressId == address.id
                          ? const Icon(
                              Icons.location_on,
                              color: Colors.green,
                            )
                          : const Icon(Icons.location_on_outlined),
                      title: Text(address['AddressName'] ?? 'Unnamed Address',
                          style: TextStyle(fontWeight: selectedAddressId == address.id ? FontWeight.bold : FontWeight.normal)),
                      subtitle: Text(
                        '${address['AddressLine1']}, ${address['AddressCity']}, ${address['AddressState']}, ${address['AddressPostCode']}, ${address['AddressPhone']}',
                        style: TextStyle(fontWeight: selectedAddressId == address.id ? FontWeight.bold : FontWeight.normal),
                      ),
                      onTap: () {
                        final oneline =
                            '${address['AddressName']}\nAddress : ${address['AddressLine1']}, ${address['AddressCity']}, ${address['AddressState']}, ${address['AddressPostCode']}, ${address['AddressPhone']}';
                        context.read<OrderSummaryBlocBloc>().add(AddressChanges(oneline));
                        setState(() {
                          selectedAddressId = address.id;
                        });
                      },
                    );
                  }),
                  const Divider(
                    color: AppColors.greyColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(createRoute(AddAdressPage()));
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Add new address'),
                      ),
                      if (!showAllAddresses && addresses.length > 1)
                        TextButton(
                          onPressed: () {
                            setState(() {
                              showAllAddresses = true;
                            });
                          },
                          child: const Text('More'),
                        ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
        return const Text('No address found');
      },
    );
  }
}