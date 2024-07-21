import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeListAdmin extends StatelessWidget {
  const EmployeeListAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(


      appBar: AppBar(title:Text('Employee List') 
      ,centerTitle: true,
      automaticallyImplyLeading: false,
      ),
    );
  }
}