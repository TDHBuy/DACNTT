import 'package:booking/commons/widgets/responsive/screen_breakpoints.dart';
import 'package:flutter/material.dart';

class TResponsiveLayout extends StatelessWidget {
  const TResponsiveLayout({
    super.key,
    required this.desktop,
    Widget? tablet,
    Widget? mobile,
  })
      : tablet = tablet ?? desktop,
        mobile = mobile ?? desktop;
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        if (TScreenBreakpoints.isDesktop(width)) {
          return desktop;
        } else if (TScreenBreakpoints.isTablet(width)) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}