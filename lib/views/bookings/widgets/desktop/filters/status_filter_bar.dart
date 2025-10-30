import 'package:booking/views/bookings/widgets/controllers/booking_table_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusFilterBar extends GetView<BookingTableController> {
  const StatusFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Filter bar"));
  }
}
