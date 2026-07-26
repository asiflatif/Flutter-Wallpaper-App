import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
  });

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tabletLayout = tablet;
    if (size.width >= 850 && tabletLayout != null) {
      return tabletLayout;
    }
    return mobile;
  }
}
