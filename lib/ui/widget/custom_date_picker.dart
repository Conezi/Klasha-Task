import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Color? pickerColor;
  final DateTime? initialDate;
  final void Function(DateTime dateTime)? onSelected;
  const CustomDatePicker(
      {this.firstDate,
      this.lastDate,
      this.pickerColor,
      this.initialDate,
      this.onSelected,
      Key? key})
      : super(key: key);

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: widget.firstDate ??
            DateTime.now().add(const Duration(days: -50000)),
        lastDate:
            widget.lastDate ?? DateTime.now().add(const Duration(days: 90000)),
        builder: (BuildContext? ctx, Widget? child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  brightness: Brightness.dark,
                  colorScheme: ColorScheme.light(
                      primary: Theme.of(context).colorScheme.secondary)),
              child: child!);
        });
    if (picked != null && picked != selectedDate) {
      setPicked(picked);
      if (widget.onSelected != null) widget.onSelected!(picked);
    }
  }

  void setPicked(picked) => setState(() => selectedDate = picked);

  @override
  void initState() {
    if (widget.initialDate != null) {
      selectedDate = widget.initialDate!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => _selectDate(context),
        icon: Icon(Icons.date_range_rounded,
            color: Theme.of(context).primaryColor));
  }
}
