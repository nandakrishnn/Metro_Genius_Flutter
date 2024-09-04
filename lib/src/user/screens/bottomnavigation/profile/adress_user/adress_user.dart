import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/get_adress_user/get_user_adresses_bloc.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/profile/adress_user/add_adress.dart';
class AdressUser extends StatelessWidget {
  const AdressUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetUserAdressesBloc(AddressServiceUser())
        ..add(FetchDataAdress(FirebaseAuth.instance.currentUser!.uid)),
      child: BlocConsumer<GetUserAdressesBloc, GetUserAdressesState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetUserAdressesLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          if (state is GetUserAdressesLoaded) {
            final data = state.data;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text('Saved Address'),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(createRoute(AddAdressPage()));
                    },
                    icon: const Icon(Icons.add),
                  )
                ],
              ),
              body: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 12.0),
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(data[index]);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[index]['AddressName'],
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(data[index]['AddressLine1']),
                            Text(data[index]['AddressState']),
                            Text(data[index]['AddressPostCode'].toString()),
                            Text(data[index]['AddressPhone'].toString()),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
