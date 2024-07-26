import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int? maxLines;

  const CustomText({
    super.key,
    required this.text,
    required this.style, this.maxLines,
    
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: TextAlign.left,
      softWrap: false,
      maxLines: maxLines ?? 1,
    );
  }
}