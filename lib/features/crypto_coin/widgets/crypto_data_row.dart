import 'package:flutter/material.dart';

class CryptoDataRow extends StatelessWidget { 
  const CryptoDataRow({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 180,
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: Theme.of(context).textTheme.labelMedium,
          )
        )
      ],
    );
  }
}