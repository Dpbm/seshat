import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

String buildPath(String icon) {
  return 'assets/icons/' + icon + '.svg';
}

Widget search() {
  return SvgPicture.asset(
    buildPath('search'),
    semanticsLabel: 'Search',
    width: 36,
    height: 36,
  );
}

Widget plus() {
  return SvgPicture.asset(
    buildPath('plus'),
    semanticsLabel: 'Add',
    width: 36,
    height: 36,
  );
}

Widget back() {
  return SvgPicture.asset(
    buildPath('back'),
    semanticsLabel: 'Back',
    width: 36,
    height: 36,
  );
}
