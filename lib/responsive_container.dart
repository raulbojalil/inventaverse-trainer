import 'package:flutter/material.dart';

import 'constants.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveContainer({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMaxWidth;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < desktopMinWidth &&
      MediaQuery.of(context).size.width >= mobileMaxWidth;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopMinWidth;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    if (_size.width >= desktopMinWidth) {
      return desktop;
    } else if (_size.width >= mobileMaxWidth && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
