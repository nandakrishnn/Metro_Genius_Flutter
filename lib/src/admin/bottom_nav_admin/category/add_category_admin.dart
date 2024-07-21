import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCategoryAdmin extends StatelessWidget {
  const AddCategoryAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text('Add Catgeories'),
      ),
    );
  }
}