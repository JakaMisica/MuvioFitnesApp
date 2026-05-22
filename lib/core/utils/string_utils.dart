extension StringExtension on String {
  String get capitalize =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';

  String get formatEnum {
    // Splits camelCase into "Space Separated"
    final res = replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(1)}',
    );
    return res.trim().capitalize;
  }

  String get formatMetricKey {
    if (startsWith('task_')) return 'Task: ${substring(5).capitalize}';
    if (startsWith('supp_')) return 'Supp: ${substring(5).capitalize}';
    if (startsWith('measurement')) {
      final label = substring(11).formatEnum;
      if (label.toLowerCase() == 'waist') return 'All Measurements - Waist';
      return 'Measures: $label';
    }
    return formatEnum;
  }
}
