import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/Admin/get_category/get_category_bloc.dart';
import 'package:metrogeniusapp/services/admin/applications/admin_services.dart';
import 'package:metrogeniusapp/src/admin/bottom_nav_admin/category/catgeory_details.dart';
import 'package:metrogeniusapp/src/user/widgets/home/new_notable.dart';

class AddCategoryAdmin extends StatelessWidget {
  const AddCategoryAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetCategoryBloc(AdminServices())..add(FetchDataCategory()),
      child: Scaffold(
        appBar: AppBar(
          actions: [
        
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(createRoute(AddCatgeoryDetails()));
                },
                icon: Icon(Icons.add_box_outlined))
          ],
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text('Add Catgeories'),
        ),
        body: BlocConsumer<GetCategoryBloc, GetCategoryState>(
          listener: (context, state) {
        
          },
          builder: (context, state) {
            if(state is GetCategoryStateLoading){
              return CupertinoActivityIndicator();
            }
          if(state is GetCategoryStateLoaded){
            final data=state.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: data.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 150,
                      crossAxisSpacing: 9,
                      mainAxisSpacing: 11,
                      maxCrossAxisExtent: 140),
                  itemBuilder: (context, index) {
                    
                    return NewNotable(imageurl:data[index]['CategoryImage'], text: data[index]['CatgeoryName']);
                  }),
              );
          }else{
            return Center(child: Text('Something went wrong'),);
          }
          },
        ),
      ),
    );
  }
}
