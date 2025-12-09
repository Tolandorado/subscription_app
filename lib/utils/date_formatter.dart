String dateFormatter(DateTime? endDate) {
  if (endDate == null) {
    return 'Дата окончания не указана';
  }

  final day = endDate.day.toString().padLeft(2, '0');
  final month = endDate.month.toString().padLeft(2, '0');
  final year = endDate.year;

  return '${day}.${month}.${year}';
}
