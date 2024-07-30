
  import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<dynamic> ShowDilogRegisterCustom(BuildContext context, String? proofimage,String text) {
    return showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                              child: SizedBox(
                                                  width:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          .9,
                                                  height:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          .4,
                                                  child: proofimage != null
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16),
                                                          child: DecoratedBox(
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: FileImage(File(
                                                                      proofimage,
                                                                    )),
                                                                    fit: BoxFit.cover)),
                                                          ),
                                                        )
                                                      :  Center(
                                                          child: Text(
                                                              text),
                                                        )));
                                        });
  }