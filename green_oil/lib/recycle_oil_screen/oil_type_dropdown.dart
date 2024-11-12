// oil_type_dropdown.dart
import 'package:flutter/material.dart';

class OilTypeDropdown extends StatelessWidget {
  final String? selectedOilType;
  final Function(String) onSelected;

  final List<Map<String, dynamic>> _oilTypes = [
    {'name': 'Cooking Oil', 'isDisabled': false},
    {'name': 'Motor Oil', 'isDisabled': true},
    {'name': 'Lubricating Oil', 'isDisabled': true},
  ];

  OilTypeDropdown({
    super.key,
    required this.selectedOilType,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: PopupMenuButton<String>(
        onSelected: (String newValue) => onSelected(newValue),
        itemBuilder: (BuildContext context) {
          return _oilTypes.map((oilType) {
            bool isDisabled = oilType['isDisabled'];
            return PopupMenuItem<String>(
              value: oilType['name'],
              enabled: !isDisabled,
              child: Text(
                oilType['name'],
                style: TextStyle(
                  fontSize: 20,
                  color: isDisabled
                      ? Theme.of(context).disabledColor
                      : Theme.of(context).colorScheme.secondary,
                ),
              ),
            );
          }).toList();
        },
        constraints: BoxConstraints(minWidth: 350),
        offset: Offset(-20, 50),
        elevation: 8,
        color: Theme.of(context).colorScheme.onPrimary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedOilType ?? 'Choose Your Oil Type',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
