import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/task_item.dart';
import '../../../../logic/cubit/tasks/task_cubit.dart';
import 'package:audioplayers/audioplayers.dart';

class TaskFormDialog extends StatefulWidget {
  final TaskItem? task;
  final bool isNote;

  const TaskFormDialog({super.key, this.task, this.isNote = false});

  @override
  State<TaskFormDialog> createState() => _TaskFormDialogState();
}

class _TaskFormDialogState extends State<TaskFormDialog> {
  bool _isNote = false;
  final _nameController = TextEditingController();
  final _counterMaxController = TextEditingController();
  final _notesController = TextEditingController();
  List<String> _imagePaths = [];
  double _sentiment = 0.0;
  bool _hasCounter = false;
  bool _hasDistance = false;
  bool _hasDose = false;
  bool _hasTime = false;
  bool _hasWeight = false;
  bool _hasEnergy = false;
  bool _hasRating = false;
  bool _hasPercentage = false;
  bool _hasFinancial = false;

  int _timerType = 0; // 0 = None, 1 = Countdown, 2 = Stopwatch, 3 = Alarm
  int _targetMinutes = 25;
  String? _alarmTimeString;
  String? _alarmSoundPath;
  int _recurrenceType = 0;
  Set<int> _selectedDays = {};
  String _currency = 'USD';
  bool _isDoubleTimer = false;
  int _breakMinutes = 5;

