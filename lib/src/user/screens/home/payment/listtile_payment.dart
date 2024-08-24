import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:metrogeniusapp/utils/colors.dart';

class SelectableListTile extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String title;
  final IconData leadingIcon;

  const SelectableListTile({
    Key? key,
    required this.isSelected,
    required this.onTap,
    required this.title,
    required this.leadingIcon,
  }) : super(key: key);

  @override
  _SelectableListTileState createState() => _SelectableListTileState();
}

class _SelectableListTileState extends State<SelectableListTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Container(
          decoration: BoxDecoration(
            color: widget.isSelected
                ?  AppColors.mainBlueColor.withOpacity(.2)
                : _isHovered
                    ? Colors.grey.withOpacity(0.1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.isSelected ?  AppColors.mainBlueColor.withOpacity(.5) : Colors.grey,
              width: .5,
            ),
          ),
          child: ListTile(
            leading: Icon(widget.leadingIcon, color: widget.isSelected ?  AppColors.mainBlueColor.withOpacity(1): Colors.black),
            title: Text(
              widget.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: widget.isSelected ?  AppColors.mainBlueColor.withOpacity(1) : Colors.black,
              ),
            ),
            trailing: widget.isSelected
                ? Icon(Icons.check, color: AppColors.mainBlueColor.withOpacity(1))
                : null,
          ),
        ),
      ),
    );
  }
}
