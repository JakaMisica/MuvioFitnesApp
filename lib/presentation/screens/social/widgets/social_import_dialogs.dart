import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:gap/gap.dart';

class SocialImportSelectorDialog extends StatefulWidget {
  final String title;
  final Color themeColor;
  final List<DateTime> highlightedDays;
  final Function(DateTime selectedDate) onDateSelected;

  const SocialImportSelectorDialog({
    super.key,
    required this.title,
    required this.themeColor,
    required this.highlightedDays,
    required this.onDateSelected,
  });

  @override
  State<SocialImportSelectorDialog> createState() =>
      _SocialImportSelectorDialogState();
}

class _SocialImportSelectorDialogState
    extends State<SocialImportSelectorDialog> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1A1F23),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontFamily: 'Orbitron',
                letterSpacing: 1.5,
              ),
            ),
            const Gap(20),
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                widget.onDateSelected(selectedDay);
              },
              calendarStyle: CalendarStyle(
                defaultTextStyle: const TextStyle(color: Colors.white70),
                weekendTextStyle: const TextStyle(color: Colors.white38),
                selectedDecoration: BoxDecoration(
                  color: widget.themeColor,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: widget.themeColor.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  final hasData = widget.highlightedDays.any(
                    (d) => isSameDay(d, day),
                  );
                  if (hasData) {
                    return Container(
                      margin: const EdgeInsets.all(6),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return null;
                },
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: widget.themeColor,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: widget.themeColor,
                ),
              ),
            ),
            const Gap(20),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: widget.themeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialImportPreviewDialog extends StatelessWidget {
  final String title;
  final Color themeColor;
  final DateTime targetDate;
  final Widget content;
  final VoidCallback onImport;

  /// DELETE + OK mode (already-imported / view)
  final VoidCallback? onDelete;

  const SocialImportPreviewDialog({
    super.key,
    required this.title,
    required this.themeColor,
    required this.targetDate,
    required this.content,
    required this.onImport,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: themeColor.withOpacity(0.25), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: themeColor.withOpacity(0.12),
              blurRadius: 32,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: themeColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.download_rounded,
                      color: themeColor,
                      size: 18,
                    ),
                  ),
                  const Gap(12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: themeColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      const Gap(2),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.white38,
                            size: 11,
                          ),
                          const Gap(4),
                          Text(
                            DateFormat('EEEE, MMM d').format(targetDate),
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(16),

            // ── Divider ──
            Container(height: 1, color: themeColor.withOpacity(0.1)),

            // ── Scrollable Content ──
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.07)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: content,
                  ),
                ),
              ),
            ),

            // ── Actions ──
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: _buildActions(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    if (onDelete != null) {
      return Row(
        children: [
          Expanded(
            child: _DeleteButton(
              onPressed: () {
                Navigator.pop(context);
                onDelete!();
              },
            ),
          ),
          const Gap(10),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 8,
                shadowColor: themeColor.withOpacity(0.4),
              ),
              child: const Text(
                'OK',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Colors.white12),
              ),
            ),
            child: const Text(
              'CANCEL',
              style: TextStyle(
                color: Colors.white38,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
        const Gap(10),
        Expanded(
          flex: 2,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              onImport();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: themeColor,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 8,
              shadowColor: themeColor.withOpacity(0.4),
            ),
            icon: const Icon(Icons.check_circle_outline_rounded, size: 16),
            label: const Text(
              'IMPORT NOW',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 12,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Premium-styled DELETE button with a dark crimson gradient background.
class _DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _DeleteButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF5C1010), Color(0xFF8B1A1A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.redAccent.withOpacity(0.4)),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_sweep_rounded, color: Colors.redAccent, size: 17),
            Gap(6),
            Text(
              'DELETE',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w900,
                fontSize: 12,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
