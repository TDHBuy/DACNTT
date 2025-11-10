import 'package:booking/views/bookings/widgets/desktop/booking_table.dart';
import 'package:booking/views/bookings/widgets/desktop/dashboards/statistic_screen.dart';
import 'package:booking/views/bookings/widgets/desktop/filters/horizontal_filter_bar.dart';
import 'package:flutter/material.dart';

class BookingDesktopViews extends StatelessWidget {
  const BookingDesktopViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StatisticScreen(),
        8.heightBox,
        const HorizontalFilterBar(),
        8.heightBox,
        const Expanded(child: BookingTable()),
      ],
    );
  }
}
