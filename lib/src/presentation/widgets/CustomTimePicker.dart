import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomTimePicker extends StatefulWidget {
  final String label;
  final TimeOfDay? initialTime;
  final void Function(TimeOfDay) onTimeSelected;

  const CustomTimePicker({
    super.key,
    required this.label,
    this.initialTime,
    required this.onTimeSelected,
  });

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime ?? TimeOfDay.now();
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime!,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
      widget.onTimeSelected(picked);
    }
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt); // Formato 12h con AM/PM
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickTime,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedTime == null
                      ? "Selecciona una hora"
                      : _formatTime(_selectedTime!),
                  style: TextStyle(
                    fontSize: 16,
                    color: _selectedTime == null
                        ? Colors.grey
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Icon(Icons.access_time, color: Colors.blueGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
