import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/diet_models.dart';
import '../../../../logic/cubit/diet/diet_cubit.dart';
import 'weekly_schedule_dialog.dart';

class TemplateManagerDialog extends StatefulWidget {
  const TemplateManagerDialog({super.key});

  @override
  State<TemplateManagerDialog> createState() => _TemplateManagerDialogState();
}

class _TemplateManagerDialogState extends State<TemplateManagerDialog> {
  List<DietTemplate> _templates = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    final templates = await context.read<DietCubit>().getTemplates();
    setState(() {
      _templates = templates;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF121212),
      insetPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxHeight: 700),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "SAVED DIETS",
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white54),
                ),
              ],
            ),
            const Divider(color: Colors.white10),
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.cyanAccent,
                      ),
                    )
                  : _templates.isEmpty
                  ? const Center(
                      child: Text(
                        "No saved diets yet.\nUse 'Save Diet' to create one!",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white38),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _templates.length,
                      itemBuilder: (context, index) {
                        final template = _templates[index];
                        return _buildTemplateCard(template);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemplateCard(DietTemplate template) {
    return InkWell(
      onTap: () => _loadTemplate(template),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    template.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${template.meals.length} meals",
                    style: const TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                  if (template.scheduledDays.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        "Auto: ${_getDayNames(template.scheduledDays)}",
                        style: const TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 10,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.calendar_today,
                color: Colors.cyanAccent,
                size: 16,
              ),
              tooltip: "Schedule",
              iconSize: 16,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              onPressed: () => _openScheduler(template),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent, size: 16),
              tooltip: "Delete",
              iconSize: 16,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              onPressed: () => _deleteTemplate(template.id),
            ),
          ],
        ),
      ),
    );
  }

  String _getDayNames(List<int> days) {
    const dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days.map((d) => dayNames[d - 1]).join(', ');
  }

  Future<void> _openScheduler(DietTemplate template) async {
    await showDialog(
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: context.read<DietCubit>(),
        child: WeeklyScheduleDialog(template: template),
      ),
    );
    _loadTemplates(); // Refresh to show updated schedule
  }

  Future<void> _loadTemplate(DietTemplate template) async {
    await context.read<DietCubit>().loadTemplate(template);
    if (mounted) Navigator.pop(context);
  }

  Future<void> _deleteTemplate(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text(
          "Delete Diet?",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          "This cannot be undone.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("CANCEL"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text("DELETE"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await context.read<DietCubit>().deleteTemplate(id);
      _loadTemplates();
    }
  }
}
