import 'package:booking/models/bookings_model.dart';
import 'package:booking/views/bookings/widgets/controllers/booking_table_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../../../../../commons/widgets/responsive/screen_breakpoints.dart';

class MobileStatistic extends GetView<BookingTableController> {
  const MobileStatistic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: _buildStatistic(),
    );
  }

  Widget _buildStatistic() {
    final statuses = BookingStatus.values;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: TScreenBreakpoints.tablet / 180,
      ),
      itemCount: statuses.length,
      itemBuilder: (context, index) {
        final status = statuses[index];
        return Obx(
          () => _buildStatusCard(
            status: status,
            count: controller.statusCounts[status] ?? 0,
          ),
        );
      },
    );
  }

  Widget _buildStatusCard({required BookingStatus status, required int count}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: status.color.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: status.color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(status.icon, color: status.color, size: 13),
          // const SizedBox(width: 6),
          // Expanded(
          //   child: Text(
          //     status.displayName,
          //     style: TextStyle(
          //       fontSize: 13,
          //       fontWeight: FontWeight.w600,
          //       color: status.color,
          //     ),
          //   ),
          // ),
          Text(
            count.toString(),
            style: TextStyle(fontSize: 13, color: status.color),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
