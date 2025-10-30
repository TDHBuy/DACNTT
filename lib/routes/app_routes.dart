import 'package:booking/binding/booking_binding.dart';
import 'package:booking/main.dart';
import 'package:booking/routes/routes.dart';
import 'package:booking/screens/bookings_screen.dart';
import 'package:booking/views/bookings/widgets/desktop/booking_row_detail.dart';
import 'package:get/get.dart';

class TAppRoutes {
  static final List<GetPage> pages = [
    GetPage(name: TRoutes.homePage, page: () => const MyApp()),
    GetPage(
      name: TRoutes.bookingScreen,
      page: () => const BookingsScreen(),
      bindings: [BookingBinding()],
    ),
    GetPage(name: TRoutes.bookingDetail, page: () => const BookingRowDetail()),
  ];
}
