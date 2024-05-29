import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeatherIcon extends StatelessWidget {
  final String name;
  final String label;
  final double height;
  final double width;

  const FeatherIcon(
      {super.key,
      required this.name,
      required this.label,
      required this.height,
      required this.width});

  String buildPath() {
    return 'assets/icons/' + name + '.svg';
  }

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      buildPath(),
      semanticsLabel: label,
      width: width,
      height: height,
    );
  }
}

const SearchIcon =
    FeatherIcon(name: 'search', label: 'search', height: 32, width: 32);
const SearchPrefixIcon =
    FeatherIcon(name: 'search_prefix', label: 'Search', height: 32, width: 32);
const PlusIcon = FeatherIcon(name: 'plus', label: 'Add', height: 32, width: 32);
const BackIcon =
    FeatherIcon(name: 'back', label: 'Go Back', height: 32, width: 32);
const TrashIcon =
    FeatherIcon(name: 'trash', label: 'Delete', height: 32, width: 32);
const ShareIcon =
    FeatherIcon(name: 'share', label: 'Share Note', height: 32, width: 32);
const XIcon =
    FeatherIcon(name: 'x', label: 'Clear Search', height: 32, width: 32);
const FilterIcon =
    FeatherIcon(name: 'filter', label: 'Filter Search', height: 24, width: 24);
