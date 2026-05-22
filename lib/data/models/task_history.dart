import 'package:isar/isar.dart';

part 'task_history.g.dart';

@collection
class TaskHistory {
  Id id = Isar.autoIncrement;

  @Index()
  late int taskId; // Link to TaskItem

  @Index()
  late DateTime recordedDate;

  // Metric type: 'counter', 'distance', 'dose', 'weight', 'energy', 'rating', 'percentage', 'financial'
  late String metricType;

  // Generic value storage
  late double
  numericValue; // For counter, distance, weight, energy, rating, percentage, financial
  late String textValue; // For dose, notes, currency

  // Optional notes
  late String notes;

  TaskHistory({
    this.taskId = 0,
    this.metricType = '',
    this.numericValue = 0.0,
    this.textValue = '',
    this.notes = '',
  }) : recordedDate = DateTime.now();

  // Helper to get formatted value based on metric type
  String getFormattedValue() {
    switch (metricType) {
      case 'counter':
        return numericValue.toInt().toString();
      case 'distance':
        return '${numericValue.toStringAsFixed(1)} km';
      case 'weight':
        return '${numericValue.toStringAsFixed(1)} kg';
      case 'energy':
        return '${numericValue.toInt()} cal';
      case 'rating':
        return '${numericValue.toInt()}/10';
      case 'percentage':
        return '${numericValue.toStringAsFixed(1)}%';
      case 'financial':
        return '$textValue ${numericValue.toStringAsFixed(2)}';
      case 'dose':
        return textValue;
      default:
        return numericValue.toString();
    }
  }
}
