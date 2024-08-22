import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/animations/route_animations.dart';
import 'package:metrogeniusapp/bloc/get_subcategory/get_sub_catgeory_data_bloc.dart';
import 'package:metrogeniusapp/services/admin/applications/admin_services.dart';
import 'package:metrogeniusapp/src/user/screens/home/sub_catgeories/details_subcatgeory.dart';
import 'package:metrogeniusapp/src/user/widgets/textfeild.dart';
import '../../../widgets/home/sub_catgeories.dart';

class SubCatgeoryDetails extends StatelessWidget {
  final data;
  const SubCatgeoryDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    String catgeoryName = data['CatgeoryName'];
    return BlocProvider(
      create: (context) => GetSubCatgeoryDataBloc(AdminServices())
        ..add(FetchSubCategoryData(data['Id'])),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(data['CatgeoryName']),
          ),
          body: BlocConsumer<GetSubCatgeoryDataBloc, GetSubCatgeoryDataState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetSubCatgeoryDataLoading) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
                if (state is GetSubCatgeoryDataLoaded) {
                  final data = state.data;
                  if (data.isEmpty) {
                    return const Center(
                      child: Text('No Subcatgeories for this category'),
                    );
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextFeild(
                          hinttext: 'Search',
                          obscure: false,
                          prefixIcon: Icon(Icons.search),
                          onChanged: (p0) {
                                 context.read<GetSubCatgeoryDataBloc>().add(SearchSucCategryData(p0));
                          },
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 410,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 0,
                                    mainAxisExtent: 270),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(createRoute(
                                        InsideSubCatgeory(
                                    data: data[index],
                                    categoryType: catgeoryName,
                                  )));
                                },
                                child: SubCatgeoryContainer(
                                  mainCatgeoryName: catgeoryName,
                                  categoryPrice: data[index]['CatPrice'],
                                  categoryDes: data[index]['CatDes'],
                                  categoryHeading: data[index]['CatName'],
                                  catgeoryImage: data[index]['CatImage'],
                                ),
                              );
                            }),
                      ),
                    ],
                  );
                }
                return Container();
              })),
    );
  }
}
