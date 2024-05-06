import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget search() {
  return SvgPicture.asset(
    'assets/icons/search.svg',
    semanticsLabel: 'Search',
    width: 36,
    height: 36,
  );
}
