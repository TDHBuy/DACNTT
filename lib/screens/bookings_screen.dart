import 'package:booking/commons/widgets/layouts/site_layout.dart';
import 'package:booking/commons/widgets/responsive/responsive_layout.dart';
import 'package:booking/views/bookings/booking_desktop_views.dart';
import 'package:booking/views/bookings/booking_mobile_views.dart';
import 'package:booking/views/bookings/booking_tablet_views.dart';
import 'package:booking/views/bookings/widgets/controllers/booking_table_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingsScreen extends GetView<BookingTableController> {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      title: "Bookings",
      desktopBody: BookingDesktopViews(),
      tabletBody: BookingTabletViews(),
      mobileBody: BookingMobileViews(),
    );
  }
}
