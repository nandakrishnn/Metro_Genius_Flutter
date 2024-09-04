
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsPaymentSummary extends StatelessWidget {
  String? item;
  dynamic price;
  DetailsPaymentSummary({
    this.item,
    this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextSummaryPage(
          heading: item,
        ),
        Text(price.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16, // Adjust text size
              color: Colors.black87,
            ))
      ],
    );
  }
}

class TextSummaryPage extends StatelessWidget {
  String? heading;
  TextSummaryPage({
    this.heading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(heading!,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16, // Adjust text size
          color: Colors.black87,
        ));
  }
}
