import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      height: height,
      width: width,
    );
  }
}
