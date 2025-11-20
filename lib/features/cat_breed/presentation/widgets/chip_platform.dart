import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChipPlatform extends StatelessWidget {
  const ChipPlatform({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.iOS
        ? CupertinoButton.filled(
            padding: EdgeInsets.symmetric(horizontal: 12),
            onPressed: () {},
            child: Text(text),
          )
        : Chip(label: Text(text));
  }
}
