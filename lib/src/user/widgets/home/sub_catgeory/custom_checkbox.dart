import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/colors.dart';

class CustomCheckboxListTile extends StatefulWidget {
  final String title;
  final bool initialValue;
  final ValueChanged<bool?> onChanged;
  final Color activeColor;
  final Color checkColor;
  final TextStyle titleStyle;
  final EdgeInsetsGeometry padding;
  final BoxDecoration decoration;

  const CustomCheckboxListTile({
    required this.title,
    required this.initialValue,
    required this.onChanged,
    this.activeColor = AppColors.mainBlueColor,
    this.checkColor = Colors.white,
    this.titleStyle = const TextStyle(fontSize: 16, color: Colors.black),
    this.padding = const EdgeInsets.symmetric(horizontal: 0),
    this.decoration = const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1)
      ],
    ),
    super.key, 
  });

  @override
  State<CustomCheckboxListTile> createState() => _CustomCheckboxListTileState();
}

class _CustomCheckboxListTileState extends State<CustomCheckboxListTile> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.initialValue;
  }

  void _handleCheckboxChanged(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
    widget.onChanged(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      decoration: widget.decoration,
      child: CheckboxListTile(
        title: Text(
          widget.title,
          style: widget.titleStyle,
        ),
        value: _isChecked,
        onChanged: _handleCheckboxChanged,
        activeColor: widget.activeColor,
        checkColor: widget.checkColor,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
