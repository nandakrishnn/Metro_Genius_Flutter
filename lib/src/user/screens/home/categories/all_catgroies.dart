import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/Admin/get_category/get_category_bloc.dart';
import 'package:metrogeniusapp/services/admin/applications/admin_services.dart';
import 'package:metrogeniusapp/src/user/screens/home/sub_catgeories/sub_category_view.dart';
import 'package:metrogeniusapp/src/user/widgets/home/categories_container.dart';
import 'package:metrogeniusapp/utils/colors.dart';

class AllCatgeories extends StatelessWidget {
  const AllCatgeories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
extendBodyBehindAppBar: true,
extendBody: true,
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Text('All Categories'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => GetCategoryBloc(AdminServices())..add(FetchDataCategory()),
        child: BlocConsumer<GetCategoryBloc, GetCategoryState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetCategoryStateLoading) {
                return Center(
                  child: CupertinoActivityIndicator(
                    animating: true,
                  ),
                );
              }
              if (state is GetCategoryStateLoaded) {
                final data = state.data;
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 130,
                      crossAxisSpacing: 9,
                      mainAxisSpacing: 0,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(createRoute(SubCatgeoryDetails(data: data[index],)));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: HomeCategories(
                              imgurl: data[index]['CategoryImage'],
                              scale: 0,
                              heading: data[index]['CatgeoryName']),
                        ),
                      );
                    });
              }
              return Container();
            }),
      ),
    );
  }
}
