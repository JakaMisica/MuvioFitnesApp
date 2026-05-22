import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleTechniqueEditDialog extends StatefulWidget {
  final String techniqueName;
  final int? currentValue;
  final bool isBoolean;
  final VoidCallback? onDelete;
  final String? deleteLabel;
  final Function(int?)? onSave;

  const SingleTechniqueEditDialog({
    super.key,
    required this.techniqueName,
    this.currentValue,
    this.isBoolean = false,
    this.onDelete,
    this.deleteLabel,
    this.onSave,
  });

  @override
  State<SingleTechniqueEditDialog> createState() =>
      _SingleTechniqueEditDialogState();
}

class _SingleTechniqueEditDialogState extends State<SingleTechniqueEditDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.currentValue?.toString() ?? '',
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
      backgroundColor: const Color(0xFF121212),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      title: Text(
        'Edit ${widget.techniqueName}',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 20,
          letterSpacing: 0.5,
        ),
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 280),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.isBoolean)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Remove this technique from the set?',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 15,
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextField(
                  controller: _controller,
                  onTap: () {
                    _controller.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: _controller.text.length,
                    );
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: widget.techniqueName,
                    labelStyle: const TextStyle(color: Colors.cyanAccent),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.cyanAccent.withOpacity(0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.cyanAccent),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.05),
                  ),
                  autofocus: true,
                ),
              ),
          ],
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      actions: [
        Row(
          children: [
            if (widget.onDelete != null)
              IconButton(
                onPressed: () {
                  widget.onDelete!();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                tooltip: widget.deleteLabel ?? 'Delete',
              ),
            const Spacer(),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'CANCEL',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(width: 8),
            if (!widget.isBoolean)
              ElevatedButton(
                onPressed: () {
                  final value = int.tryParse(_controller.text);
                  if (value != null && widget.onSave != null) {
                    widget.onSave!(value);
                  }
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text('SAVE', style: TextStyle(fontWeight: FontWeight.w900)),
              )
            else
              ElevatedButton(
                onPressed: () {
                  widget.onDelete?.call();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: const Text('REMOVE', style: TextStyle(fontWeight: FontWeight.w900)),
              ),
          ],
        ),
      ],
    );
  }
}
