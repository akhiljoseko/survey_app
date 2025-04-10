import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InlineDateInput extends StatefulWidget {
  const InlineDateInput({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
    this.validator,
    required this.label,
    this.enabledDateRangeStart,
    this.enabledDateRangeEnd,
  });

  final DateTime? initialDate;
  final void Function(DateTime? date) onDateSelected;
  final String? Function(DateTime?)? validator;
  final String label;
  final DateTime? enabledDateRangeStart;
  final DateTime? enabledDateRangeEnd;

  @override
  State<InlineDateInput> createState() => _InlineDateInputState();
}

class _InlineDateInputState extends State<InlineDateInput> {
  late final TextEditingController _controller;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _controller = TextEditingController();
    _updateControllerText();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      canRequestFocus: false,
      enableInteractiveSelection: false,
      readOnly: true,
      validator: (value) => widget.validator?.call(_selectedDate),
      decoration: InputDecoration(
        label: Text(widget.label),
        helperText: "",
        suffixIcon:
            _selectedDate != null
                ? InkWell(
                  onTap: () => _handleDateSelection(null),
                  child: const Icon(Icons.close),
                )
                : const SizedBox(),
      ),
      onTap: () => _showDatePicker(),
    );
  }

  Future<void> _showDatePicker() async {
    final date = await showDatePicker(
      context: context,
      useRootNavigator: true,
      firstDate: widget.enabledDateRangeStart ?? DateTime.now(),
      lastDate:
          widget.enabledDateRangeEnd ??
          DateTime.now().add(Duration(days: 365 * 10)),
      initialDate: _selectedDate ?? DateTime.now(),
    );
    if (date != null) {
      _handleDateSelection(date);
    }
  }

  void _handleDateSelection(DateTime? date) {
    widget.onDateSelected.call(date);
    setState(() {
      _selectedDate = date;
    });
    _updateControllerText();
  }

  void _updateControllerText() {
    if (_selectedDate != null) {
      final DateFormat format = DateFormat("d MMM yyyy");
      final formatedDate = format.format(_selectedDate!);
      _controller.text = formatedDate;
    } else {
      _controller.text = "";
    }
  }
}
