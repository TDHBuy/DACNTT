import 'package:booking/views/bookings/widgets/desktop/booking_table.dart';
import 'package:booking/views/bookings/widgets/desktop/filters/status_filter_bar.dart';
import 'package:flutter/material.dart';

class BookingDesktopViews extends StatelessWidget {
  const BookingDesktopViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StatusFilterBar(),
        const SizedBox(height: 16),
        const Expanded(child: BookingTable()),
      ],
    );
  }
}
