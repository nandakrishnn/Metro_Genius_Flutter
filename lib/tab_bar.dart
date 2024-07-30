import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Function(int) onMenuItemSelected;
  const CustomAppBar({super.key, required this.onMenuItemSelected});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(40),
      boxShadow: [BoxShadow(
        offset: Offset(0, -2)
        ,blurRadius: 30,
        color: Colors.black.withOpacity(.16)
      )]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          MenuItems(title: 'Home', onTap: onMenuItemSelected, index: 0,),
             MenuItems(title: 'Category', onTap: onMenuItemSelected,index: 1,),
                MenuItems(title: 'Employees', onTap: onMenuItemSelected,index: 2,),
                   MenuItems(title: 'Home', onTap: onMenuItemSelected,index: 3,)

        ],
      ),
    );
  }
}

class MenuItems extends StatelessWidget {
  final int index;
  final String title;
  final Function(int) onTap;

  const MenuItems({super.key, required this.title,  required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: ()=>onTap(index),
      child: Text(''.toUpperCase(),style: TextStyle(
        color: Colors.black.withOpacity(.3),
        fontWeight: FontWeight.bold
      ),),
    
    );
  }
}