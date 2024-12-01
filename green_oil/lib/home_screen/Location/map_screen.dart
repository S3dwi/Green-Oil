import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_oil/models/my_order.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _selectedPosition;
  // Variable to store the selected position on the map

  // Adds a location (latitude, longitude, etc.) to the authenticated user's
  // "savedLocations" array in Firestore under the 'provider' collection.
  Future<void> _saveLocationToFirestore(
      String userId, Map<String, dynamic> location) async {
    try {
      final firestore = FirebaseFirestore.instance;

      // Reference to the user's saved locations
      final userRef = firestore.collection('provider').doc(userId);

      // Add the location to the user's "savedLocations" array
      await userRef.update({
        'savedLocations': FieldValue.arrayUnion([location]),
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error saving location'),
          ),
        );
      }
    }
  }

  // Saves the selected location (latitude, longitude) to Firestore and navigates back.
  void _onLocationSelected(LatLng position) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      final location = {
        'latitude': position.latitude,
        'longitude': position.longitude,
      };

      await _saveLocationToFirestore(userId, location);
      if (mounted) {
        // Optionally navigate back or show a success message
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Address'),
        actions: [
          if (_selectedPosition != null)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                _onLocationSelected(_selectedPosition!);
                Navigator.pop(
                    context,
                    Location(
                      latitude: _selectedPosition!.latitude,
                      longitude: _selectedPosition!.longitude,
                    ));
              },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(21.543333, 39.172778), // Default Jeddah location
          zoom: 16.0,
        ),
        onTap: (LatLng position) {
          // Update the selected position when the user taps on the map
          setState(() {
            _selectedPosition = position;
          });
        },
        markers: _selectedPosition != null
            ? {
                Marker(
                  markerId: const MarkerId('selectedLocation'),
                  position: _selectedPosition!,
                  infoWindow: const InfoWindow(title: 'Selected Location'),
                ),
              }
            : {},
      ),
    );
  }
}
