import 'package:flutter/material.dart';
import 'package:green_oil/primary_button.dart';
import 'package:green_oil/recycle_oil_screen/location_card.dart';
import 'package:green_oil/recycle_oil_screen/oil_type_dropdown.dart';
import 'package:green_oil/recycle_oil_screen/quantity_selector.dart';
import 'package:green_oil/recycle_oil_screen/select_pickup_date.dart';
import 'package:green_oil/recycle_oil_screen/step_progress_indicator.dart';

class RecycleOil extends StatefulWidget {
  const RecycleOil({super.key, required this.currentStep});

  final int currentStep;

  @override
  State<RecycleOil> createState() => _RecycleOilState();
}

class _RecycleOilState extends State<RecycleOil> {
  final int totalSteps = 3;
  int currentStep = 0; // Set initial step
  double quantity = 50.0; // Initial quantity

  final TextEditingController _quantityController = TextEditingController();
  String? _selectedOilType;

  final List<String> stepTitles = [
    "Oil Type",
    "Quantity & Pickup",
    "Order Summary"
  ];

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
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
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
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        } else if (newQuantity > 500) {
          quantity = 500;
          _quantityController.text = "500";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Maximum quantity is 500"),
              backgroundColor: Colors.red,
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

  void _showSelectOilTypeSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            "Please Select Oil Type!",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
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
            centerTitle: true,
            title: Text(
              stepTitles[currentStep],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 27,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: StepProgressIndicator(
                  currentStep: currentStep,
                  totalSteps: totalSteps,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
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
                                fontSize: 21,
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
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
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),

                          //LOCATION CARD
                          LocationCard(),
                          SizedBox(height: 40),

                          // Select Pickup Date
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 35),
                            child: Text(
                              "Select Pickup Date",
                              style: TextStyle(
                                fontSize: 21,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: SelectPickupDate(),
                          ),
                          SizedBox(height: 50),

                          // Next Button
                          PrimaryButton(
                            onPressed: () {
                              if (_selectedOilType == null) {
                                _showSelectOilTypeSnackBar();
                              } else {
                                // Handle the "Next" button logic when oil type is selected
                              }
                            },
                            backgroundColor: Theme.of(context).primaryColor,
                            label: "NEXT",
                            vertical: 13,
                            horizontal: 149,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Overlay to intercept taps when dimmed
        if (isDimmed)
          Positioned.fill(
            top: 240, // Adjust this based on where the dropdown ends
            child: GestureDetector(
              onTap: _showSelectOilTypeSnackBar,
              child: Container(
                color: const Color.fromARGB(0, 0, 0, 0), // Transparent overlay
              ),
            ),
          ),
      ],
    );
  }
}
