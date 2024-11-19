import 'package:flutter/material.dart';
import 'package:green_oil/home_screen/new_location.dart';
import 'package:green_oil/models/MyOrder.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key, required this.onLocationSelected});

  final Function(Location) onLocationSelected;

// When location is selected, pass it back using the callback
  void _selectLocation() {
    Location location = Location(
      city: "Jeddah",
      latitude: 21.543333,
      longitude: 39.172778,
    );
    onLocationSelected(location);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectLocation,
      child: Center(
        child: Container(
          height: 80,
          margin: EdgeInsets.symmetric(vertical: 7, horizontal: 25),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Company Address',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      'Jeddah - Alrabwah 23223, Bin Khalid Alansari, Near Albaik Almarwah branch 6977',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  _openAddExpense(context);
                },
                child: Text(
                  'CHANGE',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openAddExpense(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NewLocation(),
    );
  }
}