  // Hourly Chime / RAS Alarms
  bool _isHourlyChimeEnabled = false;
  int _chimeIntervalMinutes = 60;
  int _chimeStartHour = 8;
  int _chimeEndHour = 22;

  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'JPY', 'CNY', 'BTC'];
  List<String> _builtInSounds = [];
  final _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadAlarms();
    _isNote = widget.isNote || (widget.task?.isNote ?? false);
    if (widget.task != null) {
      final t = widget.task!;
      _nameController.text = t.name;
      _sentiment = t.sentiment;
      _hasCounter = t.hasCounterMetric;
      _hasDistance = t.hasDistanceMetric;
      _hasDose = t.hasDoseMetric;
      _hasTime = t.hasTimeMetric;
      _hasWeight = t.hasWeightMetric;
      _hasEnergy = t.hasEnergyMetric;
      _hasRating = t.hasRatingMetric;
      _hasPercentage = t.hasPercentageMetric;
      _hasFinancial = t.hasFinancialMetric;
      _timerType = t.timerType;
      _targetMinutes = t.targetSeconds ~/ 60;
      _alarmTimeString = t.alarmTime;
      _alarmSoundPath = t.alarmSoundPath;
      _recurrenceType = t.recurrenceType;
      _currency = t.currency;
      if (t.specificDays.isNotEmpty) {
        _selectedDays = t.specificDays.split(',').map(int.parse).toSet();
      }
      _counterMaxController.text = t.counterMax > 0
          ? t.counterMax.toString()
          : '';
      _notesController.text = t.notes;
      _imagePaths = List.from(t.imagePaths);
      _isHourlyChimeEnabled = t.isHourlyChimeEnabled;
      _chimeIntervalMinutes = t.chimeIntervalMinutes;
      _chimeStartHour = t.chimeStartHour;
      _chimeEndHour = t.chimeEndHour;
      _isDoubleTimer = t.isDoubleTimer;
      _breakMinutes = t.breakTargetSeconds ~/ 60;
    } else {
      // Default alarm time if needed
      _alarmTimeString = "08:00";
    }
  }

  Future<void> _loadAlarms() async {
    try {
      final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
      final assets = manifest.listAssets();

      final List<String> alarms = assets.where((String key) {
        final nk = key.toLowerCase();
        final isAlarm =
            nk.contains('alarms/') &&
            (nk.endsWith('.mp3') || nk.endsWith('.wav') || nk.endsWith('.ogg'));

        if (!isAlarm) return false;

        // Filter to only 1-5
        final filename = nk.split('/').last.toLowerCase();
        return filename.contains('alarm-1') ||
            filename.contains('alarm-2') ||
            filename.contains('alarm-3') ||
            filename.contains('alarm-4') ||
            filename.contains('alarm-5');
      }).toList();

      if (mounted) {
        setState(() {
          _builtInSounds = alarms;
        });
      }
    } catch (e) {
      print("Error loading built-in alarms with AssetManifest: $e");
      // Fallback to old method just in case
      try {
        final manifestJson = await rootBundle.loadString('AssetManifest.json');
        final Map<String, dynamic> manifestMap = json.decode(manifestJson);
        final List<String> alarms = manifestMap.keys.where((String key) {
          final nk = key.toLowerCase();
          final isAlarm =
              nk.contains('alarms/') &&
              (nk.endsWith('.mp3') ||
                  nk.endsWith('.wav') ||
                  nk.endsWith('.ogg'));

          if (!isAlarm) return false;

          // Filter to only 1-5
          final filename = nk.split('/').last.toLowerCase();
          return filename.contains('alarm-1') ||
              filename.contains('alarm-2') ||
              filename.contains('alarm-3') ||
              filename.contains('alarm-4') ||
              filename.contains('alarm-5');
        }).toList();
        if (mounted) setState(() => _builtInSounds = alarms);
      } catch (e) {
        debugPrint("Fallback manifest loading failed: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.grey.shade900,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              if (_isNote) ...[
                _buildNoteEditor(),
              ] else ...[
                _buildNameField(),
                const SizedBox(height: 24),
                _buildSentimentSlider(),
                const SizedBox(height: 24),
                _buildMetricsSection(),
                if (_hasFinancial) ...[
                  const SizedBox(height: 16),
                  _buildCurrencySelector(),
                ],
                if (_hasCounter) ...[
                  const SizedBox(height: 16),
                  _buildCounterMaxField(),
                ],
                const SizedBox(height: 24),
                _buildRecurrenceSection(),
                const SizedBox(height: 24),
                _buildNotesField(),
                const SizedBox(height: 24),
                _buildPhotoSection(),
                const SizedBox(height: 24),
                _buildTimerSection(),
                const SizedBox(height: 24),
                _buildHourlyChimeSection(),
              ],
              const SizedBox(height: 32),
              _buildActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoteEditor() {
    return TextField(
      controller: _nameController,
      maxLines: 25,
      minLines: 20,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        hintText: 'Write your note here...',
        hintStyle: TextStyle(color: Colors.grey.shade700),
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.blueAccent.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Icon(
          widget.task == null ? Icons.add_task : Icons.edit,
          color: Colors.cyanAccent,
          size: 28,
        ),
        const SizedBox(width: 12),
        Text(
          widget.task == null ? 'New Task' : 'Edit Task',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return TextField(
      controller: _nameController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Task Name',
        labelStyle: TextStyle(color: Colors.grey.shade500),
        hintText: 'e.g., Study Session, Morning Run',
        hintStyle: TextStyle(color: Colors.grey.shade700),
        filled: true,
        fillColor: Colors.black.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.cyanAccent),
        ),
      ),
    );
  }

  Widget _buildSentimentSlider() {
    Color sentimentColor;
    String label;

    if (_sentiment < -0.3) {
      sentimentColor = Color.lerp(
        Colors.red,
        Colors.orange,
        (_sentiment + 1.0) / 0.7,
      )!;
      label = 'Addiction';
    } else if (_sentiment > 0.3) {
      sentimentColor = Color.lerp(
        Colors.grey,
        Colors.green,
        (_sentiment - 0.3) / 0.7,
      )!;
      label = 'Good Habit';
    } else {
      sentimentColor = Colors.grey.shade700;
      label = 'Neutral';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Task Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: sentimentColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: sentimentColor),
              ),
              child: Text(
                label,
                style: TextStyle(
                  color: sentimentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: sentimentColor,
            thumbColor: sentimentColor,
            overlayColor: sentimentColor.withOpacity(0.3),
            inactiveTrackColor: Colors.grey.shade800,
          ),
          child: Slider(
            value: _sentiment,
            min: -1.0,
            max: 1.0,
            onChanged: (value) => setState(() => _sentiment = value),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSliderLabel('Addiction', Colors.red.shade400),
            _buildSliderLabel('Good', Colors.green.shade400),
          ],
        ),
      ],
    );
  }

  Widget _buildSliderLabel(String text, Color color) {
    return Text(text, style: TextStyle(color: color, fontSize: 12));
  }

  Widget _buildMetricsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Metrics',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 3.5,
          children: [
            _buildMetricBox(
              'Counter',
              Icons.add_circle_outline,
              _hasCounter,
              (v) => setState(() => _hasCounter = v),
            ),
            _buildMetricBox(
              'Distance',
              Icons.directions_run,
              _hasDistance,
              (v) => setState(() => _hasDistance = v),
            ),
            _buildMetricBox(
              'Dose',
              Icons.medication,
              _hasDose,
              (v) => setState(() => _hasDose = v),
            ),
            _buildMetricBox(
              'Weight',
              Icons.scale,
              _hasWeight,
              (v) => setState(() => _hasWeight = v),
            ),
            _buildMetricBox(
              'Energy (cal)',
              Icons.local_fire_department,
              _hasEnergy,
              (v) => setState(() => _hasEnergy = v),
            ),
            _buildMetricBox(
              'Rating (1-10)',
              Icons.star_outline,
              _hasRating,
              (v) => setState(() => _hasRating = v),
            ),
            _buildMetricBox(
              'Percentage',
              Icons.percent,
              _hasPercentage,
              (v) => setState(() => _hasPercentage = v),
            ),
            _buildMetricBox(
              'Financial',
              Icons.attach_money,
              _hasFinancial,
              (v) => setState(() => _hasFinancial = v),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricBox(
    String label,
    IconData icon,
    bool selected,
    Function(bool) onChanged,
  ) {
    return InkWell(
      onTap: () => onChanged(!selected),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: selected
              ? Colors.cyanAccent.withOpacity(0.12)
              : Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? Colors.cyanAccent : Colors.grey.shade800,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 14,
              color: selected ? Colors.cyanAccent : Colors.grey.shade500,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.cyanAccent : Colors.grey.shade400,
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Currency',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            value: _currency,
            isExpanded: true,
            underline: const SizedBox(),
            dropdownColor: Colors.grey.shade900,
            style: const TextStyle(color: Colors.white),
            items: _currencies
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (v) => setState(() => _currency = v ?? 'USD'),
          ),
        ),
      ],
    );
  }

  Widget _buildRecurrenceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recurrence',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<int>(
          value: _recurrenceType,
          dropdownColor: Colors.grey.shade900,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          items: const [
            DropdownMenuItem(value: 0, child: Text('None')),
            DropdownMenuItem(value: 1, child: Text('Daily')),
            DropdownMenuItem(value: 2, child: Text('Weekly')),
            DropdownMenuItem(value: 3, child: Text('Specific Days')),
            DropdownMenuItem(value: 4, child: Text('Monthly')),
          ],
          onChanged: (v) => setState(() => _recurrenceType = v ?? 0),
          style: const TextStyle(color: Colors.white),
        ),
        if (_recurrenceType == 3) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              _buildDayChip('Mon', 1),
              _buildDayChip('Tue', 2),
              _buildDayChip('Wed', 3),
              _buildDayChip('Thu', 4),
              _buildDayChip('Fri', 5),
              _buildDayChip('Sat', 6),
              _buildDayChip('Sun', 7),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildDayChip(String label, int day) {
    final isSelected = _selectedDays.contains(day);
    return InkWell(
      onTap: () => setState(
        () => isSelected ? _selectedDays.remove(day) : _selectedDays.add(day),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.cyanAccent.withOpacity(0.2)
              : Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.cyanAccent : Colors.grey.shade700,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.cyanAccent : Colors.grey,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildTimerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Timer',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: MediaQuery.of(context).size.width < 400 ? 2 : 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: MediaQuery.of(context).size.width < 400 ? 1.8 : 1.1,
          children: [
            _buildTimerBtn('None', Icons.block, 0),
            _buildTimerBtn('Countdown', Icons.timer, 1),
            _buildTimerBtn('Stopwatch', Icons.timer_outlined, 2),
            _buildTimerBtn('Alarm', Icons.alarm, 3),
            _buildTimerBtn(
              'Study (Work/Break)',
              Icons.school,
              1,
              isDouble: true,
            ),
          ],
        ),
        if (_timerType == 1) ...[
          const SizedBox(height: 16),
          _isDoubleTimer
              ? Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Work (min)',
                          labelStyle: TextStyle(color: Colors.grey.shade500),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (v) =>
                            _targetMinutes = int.tryParse(v) ?? 25,
                        controller: TextEditingController(
                          text: _targetMinutes.toString(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Break (min)',
                          labelStyle: TextStyle(color: Colors.grey.shade500),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.3),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (v) => _breakMinutes = int.tryParse(v) ?? 5,
                        controller: TextEditingController(
                          text: _breakMinutes.toString(),
                        ),
                      ),
                    ),
                  ],
                )
              : TextField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Duration (minutes)',
                    labelStyle: TextStyle(color: Colors.grey.shade500),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (v) => _targetMinutes = int.tryParse(v) ?? 25,
                  controller: TextEditingController(
                    text: _targetMinutes.toString(),
                  ),
                ),
        ],
        if (_timerType == 3) ...[
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text(
              'Alarm Time',
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              _alarmTimeString ?? 'Not set',
              style: const TextStyle(color: Colors.cyanAccent),
            ),
            trailing: const Icon(Icons.access_time, color: Colors.cyanAccent),
            onTap: _pickTime,
          ),
        ],
        if (_timerType != 0) ...[
          const SizedBox(height: 12),
          _buildSoundPicker(),
        ],
      ],
    );
  }

  Widget _buildSoundPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Alarm Sound',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 12),
        if (_builtInSounds.isNotEmpty) ...[
          const Text(
            'Default Alarms',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    _alarmSoundPath != null &&
                        _alarmSoundPath!.startsWith('assets/')
                    ? Colors.cyanAccent
                    : Colors.white10,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _builtInSounds.contains(_alarmSoundPath)
                    ? _alarmSoundPath
                    : null,
                hint: const Text(
                  'Select a built-in alarm...',
                  style: TextStyle(color: Colors.white38, fontSize: 14),
                ),
                isExpanded: true,
                dropdownColor: const Color(0xFF2A2A2A),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.cyanAccent,
                ),
                items: (() {
                  final sortedList = List<String>.from(_builtInSounds)
                    ..sort((a, b) {
                      final aNum =
                          int.tryParse(
                            RegExp(
                                  r'alarm-(\d+)',
                                ).firstMatch(a.toLowerCase())?.group(1) ??
                                '0',
                          ) ??
                          0;
                      final bNum =
                          int.tryParse(
                            RegExp(
                                  r'alarm-(\d+)',
                                ).firstMatch(b.toLowerCase())?.group(1) ??
                                '0',
                          ) ??
                          0;
                      return aNum.compareTo(bNum);
                    });
                  return sortedList.asMap().entries.map((entry) {
                    final path = entry.value;
                    return DropdownMenuItem(
                      value: path,
                      child: Text(
                        'Ringtone ${entry.key + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList();
                })(),
                onChanged: (val) async {
                  setState(() => _alarmSoundPath = val);
                  if (val != null) {
                    debugPrint("TaskFormDialog: Previewing alarm: $val");
                    try {
                      await _audioPlayer.stop();
                      if (val.startsWith('assets/')) {
                        final relativePath = val.replaceFirst('assets/', '');
                        await _audioPlayer.play(AssetSource(relativePath));
                      } else {
                        await _audioPlayer.play(DeviceFileSource(val));
                      }

                      // Auto stop after 5s
                      Future.delayed(const Duration(seconds: 5), () {
                        if (mounted) _audioPlayer.stop();
                      });
                    } catch (e) {
                      debugPrint("TaskFormDialog: Preview error: $e");
                    }
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
        const Text(
          'Or use custom file',
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _pickAlarmSound,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    _alarmSoundPath != null &&
                        !_alarmSoundPath!.startsWith('assets/')
                    ? Colors.cyanAccent
                    : Colors.white10,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.music_note,
                  size: 20,
                  color:
                      _alarmSoundPath != null &&
                          !_alarmSoundPath!.startsWith('assets/')
                      ? Colors.cyanAccent
                      : Colors.grey,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _alarmSoundPath != null &&
                            !_alarmSoundPath!.startsWith('assets/')
                        ? _alarmSoundPath!.split(RegExp(r'[/\\]')).last
                        : 'Pick from device',
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          _alarmSoundPath != null &&
                              !_alarmSoundPath!.startsWith('assets/')
                          ? Colors.cyanAccent
                          : Colors.white60,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                if (_alarmSoundPath != null)
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.redAccent,
                    ),
                    onPressed: () => setState(() => _alarmSoundPath = null),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickTime() async {
    final initial = TimeOfDay(
      hour: int.parse((_alarmTimeString ?? "08:00").split(":")[0]),
      minute: int.parse((_alarmTimeString ?? "08:00").split(":")[1]),
    );

    final selected = await showDialog<TimeOfDay>(
      context: context,
      builder: (context) => _CustomTimePickerDialog(initialTime: initial),
    );

    if (selected != null) {
      setState(() {
        _alarmTimeString =
            "${selected.hour.toString().padLeft(2, '0')}:${selected.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _pickAlarmSound() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'ogg'],
    );
    if (result != null && result.files.single.path != null) {
      final path = result.files.single.path!;
      setState(() {
        _alarmSoundPath = path;
      });
      try {
        await _audioPlayer.stop();
        await _audioPlayer.play(DeviceFileSource(path));
      } catch (e) {
        debugPrint("Error playing custom preview: $e");
      }
    }
  }

  Widget _buildTimerBtn(
    String label,
    IconData icon,
    int val, {
    bool isDouble = false,
  }) {
    final isSelected = _timerType == val && _isDoubleTimer == isDouble;
    return InkWell(
      onTap: () => setState(() {
        _timerType = val;
        _isDoubleTimer = isDouble;
      }),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.cyanAccent.withOpacity(0.12)
              : Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.cyanAccent : Colors.grey.shade800,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.cyanAccent : Colors.grey,
              size: 20,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.cyanAccent : Colors.grey,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterMaxField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Counter Maximum (Optional)',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _counterMaxController,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'e.g., 8 (for 8 glasses of water)',
            hintStyle: TextStyle(color: Colors.grey.shade700),
            filled: true,
            fillColor: Colors.black.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Photos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            TextButton.icon(
              onPressed: _pickImages,
              icon: const Icon(Icons.add_a_photo, size: 18),
              label: const Text('Add Photo'),
              style: TextButton.styleFrom(foregroundColor: Colors.cyanAccent),
            ),
          ],
        ),
        if (_imagePaths.isNotEmpty) ...[
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _imagePaths.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(_imagePaths[index]),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: InkWell(
                        onTap: () =>
                            setState(() => _imagePaths.removeAt(index)),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ],
    );
  }

  Future<void> _pickImages() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null && result.paths.isNotEmpty) {
      setState(() {
        _imagePaths.addAll(result.paths.whereType<String>());
      });
    }
  }

  Widget _buildNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notes',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _notesController,
          maxLines: 3,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Add some details...',
            hintStyle: TextStyle(color: Colors.grey.shade700),
            filled: true,
            fillColor: Colors.black.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHourlyChimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.notifications_active_outlined,
                          color: _isHourlyChimeEnabled
                              ? Colors.cyanAccent
                              : Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        const Flexible(
                          child: Text(
                            'Hourly Chime / RAS Alarms',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: _isHourlyChimeEnabled,
                    onChanged: (v) => setState(() => _isHourlyChimeEnabled = v),
                    activeColor: Colors.cyanAccent,
                  ),
                ],
              ),
              if (_isHourlyChimeEnabled) ...[
                const SizedBox(height: 12),
                Text(
                  'Reminds you periodically to check your posture and breathing.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 11,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'INTERVAL',
                            style: TextStyle(
                              color: Colors.cyanAccent.withOpacity(0.6),
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 48,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: _chimeIntervalMinutes,
                                isExpanded: true,
                                dropdownColor: Colors.grey.shade900,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 18,
                                  color: Colors.cyanAccent,
                                ),
                                items: [15, 30, 60, 120]
                                    .map(
                                      (i) => DropdownMenuItem(
                                        value: i,
                                        child: Text('$i min'),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (v) => setState(
                                  () => _chimeIntervalMinutes = v ?? 60,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ACTIVE HOURS (START - END)',
                            style: TextStyle(
                              color: Colors.cyanAccent.withOpacity(0.6),
                              fontSize: 9,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: _buildHourPicker(
                                  _chimeStartHour,
                                  (v) => setState(() => _chimeStartHour = v),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  'TO',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.3),
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: _buildHourPicker(
                                  _chimeEndHour,
                                  (v) => setState(() => _chimeEndHour = v),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHourPicker(int current, Function(int) onChange) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: current,
          dropdownColor: Colors.grey.shade900,
          isExpanded: true,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
          icon: const Padding(
            padding: EdgeInsets.only(right: 4.0),
            child: Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: Colors.cyanAccent,
            ),
          ),
          items: List.generate(24, (index) => index)
              .map(
                (i) => DropdownMenuItem(
                  value: i,
                  child: Center(
                    child: Text(
                      '${i.toString().padLeft(2, '0')}:00',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (v) => onChange(v ?? current),
        ),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: Colors.cyanAccent,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.cyanAccent,
            foregroundColor: Colors.black,
            padding: EdgeInsets.symmetric(
              horizontal: _isNote ? 20 : 32,
              vertical: _isNote ? 10 : 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 8,
            shadowColor: Colors.cyanAccent.withOpacity(0.4),
          ),
          child: Text(
            widget.task == null ? 'CREATE TASK' : 'SAVE CHANGES',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: _isNote ? 12 : 13,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ],
    );
  }

  void _submit() {
    if (_nameController.text.trim().isEmpty) return;

    final task = (widget.task ?? TaskItem(isNote: _isNote))
      ..name = _nameController.text.trim()
      ..isNote = _isNote
      ..sentiment = _sentiment
      ..hasCounterMetric = _hasCounter
      ..hasDistanceMetric = _hasDistance
      ..hasDoseMetric = _hasDose
      ..hasTimeMetric = _hasTime
      ..hasWeightMetric = _hasWeight
      ..hasEnergyMetric = _hasEnergy
      ..hasRatingMetric = _hasRating
      ..hasPercentageMetric = _hasPercentage
      ..hasFinancialMetric = _hasFinancial
      ..timerType = _timerType
      ..targetSeconds = _targetMinutes * 60
      ..currentSeconds = _timerType == 1 ? _targetMinutes * 60 : 0
      ..alarmTime = _alarmTimeString
      ..alarmSoundPath = _alarmSoundPath
      ..recurrenceType = _recurrenceType
      ..specificDays = (_selectedDays.toList()..sort()).join(',')
      ..currency = _currency
      ..counterMax = int.tryParse(_counterMaxController.text) ?? 0
      ..notes = _notesController.text.trim()
      ..imagePaths = _imagePaths
      ..isHourlyChimeEnabled = _isHourlyChimeEnabled
      ..chimeIntervalMinutes = _chimeIntervalMinutes
      ..chimeStartHour = _chimeStartHour
      ..chimeEndHour = _chimeEndHour
      ..isDoubleTimer = _isDoubleTimer
      ..breakTargetSeconds = _breakMinutes * 60
      ..isWorkPeriod =
          true // Always start with work period
      ..lastEditedDate = DateTime.now();

    // Auto-complete if updating an existing task
    if (widget.task != null) {
      final now = DateTime.now();
      if (task.lastCompleted == null ||
          !DateUtils.isSameDay(task.lastCompleted, now)) {
        task.lastCompleted = now;
      }
    }

    if (widget.task == null) {
      context.read<TaskCubit>().createTask(task);
    } else {
      context.read<TaskCubit>().updateTask(task);
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _counterMaxController.dispose();
    _notesController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }
}

class _CustomTimePickerDialog extends StatefulWidget {
  final TimeOfDay initialTime;
  const _CustomTimePickerDialog({required this.initialTime});

  @override
  State<_CustomTimePickerDialog> createState() =>
      _CustomTimePickerDialogState();
}

class _CustomTimePickerDialogState extends State<_CustomTimePickerDialog> {
  late TextEditingController _hourController;
  late TextEditingController _minController;
  late bool _isPm;

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
            const Text(
              "SET ALARM",
              style: TextStyle(
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
              required int currentLength,
              required bool isFocused,
              required int? maxLength,
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
