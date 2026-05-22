import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/diet_models.dart';
import '../../../../logic/cubit/diet/diet_cubit.dart';

class WeeklyScheduleDialog extends StatefulWidget {
  final DietTemplate template;
  const WeeklyScheduleDialog({super.key, required this.template});

  @override
  State<WeeklyScheduleDialog> createState() => _WeeklyScheduleDialogState();
}

class _WeeklyScheduleDialogState extends State<WeeklyScheduleDialog> {
  late Set<int> _selectedDays;
  Map<int, String> _dayOwners = {}; // day -> template name

  @override
  void initState() {
    super.initState();
    _selectedDays = Set.from(widget.template.scheduledDays);
    _loadDayOwners();
  }

  Future<void> _loadDayOwners() async {
    final templates = await context.read<DietCubit>().getTemplates();
    final owners = <int, String>{};

    for (var template in templates) {
      if (template.id == widget.template.id) continue;
      for (var day in template.scheduledDays) {
        owners[day] = template.name;
      }
    }

    setState(() {
      _dayOwners = owners;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF121212),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 650),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "AUTO-SCHEDULE",
              style: const TextStyle(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.w900,
                fontSize: 14,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.template.name.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            const Text(
              "Select days to auto-apply this diet:",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: SingleChildScrollView(
                child: Column(children: _buildDayToggles()),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("CANCEL"),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text(
                    "SAVE",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDayToggles() {
    const days = [
      (1, 'Monday'),
      (2, 'Tuesday'),
      (3, 'Wednesday'),
      (4, 'Thursday'),
      (5, 'Friday'),
      (6, 'Saturday'),
      (7, 'Sunday'),
    ];

    return days.map((day) {
      final dayNum = day.$1;
      final dayName = day.$2;
      final isSelected = _selectedDays.contains(dayNum);
      final ownedByOther = _dayOwners.containsKey(dayNum);
      final ownerName = _dayOwners[dayNum];

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: InkWell(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedDays.remove(dayNum);
              } else {
                _selectedDays.add(dayNum);
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.cyanAccent.withOpacity(0.2)
                  : ownedByOther
                  ? Colors.orange.withOpacity(0.1)
                  : Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? Colors.cyanAccent
                    : ownedByOther
                    ? Colors.orange.withOpacity(0.3)
                    : Colors.white.withOpacity(0.1),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.check_circle
                      : ownedByOther
                      ? Icons.lock_outline
                      : Icons.circle_outlined,
                  color: isSelected
                      ? Colors.cyanAccent
                      : ownedByOther
                      ? Colors.orange
                      : Colors.white38,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dayName,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.cyanAccent
                              : ownedByOther
                              ? Colors.orange
                              : Colors.white,
                          fontWeight: isSelected || ownedByOther
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      if (ownedByOther && !isSelected)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            "Taken by: $ownerName",
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  Future<void> _save() async {
    await context.read<DietCubit>().updateTemplateSchedule(
      widget.template.id,
      _selectedDays.toList(),
    );
    if (mounted) Navigator.pop(context);
  }
}
