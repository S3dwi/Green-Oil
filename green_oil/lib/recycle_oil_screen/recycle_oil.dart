import 'package:flutter/material.dart';

import 'package:green_oil/primary_button.dart';
import 'package:green_oil/recycle_oil_screen/location_card.dart';
import 'package:green_oil/recycle_oil_screen/oil_type_dropdown.dart';
import 'package:green_oil/recycle_oil_screen/quantity_selector.dart';
import 'package:green_oil/recycle_oil_screen/select_pickup_date.dart';
import 'package:green_oil/recycle_oil_screen/step_progress_indicator.dart';
import 'package:green_oil/models/my_order.dart';
import 'package:green_oil/recycle_oil_screen/order_summary.dart';

class RecycleOil extends StatefulWidget {
  const RecycleOil({
    super.key,
    required this.currentStep,
  });

  final int currentStep;
  static var totalSteps = 3;
  static var stepTitles = [
    "Oil Type",
    "Quantity & Pickup",
    "Order Summary",
  ];

  @override
  State<StatefulWidget> createState() {
    return _RecycleOilState();
  }
}

class _RecycleOilState extends State<RecycleOil> {
  final int totalSteps = RecycleOil.totalSteps;
  int currentStep = 0; // Set initial step
  double quantity = 50.0; // Initial quantity

  final TextEditingController _quantityController = TextEditingController();

  String? _selectedOilType;
  DateTime? _arrivalDate;

  //to be fixed when location functionality is implemented
  Location? _selectedLocation;

  final List<String> stepTitles = RecycleOil.stepTitles;

  // Handle location selection from LocationCard
  void _onLocationSelected(Location location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  // Callback to update the selected date
  void _onDateSelected(DateTime date) {
    setState(() {
      _arrivalDate = date;
    });
  }

  // Helper method to convert selectedOilType string to OilType enum
  OilType? _mapStringToOilType(String? oilTypeString) {
    switch (oilTypeString) {
      case 'Cooking Oil':
        return OilType.cookingOil;
      case 'Motor Oil':
        return OilType.motorOil;
      case 'Lubricating Oil':
        return OilType.lubricating;
      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _quantityController.text = quantity.toStringAsFixed(0);
  }

  // Method to increment the quantity
  void _incrementQuantity() {
    setState(() {
      if (quantity < 500) {
        quantity += 1;
        _quantityController.text = quantity.toStringAsFixed(0);
      }
    });
  }

  // Method to decrement the quantity
  void _decrementQuantity() {
    setState(() {
      if (quantity > 10) {
        quantity -= 1;
        _quantityController.text = quantity.toStringAsFixed(0);
      }
    });
  }

  // Method to handle direct input validation in the text field
  void _validateQuantityInput(String value) {
    final int? newQuantity = int.tryParse(value);
    if (newQuantity == null) {
      // Show error if the value is not a valid integer
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please enter a valid quantity",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
          duration: Duration(seconds: 2),
        ),
      );
      _quantityController.text = quantity.toStringAsFixed(0);
    } else {
      setState(() {
        if (newQuantity < 10) {
          quantity = 10;
          _quantityController.text = "10";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Minimum quantity is 10"),
              backgroundColor: Theme.of(context).colorScheme.error,
              duration: Duration(seconds: 2),
            ),
          );
        } else if (newQuantity > 500) {
          quantity = 500;
          _quantityController.text = "500";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Maximum quantity is 500"),
              backgroundColor: Theme.of(context).colorScheme.error,
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          quantity = newQuantity.toDouble();
          _quantityController.text = quantity.toStringAsFixed(0);
        }
      });
    }
  }

  void _showSelectOilTypeSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            msg,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontSize: 15,
            ),
          ),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 10,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDimmed = _selectedOilType == null;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(
                40.0,
              ), // Increase bottom size if needed
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: StepProgressIndicator(
                  currentStep: currentStep,
                  totalSteps: totalSteps,
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 25,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            // Add flexibleSpace for custom positioning
            flexibleSpace: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 0.0,
                ), // Adjust top padding as needed
                child: Align(
                  alignment: Alignment.center, // Keeps title in the center
                  child: Text(
                    stepTitles[currentStep],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 27,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 40),
                // Dropdown to choose oil type
                OilTypeDropdown(
                  selectedOilType: _selectedOilType,
                  onSelected: (String newValue) {
                    setState(() {
                      _selectedOilType = newValue;
                      currentStep = 1;
                    });
                  },
                ),
                SizedBox(height: 40),

                // Editable quantity field with increment and decrement buttons
                Opacity(
                  opacity: isDimmed ? 0.5 : 1.0,
                  child: IgnorePointer(
                    ignoring: isDimmed,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            "Add Your Estimated Oil Quantity (L)",
                            style: TextStyle(
                              fontSize: 19,
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        QuantitySelector(
                          quantity: quantity,
                          onIncrement: _incrementQuantity,
                          onDecrement: _decrementQuantity,
                          controller: _quantityController,
                          onSubmitted: _validateQuantityInput,
                        ),
                        SizedBox(height: 40),

                        // Company Location
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            "Company Location",
                            style: TextStyle(
                              fontSize: 21,
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        //LOCATION CARD
                        LocationCard(onLocationSelected: _onLocationSelected),
                        SizedBox(height: 40),

                        // Select Pickup Date
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            "Select Pickup Date",
                            style: TextStyle(
                              fontSize: 21,
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 20,
                          ),
                          child: SelectPickupDate(
                            onDateSelected: _onDateSelected,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        // Next Button
                        PrimaryButton(
                          onPressed: () {
                            if (_selectedOilType == null) {
                              _showSelectOilTypeSnackBar(
                                  "Please Select Oil Type!");
                            } else if ( //_selectedLocation == null ||
                                _arrivalDate == null) {
                              _showSelectOilTypeSnackBar(
                                  "Please Select Location & Pickup Date!");
                            } else {
                              // Convert the selected oil type to enum
                              final OilType? oilType =
                                  _mapStringToOilType(_selectedOilType);

                              if (oilType == null) {
                                _showSelectOilTypeSnackBar(
                                    "Invalid Oil Type selected!");
                                return;
                              }

                              //Create the Order object
                              final order = MyOrder(
                                orderID: 'ToBeImplemented',
                                oilType: oilType,
                                oilQuantity: quantity,
                                arrivalDate: _arrivalDate!,
                                orderStatus:
                                    OrderStatus.processing, // default status
                                location: Location(
                                    city: 'Jeddah',
                                    latitude: 21.735611,
                                    longitude: 39.283458),
                              );

                              //Navigate to OrderSummary and pass the order object
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrderSummary(
                                    order: order,
                                    currentStep: 2,
                                  ),
                                ),
                              );
                            }
                          },
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          label: "NEXT",
                          vertical: 13,
                          horizontal: 149,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Overlay to intercept taps when dimmed
        if (isDimmed)
          Positioned.fill(
            top: 240, // Adjust this based on where the dropdown ends
            child: GestureDetector(
              onTap: () {
                _showSelectOilTypeSnackBar("Please Select Oil Type!");
              },
              child: Container(
                color: Theme.of(context)
                    .colorScheme
                    .surface, // Transparent overlay
              ),
            ),
          ),
      ],
    );
  }
}
