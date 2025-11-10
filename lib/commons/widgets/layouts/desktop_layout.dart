import 'package:booking/views/bookings/widgets/desktop/dashboards/statistic_screen.dart';
import 'package:flutter/material.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key, required this.body, required this.title});
  final Widget body;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Row(
              children: [
                Icon(Icons.account_circle, size: 28, color: Colors.blueGrey),
                SizedBox(width: 8),
                Text(
                  'Duc Huy',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
      // Body Content
      body: body,
    );
  }
}
