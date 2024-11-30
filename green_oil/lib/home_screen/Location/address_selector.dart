import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:green_oil/home_screen/Location/lacation_item.dart';
import 'package:green_oil/home_screen/Location/map_screen.dart';
import 'package:green_oil/models/my_order.dart';

class AddressSelector extends StatefulWidget {
  const AddressSelector({
    super.key,
    required this.onLocationsChanged,
  });

  final Function(bool hasChanged) onLocationsChanged;

  @override
  State<StatefulWidget> createState() {
    return _AddressSelectorState();
  }
}

class _AddressSelectorState extends State<AddressSelector> {
  final List<Location> lacation = [];
  bool _hasChanged = false;

  void _markAsChanged() {
    if (!_hasChanged) {
      setState(() {
        _hasChanged = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationsFromFirestore();
  }

  @override
  void dispose() {
    widget.onLocationsChanged(_hasChanged);
    super.dispose();
  }

  void getLocationsFromFirestore() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      try {
        final firestore = FirebaseFirestore.instance;
        // Reference to the user's saved locations document
        final userRef = firestore.collection('provider').doc(userId);
        final docSnapshot = await userRef.get();

        if (docSnapshot.exists) {
          // Safely attempt to cast as List<dynamic>, allowing for null if 'savedLocations' does not exist
          var locationData =
              docSnapshot.data()?['savedLocations'] as List<dynamic>?;
          if (locationData != null) {
            // This check is valid if 'as List<dynamic>?' is used
            for (var loc in locationData) {
              if (loc is Map<String, dynamic>) {
                // Ensures each item is a valid map
                Location newLocation = Location.fromMap(loc);
                setState(() {
                  lacation.add(newLocation);
                });
              }
            }
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error retrieving locations: $e'),
            ),
          );
        }
      }
    }
  }

  void _addNewLocation() async {
    final newLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MapScreen(),
      ),
    );
    if (newLocation != null) {
      setState(() {
        lacation.add(newLocation);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose your delivery address',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: lacation.length,
              itemBuilder: (ctx, index) => LacationItem(
                location: lacation[index],
                index: index,
                onDelete: () {
                  setState(() {
                    lacation.removeAt(index);
                  });
                },
                onSelect: () {
                  Navigator.of(context).pop({
                    'location': lacation[index],
                    'listChanged': _hasChanged
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _addNewLocation,
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: Text(
              'Add New Address',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ), // Green border
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
            ),
          ),
        ],
      ),
    );
  }
}
