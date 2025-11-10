import 'package:booking/commons/extensions/spacing.dart';
import 'package:booking/views/bookings/widgets/mobile/filters/mobile_filters.dart';
import 'package:booking/views/bookings/widgets/mobile/filters/search_filters.dart';
import 'package:booking/views/bookings/widgets/mobile/statistic/mobile_statistic.dart';
import 'package:booking/views/bookings/widgets/mobile/table/mobile_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingMobileViews extends StatelessWidget {
  const BookingMobileViews({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: SizedBox(
        height: Get.height - kToolbarHeight - 24,
        child: Column(
          children: [
            MobileStatistic(),
            8.heightBox,
            Expanded(child: MobileTable()),
          ],
        ),
      ),
    );
  }
}
