import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/get_adress_user/get_user_adresses_bloc.dart';
import 'package:metrogeniusapp/services/user/user_services.dart';
import 'package:metrogeniusapp/src/user/screens/bottomnavigation/profile/adress_user/add_adress.dart';
import 'package:metrogeniusapp/utils/colors.dart';

class AdressUser extends StatelessWidget {
  
  const AdressUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetUserAdressesBloc(AddressServiceUser())
        ..add(FetchDataAdress(FirebaseAuth.instance.currentUser!.uid)),
      child: BlocConsumer<GetUserAdressesBloc, GetUserAdressesState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          if(state is GetUserAdressesLoading){
            return Center(child: CupertinoActivityIndicator(animating: true,),);
          }
          
          if (state is GetUserAdressesLoaded) {
            final data=state.data;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('Saved Address'),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(createRoute(AddAdressPage()));
                      },
                      icon: Icon(Icons.add))
                ],
              ),
              body: GestureDetector(
                onTap: () {},
                child: ListView.builder(
                  
                  itemCount: data.length,
                  itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [BoxShadow(
                          color: AppColors.greyColor,
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(2, 2),
                          
                        )]
                      ),
                    width: double.infinity,
                         
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        onTap: (){
                             Navigator.of(context).pop(data[index]);
                        },
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[index]['AddressName']),
                              Text(data[index]['AddressLine1']),
                                Text(data[index]['AddressState']),
                                  Text(data[index]['AddressPostCode'].toString()),
                                     Text(data[index]['AddressPhone'].toString()),
                            ],
                          ),
                        ),
                      ),
                    ),
                                      ),
                  );
                })
              ),
            );
          }return Container();
        }
      ),
    );
  }
}
