import 'package:booking/views/bookings/widgets/controllers/booking_table_controller.dart';
import 'package:get/get.dart';

class BookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BookingTableController>(BookingTableController());
  }
}
