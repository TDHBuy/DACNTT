enum BookingsTimeslot {
  all('All time', 0, 24),
  morning('Morning (6h-11h)', 6, 11),
  lunch('Lunch (11h-14h)', 11, 14),
  afternoon('Afternoon (14h-17h)', 14, 17),
  dinner('Dinner (17h-22h)', 17, 22);

  final String label;
  final int startHour;
  final int endHour;
  const BookingsTimeslot(this.label, this.startHour, this.endHour);
}
