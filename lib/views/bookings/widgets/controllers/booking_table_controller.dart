import 'package:booking/data/mock_bookings.dart';
import 'package:get/get.dart';

import '../../../../models/bookings_model.dart';

class BookingTableController extends GetxController {
  final RxList<BookingModel> bookings = <BookingModel>[].obs;
  final RxBool isLoading = true.obs;
  final Rx<BookingModel?> selectedBooking = Rx<BookingModel?>(null);
  final RxBool dateAscending = true.obs;

  // --- Filter
  final Rx<BookingStatus?> selectedStatus = Rx<BookingStatus?>(null);
  final RxList<BookingModel> _allBookings = <BookingModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    loadBookings();
  }

  Map<BookingStatus?, int> countStatus() {
    final counts = <BookingStatus?, int>{null: _allBookings.length};
    for (var status in BookingStatus.values) {
      counts[status] = _allBookings.where((b) => b.status == status).length;
    }
    return counts;
  }

  Future<void> loadBookings() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      final data = MockBookings.getBookings();
      // Descending by date
      sortByDate(data);
      _allBookings.value = data;
      filtered(selectedStatus.value);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Can't load bookings",
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void filtered(BookingStatus? status) {
    selectedStatus.value = status;
    applyStatusFilter();
  }

  void applyStatusFilter() {
    if (selectedStatus.value == null) {
      bookings.value = List.from(_allBookings);
    } else {
      bookings.value = _allBookings
          .where((b) => b.status == selectedStatus.value)
          .toList();
    }
  }

  void resetFilter() {
    filtered(null);
  }

  void selectBooking(BookingModel booking) {
    selectedBooking.value = booking;
    Get.toNamed('/booking-detail', arguments: booking);
  }

  void sortByDate(List<BookingModel> data) {
    data.sort((a, b) {
      final dateTimeA = _combineDateAndTime(a.bookingDate, a.bookingTime);
      final dateTimeB = _combineDateAndTime(b.bookingDate, b.bookingTime);

      return dateTimeB.compareTo(dateTimeA);
    });
  }

  DateTime _combineDateAndTime(DateTime date, String time) {
    final parts = time.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);

    return DateTime(date.year, date.month, date.day, hours, minutes);
  }
}
