import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TempoInputDialog extends StatefulWidget {
  final int eccentric;
  final int isometric;
  final int concentric;

  const TempoInputDialog({
    super.key,
    required this.eccentric,
    required this.isometric,
    required this.concentric,
  });

  @override
  State<TempoInputDialog> createState() => _TempoInputDialogState();
}

class _TempoInputDialogState extends State<TempoInputDialog> {
  late TextEditingController _eccController;
  late TextEditingController _isoController;
  late TextEditingController _conController;

  @override
  void initState() {
    super.initState();
    _eccController = TextEditingController(text: widget.eccentric.toString());
    _isoController = TextEditingController(text: widget.isometric.toString());
    _conController = TextEditingController(text: widget.concentric.toString());
  }

  @override
  void dispose() {
    _eccController.dispose();
    _isoController.dispose();
    _conController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Tempo'),
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTempoField('ECC', _eccController),
          const SizedBox(width: 8),
          _buildTempoField('ISO', _isoController),
          const SizedBox(width: 8),
          _buildTempoField('CON', _conController),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final ecc = int.tryParse(_eccController.text) ?? 0;
            final iso = int.tryParse(_isoController.text) ?? 0;
            final con = int.tryParse(_conController.text) ?? 0;
            Navigator.of(context).pop([ecc, iso, con]);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  Widget _buildTempoField(String label, TextEditingController controller) {
    return SizedBox(
      width: 60,
      child: TextField(
        controller: controller,
        onTap: () {
          controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: controller.text.length,
          );
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          labelText: label,
          counterText: '',
          border: const OutlineInputBorder(),
        ),
        maxLength: 2,
      ),
    );
  }
}
