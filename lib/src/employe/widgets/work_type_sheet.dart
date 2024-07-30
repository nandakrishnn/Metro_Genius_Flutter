
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusapp/bloc/Admin/get_category/get_category_bloc.dart';

PersistentBottomSheetController RegisterBottomSheet(BuildContext context, TextEditingController workController) {
    return showBottomSheet(
                                  showDragHandle: true,
                                  enableDrag: true,
                                  context: context,
                                  builder: (context) {
                                    context
                                        .read<GetCategoryBloc>()
                                        .add(FetchDataCategory());

                                    return BlocBuilder<GetCategoryBloc,
                                            GetCategoryState>(
                                        builder: (context, state) {
                                      if (state is GetCategoryStateLoading) {
                                        return const Center(
                                          child: CupertinoActivityIndicator(),
                                        );
                                      }
                                      if (state is GetCategoryStateLoaded) {
                                        final data = state.data;
                                        return SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListView.builder(
                                                  itemCount: data.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        workController
                                                            .text = data[
                                                                index]
                                                            ['CatgeoryName'];
                                                        Navigator.pop(
                                                            context);
                                                      },
                                                      child: ListTile(
                                                        minVerticalPadding: 2,
                                                        autofocus: true,
                                                        hoverColor:
                                                            Colors.blue,
                                                        leading: CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(data[
                                                                      index][
                                                                  'CategoryImage']),
                                                          radius: 25,
                                                        ),
                                                        title: Text(data[
                                                                index]
                                                            ['CatgeoryName']),
                                                      ),
                                                    );
                                                  }),
                                            ));
                                      } else {
                                        return Container();
                                      }
                                    });
                                  });
  }
