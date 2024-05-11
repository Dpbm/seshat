import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

String buildPath(String icon) {
  return 'assets/icons/' + icon + '.svg';
}

Widget search() {
  return SvgPicture.asset(
    buildPath('search'),
    semanticsLabel: 'Search',
    width: 32,
    height: 32,
  );
}

Widget searchPrefix() {
  return SvgPicture.asset(
    buildPath('search_prefix'),
    semanticsLabel: 'Search',
    width: 12,
    height: 12,
  );
}

Widget plus() {
  return SvgPicture.asset(
    buildPath('plus'),
    semanticsLabel: 'Add',
    width: 32,
    height: 32,
  );
}

Widget back() {
  return SvgPicture.asset(
    buildPath('back'),
    semanticsLabel: 'Back',
    width: 32,
    height: 32,
  );
}

Widget trash() {
  return SvgPicture.asset(
    buildPath('trash'),
    semanticsLabel: 'Delete',
    width: 32,
    height: 32,
  );
}
