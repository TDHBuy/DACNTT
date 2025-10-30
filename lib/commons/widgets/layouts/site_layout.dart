import 'package:booking/commons/widgets/layouts/desktop_layout.dart';
import 'package:booking/commons/widgets/layouts/mobile_layout.dart';
import 'package:booking/commons/widgets/layouts/tablet_layout.dart';
import 'package:booking/commons/widgets/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';

class TSiteTemplate extends StatelessWidget {
  const TSiteTemplate({super.key, required this.desktopBody,required this.title, Widget? tabletBody, Widget? mobileBody}):
    tabletBody = tabletBody ?? desktopBody,
    mobileBody = mobileBody ?? desktopBody;
  final Widget desktopBody;
  final Widget tabletBody;
  final Widget mobileBody;
  final String title;
  @override
  Widget build(BuildContext context) {
    return TResponsiveLayout(
        desktop: DesktopLayout(body: desktopBody,title: title),
        tablet: TabletLayout(body: tabletBody, title: title),
        mobile: MobileLayout(body: mobileBody, title: title),
    );
  }
}
