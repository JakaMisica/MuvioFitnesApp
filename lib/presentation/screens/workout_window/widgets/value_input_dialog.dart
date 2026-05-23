import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/services/tutorial_service.dart';

/// Interactive dialog for inputting weight or reps with increment/decrement controls
class ValueInputDialog extends StatefulWidget {
  final String title;
  final double initialValue;
  final String unit;
  final double defaultIncrement;
  final Function(double)? onIncrementChanged;
  final Function(double)? onChanged;
  final bool showDelete;
  final bool isEmbedded;

  const ValueInputDialog({
    super.key,
    required this.title,
    required this.initialValue,
    this.unit = 'kg',
    this.defaultIncrement = 2.5,
    this.onIncrementChanged,
    this.onChanged,
    this.showDelete = false,
    this.isEmbedded = false,
  });

  @override
  State<ValueInputDialog> createState() => _ValueInputDialogState();
}

class _ValueInputDialogState extends State<ValueInputDialog> {
  late TextEditingController _valueController;
  late TextEditingController _incrementController;
  late double _currentValue;
  late double _increment;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _increment = widget.defaultIncrement;

    // Format text to remove trailing .0 if integer
    String valText = _currentValue % 1 == 0
        ? _currentValue.toInt().toString()
        : _currentValue.toString();

    _valueController = TextEditingController(text: valText);
    _incrementController = TextEditingController(
      text: _formatDouble(_increment),
    );

    // Select all text initially
    _valueController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _valueController.text.length,
    );
  }

  @override
  void dispose() {
    _valueController.dispose();
    _incrementController.dispose();
    super.dispose();
  }

  String _formatDouble(double v) {
    return v % 1 == 0 ? v.toInt().toString() : v.toString();
  }

  void _updateValue(double newValue) {
    setState(() {
      _currentValue = newValue;
      _valueController.text = _formatDouble(_currentValue);
    });
    if (widget.onChanged != null) {
      widget.onChanged!(_currentValue);
    }
  }

  void _decrementValue() {
    _updateValue(_currentValue - _increment);
  }

  void _incrementValue() {
    _updateValue(_currentValue + _increment);
  }

  void _updateIncrement(String value) {
    final newIncrement = double.tryParse(value);
    if (newIncrement != null && newIncrement > 0) {
      setState(() {
        _increment = newIncrement;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    widgetContent() => Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title
        Center(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ), // Shrunk from titleLarge
          ),
        ),
        const SizedBox(height: 12), // Shrunk from 24
        // Increment Controls Row
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Decrement Arrow
              IconButton(
                onPressed: _decrementValue,
                icon: const Icon(Icons.arrow_left, size: 32),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Increment Value Display/Editor
              InkWell(
                onTap: () async {
                  final result = await showDialog<String>(
                    context: context,
                    builder: (_) => _IncrementEditorDialog(
                      initialValue: _increment,
                      unit: widget.unit,
                    ),
                  );
                  if (result != null) {
                    _updateIncrement(result);
                    _incrementController.text = result;
                    // Notify parent of increment change
                    final newIncrement = double.tryParse(result);
                    if (newIncrement != null &&
                        widget.onIncrementChanged != null) {
                      widget.onIncrementChanged!(newIncrement);
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).primaryColor.withOpacity(0.35), // Increased opacity
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(
                        0.8,
                      ), // Semi-transparent border
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    '±${_formatDouble(_increment)} ${widget.unit}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.white, // Pure white for maximum visibility
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Increment Arrow
              IconButton(
                key: widget.title == 'Rest Duration'
                    ? TutorialService().getKeyForStep(
                        TutorialStep.increaseRestTime,
                      )
                    : null,
                onPressed: _incrementValue,
                icon: const Icon(Icons.arrow_right, size: 32),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12), // Shrunk from 24
        // Value Input Field
        TextField(
          key: widget.title == 'RIR'
              ? TutorialService().getKeyForStep(TutorialStep.typeRir)
              : null,
          controller: _valueController,
          autofocus: true,
          onTap: () {
            _valueController.selection = TextSelection(
              baseOffset: 0,
              extentOffset: _valueController.text.length,
            );
          },
          keyboardType: TextInputType.numberWithOptions(
            decimal: widget.unit != 'rps', // No decimals for reps
          ),
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ), // Shrunk from headlineMedium
          decoration: InputDecoration(
            suffixText: widget.unit,
            suffixStyle: Theme.of(context).textTheme.titleMedium,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.white12,
          ),
          inputFormatters: [
            if (widget.unit == 'rps')
              FilteringTextInputFormatter
                  .digitsOnly // Only whole numbers for reps
            else
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          onChanged: (value) {
            final newValue = double.tryParse(value);
            if (newValue != null) {
              _currentValue = newValue;
              if (widget.onChanged != null) {
                widget.onChanged!(_currentValue);
              }
            }
          },
        ),
        const SizedBox(height: 12), // Shrunk from 24
        // Action Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (widget.showDelete) ...[
              TextButton(
                onPressed: () => Navigator.pop(context, double.infinity),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const Spacer(),
            ],
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              key: widget.title == 'Rest Duration'
                  ? TutorialService().getKeyForStep(TutorialStep.saveRestTime)
                  : (widget.title == 'RIR'
                        ? TutorialService().getKeyForStep(TutorialStep.saveRir)
                        : null),
              onPressed: () {
                final value = double.tryParse(_valueController.text);
                Navigator.pop(context, value ?? _currentValue);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ],
    );

    if (widget.isEmbedded) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ), // Reduced padding
        width: 300, // Fixed width for dual window alignment
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white10),
        ),
        child: widgetContent(),
      );
    }

    return Dialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: widgetContent(),
      ),
    );
  }
}

/// Small dialog to edit the increment value
class _IncrementEditorDialog extends StatefulWidget {
  final double initialValue;
  final String unit;

  const _IncrementEditorDialog({
    required this.initialValue,
    required this.unit,
  });

  @override
  State<_IncrementEditorDialog> createState() => _IncrementEditorDialogState();
}

class _IncrementEditorDialogState extends State<_IncrementEditorDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialValue % 1 == 0
          ? widget.initialValue.toInt().toString()
          : widget.initialValue.toString(),
    );
    _controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: _controller.text.length,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set Increment'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        onTap: () {
          _controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: _controller.text.length,
          );
        },
        keyboardType: TextInputType.numberWithOptions(
          decimal: widget.unit != 'rps',
        ),
        decoration: const InputDecoration(
          labelText: 'Increment Value',
          border: OutlineInputBorder(),
        ),
        inputFormatters: [
          if (widget.unit == 'rps')
            FilteringTextInputFormatter.digitsOnly
          else
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, _controller.text);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
