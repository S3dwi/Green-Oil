import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'package:green_oil/home_screen/Location/address_selector.dart';
import 'package:green_oil/home_screen/order_process_screen.dart';
import 'package:green_oil/home_screen/usage_policy_screen.dart';
import 'package:green_oil/recycle_oil_screen/recycle_oil.dart';
import 'package:green_oil/home_screen/clickable_cards.dart';
import 'package:green_oil/home_screen/recycle_button.dart';
import 'package:green_oil/home_screen/image_carousel.dart';
import 'package:green_oil/home_screen/faqs_screen.dart';
import 'package:green_oil/models/my_order.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadAddress();
  }

  void recycleOil(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RecycleOil(
          currentStep: 0,
        ),
      ),
    );
  }

  Location? _location;
  String? _selectedAddress; // Start with no address selected
  // method to open the NewExpense page in Bottom sheet
  void _openAddressSelector() {
    showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => AddressSelector(
        onLocationsChanged: (hasChanged) {
          if (hasChanged) {
            setState(() {
              _selectedAddress = null;
            });
          }
        },
      ),
    ).then((result) {
      // Assuming 'result' can be null, which it can be if the modal is dismissed with no action
      setState(() {
        if (result != null) {
          Location? selectedLocation =
              result['location']; // Declare as nullable
          bool listChanged = result['listChanged'];

          if (!listChanged && selectedLocation != null) {
            _selectedAddress = selectedLocation.toString();
            _location = selectedLocation;
            _saveAddress(
              selectedLocation.latitude,
              selectedLocation.longitude,
              _selectedAddress!,
            );
          } else {
            _saveAddress(
              0.0,
              0.0,
              'No address selected',
            );
            _selectedAddress = null;
          }
        } else {
          _saveAddress(
            0.0,
            0.0,
            'No address selected',
          );
          _selectedAddress = null;
        }
      });
    });
  }

  void _loadAddress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _location = Location(
        latitude: prefs.getDouble('latitude') ?? 0.0,
        longitude: prefs.getDouble('longitude') ?? 0.0,
      );
      _selectedAddress = prefs.getString('selectedAddress');
    });
  }

  void _saveAddress(double latitude, double longitude, String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', latitude);
    await prefs.setDouble('longitude', longitude);
    await prefs.setString('selectedAddress', address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Recycle Button section
            SizedBox(
              width: double.infinity,
              height: 320, // Same vertical size as before
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/home_img.png', // Placeholder for the background image
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: 60,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Be Recycled',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 0),
                        Text(
                          'Help the planet & enjoy \nvaluable benefits!',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Theme.of(context).colorScheme.primary,
                              size: 30,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _selectedAddress ?? 'No address selected',
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              onPressed: _openAddressSelector,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Theme.of(context).shadowColor,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 20,
                    right: 20,
                    child: Divider(),
                    //create line to separate between the components,
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15), // Same padding
              child: RecycleButton(
                onRecycleOil: () {
                  recycleOil(context);
                },
              ),
            ),

            const SizedBox(
              height: 32,
            ),

            // Image Carousel
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15), // Same padding
              child: ImageCarousel(),
            ),

            const SizedBox(
              height: 16,
            ),

            // Title for the clickable cards section
            const Padding(
              padding: EdgeInsets.fromLTRB(
                  24.0, 0.0, 0.0, 10.0), // Add spacing below the title
              child: Align(
                alignment:
                    Alignment.centerLeft, // Explicitly align title to the left
                child: Text(
                  'Discover Green Oil',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // // Three buttons taking up full width
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Row(
                children: [
                  ClickableCards(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FAQScreen(),
                        ),
                      );
                    },
                    icon: Icons.question_answer,
                    label: 'FAQs',
                  ),

                  const SizedBox(width: 10), // Spacing between buttons

                  ClickableCards(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => OrderProcessScreen(),
                        ),
                      );
                    },
                    icon: Icons.checklist_sharp,
                    label: 'Order Process',
                  ),

                  const SizedBox(width: 8), // Spacing between buttons

                  ClickableCards(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UsagePolicyScreen(),
                        ),
                      );
                    },
                    icon: Icons.article_outlined,
                    label: 'Usage Policy',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
