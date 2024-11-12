import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectPickupDate extends StatefulWidget {
  const SelectPickupDate({super.key, required this.onDateSelected});

  final Function(DateTime) onDateSelected;

  @override
  SelectPickupDateState createState() => SelectPickupDateState();
}

class SelectPickupDateState extends State<SelectPickupDate> {
  DateTime? selectedDate;
  List<DateTime> dates = [];
  late List<String> monthOptions;

  @override
  void initState() {
    super.initState();
    _generateMonthOptions();
    _generateDates(DateTime.now().year, DateTime.now().month);
  }

  // Generate a fixed list of month options based on the initial month
  void _generateMonthOptions() {
    final now = DateTime.now();
    monthOptions = List.generate(3, (index) {
      final month = DateTime(now.year, now.month + index, 1);
      return DateFormat('MMMM').format(month);
    });
  }

  // Generate a list of dates for the specified month and year, starting from today
  void _generateDates(int year, int month) {
    final now = DateTime.now();
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final startDay = (year == now.year && month == now.month) ? now.day : 1;

    dates = List.generate(
      daysInMonth - startDay + 1,
      (index) => DateTime(year, month, startDay + index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Month Dropdown
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DropdownButton<String>(
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
              dropdownColor: Theme.of(context).colorScheme.onPrimary,
              value: selectedDate != null
                  ? DateFormat('MMMM').format(selectedDate!)
                  : monthOptions.first,
              items: monthOptions.map((month) {
                return DropdownMenuItem<String>(
                  value: month,
                  child: Text(month),
                );
              }).toList(),
              underline: SizedBox(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  int newMonth = DateFormat('MMMM').parse(newValue).month;
                  setState(() {
                    // Clear selected date when the month changes
                    selectedDate = null;
                    _generateDates(DateTime.now().year, newMonth);
                  });
                }
              },
            ),
          ],
        ),

        // Date Cards
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: dates.map((date) {
              bool isSelected = selectedDate != null &&
                  date.day == selectedDate!.day &&
                  date.month == selectedDate!.month;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDate = date;
                    widget.onDateSelected(selectedDate!);
                  });
                },
                child: Container(
                  width: 57, // Fixed width
                  height: 100, // Fixed height
                  margin: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).disabledColor,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('MMM').format(date).toUpperCase(),
                        style: TextStyle(
                          color: isSelected
                              ? Theme.of(context).colorScheme.onSecondary
                              : Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        date.day.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: isSelected
                              ? Theme.of(context).colorScheme.onSecondary
                              : Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        DateFormat('EEE').format(date).toUpperCase(),
                        style: TextStyle(
                          color: isSelected
                              ? Theme.of(context).colorScheme.onSecondary
                              : Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
