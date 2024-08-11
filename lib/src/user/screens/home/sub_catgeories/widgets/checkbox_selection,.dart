import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SingleSelectionCheckbox extends StatelessWidget {
  final Map<String, bool> checkBoxData;
  final ValueNotifier<String?> selectedCheckboxNotifier;

  const SingleSelectionCheckbox({
    Key? key,
    required this.checkBoxData,
    required this.selectedCheckboxNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: checkBoxData.entries.map((entry) {
        return ValueListenableBuilder<String?>(
          valueListenable: selectedCheckboxNotifier,
          builder: (context, selectedValue, child) {
            return CheckboxListTile(
              title: Text(entry.key),
              value: selectedValue == entry.key,
              onChanged: (bool? value) {
                if (value == true) {
                  selectedCheckboxNotifier.value = entry.key;
                }
              },
            );
          },
        );
      }).toList(),
    );
  }
}
