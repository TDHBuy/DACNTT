import 'package:booking/commons/widgets/responsive/screen_breakpoints.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class TResponsiveUtils {
  static const double tablet = 756;
  static const double desktop = 1366;

  static double get screenWidth => Get.width;
  static bool get isMobile => TScreenBreakpoints.isMobile(screenWidth);
  static bool get isTablet => TScreenBreakpoints.isTablet(screenWidth);
  static bool get isDesktop => TScreenBreakpoints.isDesktop(screenWidth);

  // Config for each layout

}