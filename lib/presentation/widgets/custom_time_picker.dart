import 'package:flutter/material.dart';

class CustomTimePickerDialog extends StatefulWidget {
  final TimeOfDay initialTime;
  final String title;

  final bool showSmartAlarmToggle;
  final bool isSmartAlarmEnabled;
  final ValueChanged<bool>? onSmartAlarmToggle;

  const CustomTimePickerDialog({
    super.key,
    required this.initialTime,
    this.title = "SET ALARM",
    this.showSmartAlarmToggle = false,
    this.isSmartAlarmEnabled = false,
    this.onSmartAlarmToggle,
  });

  @override
  State<CustomTimePickerDialog> createState() => _CustomTimePickerDialogState();
}

class _CustomTimePickerDialogState extends State<CustomTimePickerDialog> {
  late TextEditingController _hourController;
  late TextEditingController _minController;
  late bool _isPm;
  late bool _isSmartAlarmEnabled;

  @override
  void initState() {
    super.initState();
    int h = widget.initialTime.hour;
    _isPm = h >= 12;
    int displayH = h % 12;
    if (displayH == 0) displayH = 12;
    _hourController = TextEditingController(text: displayH.toString());
    _minController = TextEditingController(
      text: widget.initialTime.minute.toString().padLeft(2, '0'),
    );
    _isSmartAlarmEnabled = widget.isSmartAlarmEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF121212),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: BorderSide(color: Colors.cyanAccent.withOpacity(0.1)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        width: 260,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.cyanAccent,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildInputBox(_hourController, true),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    ":",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                _buildInputBox(_minController, false),
                const SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildAmPmBtn("AM"),
                    const SizedBox(height: 6),
                    _buildAmPmBtn("PM"),
                  ],
                ),
              ],
            ),
            if (widget.showSmartAlarmToggle) ...[
              const Divider(color: Colors.white10),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  "SMART ALARM",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  _isSmartAlarmEnabled
                      ? "Wakes you during light sleep"
                      : "Wakes you at fixed time",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 9,
                  ),
                ),
                value: _isSmartAlarmEnabled,
                onChanged: (val) {
                  setState(() => _isSmartAlarmEnabled = val);
                  widget.onSmartAlarmToggle?.call(val);
                },
                activeColor: Colors.cyanAccent,
              ),
            ],
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "CANCEL",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                ElevatedButton(
                  onPressed: () {
                    int h = int.tryParse(_hourController.text) ?? 12;
                    int m = int.tryParse(_minController.text) ?? 0;
                    h %= 12;
                    if (_isPm) h += 12;
                    Navigator.pop(context, TimeOfDay(hour: h, minute: m));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: const Text(
                    "SAVE",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBox(TextEditingController controller, bool isHour) {
    return Container(
      width: 55,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w900,
          letterSpacing: -1,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        maxLength: 2,
        buildCounter:
            (
              context, {
              required currentLength,
              required isFocused,
              required maxLength,
            }) => null,
        onChanged: (v) {
          if (v.length == 2 && isHour) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  Widget _buildAmPmBtn(String label) {
    final bool active = (label == "PM") == _isPm;
    return GestureDetector(
      onTap: () => setState(() => _isPm = (label == "PM")),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: active ? Colors.cyanAccent : Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: active ? Colors.cyanAccent : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.black : Colors.white.withOpacity(0.4),
            fontSize: 10,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minController.dispose();
    super.dispose();
  }
}
