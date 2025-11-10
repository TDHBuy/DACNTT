import 'package:booking/views/bookings/widgets/mobile/filters/search_filters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../views/bookings/widgets/controllers/booking_table_controller.dart';

class MobileLayout extends GetView<BookingTableController> {
  const MobileLayout({super.key, required this.body, required this.title});
  final Widget body;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() {
            return controller.isSearching.value
                ? _buildFading(SearchFilters())
                : Text(title);
          }),
          actions: [
            Obx(() {
              return IconButton(
                onPressed: () {
                  controller.isSearching.toggle();
                },
                icon: Icon(
                  controller.isSearching.value ? Icons.close : Icons.search,
                ),
              );
            }),
            IconButton(
              onPressed: () async {
                await controller.showFilterSheet(context);
              },
              icon: Icon(Icons.filter_list),
            ),
          ],
        ),
        // Body Content
        body: body,
      ),
    );
  }

  Widget _buildFading(Widget child) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(begin: Offset(0.0, -0.1), end: Offset.zero)
                .animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                ),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
