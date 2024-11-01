import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_oil/primary_button.dart';
import 'package:green_oil/home_screen/new_location.dart';
import 'package:green_oil/recycle_oil_screen/custom_date_picker.dart';

class RecycleOil extends StatefulWidget {
  const RecycleOil({super.key, required this.currentStep});

  final int currentStep;

  @override
  State<RecycleOil> createState() => _RecycleOilState();
}

class _RecycleOilState extends State<RecycleOil> {
  final int totalSteps = 3;
  int currentStep = 0; // Set initial step
  double quantity = 10.0; // Initial quantity
  final TextEditingController _quantityController = TextEditingController();

  final List<String> _oilTypes = [
    'Cooking Oil',
    'Motor Oil',
    'Lubricating Oil'
  ];

  String? _selectedOilType;

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
    if (newQuantity == null || newQuantity < 10 || newQuantity > 500) {
      // Show error SnackBar if the value is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please enter a quantity between 10 and 500",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      // Reset to the last valid quantity
      _quantityController.text = quantity.toStringAsFixed(0);
    } else {
      setState(() {
        quantity = newQuantity.toDouble();
      });
    }
  }

  void _openAddExpense(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NewLocation(),
    );
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          () {
            if (currentStep == 0) {
              return "Oil Type";
            } else if (currentStep == 1) {
              return "Quantity & Pickup";
            } else if (currentStep == 2) {
              return "Order Summary";
            } else {
              return "Error in currentStep undefined value";
            }
          }(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalSteps, (index) {
                return Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: index <= currentStep
                                  ? Colors.green
                                  : Colors.grey,
                              width: 2,
                            ),
                          ),
                        ),
                        Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index <= currentStep
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    if (index < totalSteps - 1)
                      Container(
                        width: 70,
                        height: 2,
                        color: index < currentStep
                            ? Colors.green
                            : Colors.grey[300],
                      ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 40),
                  // Dropdown to choose oil type
                  Container(
                    width: 350,
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: PopupMenuButton<String>(
                      onSelected: (String newValue) {
                        setState(() {
                          _selectedOilType = newValue;
                          currentStep = newValue == 'Cooking Oil' ? 1 : 0;
                        });
                      },
                      itemBuilder: (BuildContext context) {
                        return _oilTypes.map((String oilType) {
                          bool isDisabled = ['Motor Oil', 'Lubricating Oil']
                              .contains(oilType);
                          return PopupMenuItem<String>(
                            value: oilType,
                            enabled: !isDisabled,
                            child: Text(
                              oilType,
                              style: TextStyle(
                                fontSize: 20,
                                color: isDisabled ? Colors.grey : Colors.black,
                              ),
                            ),
                          );
                        }).toList();
                      },
                      constraints: BoxConstraints(minWidth: 350),
                      offset: Offset(-20, 50),
                      elevation: 8,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedOilType ?? 'Choose Your Oil Type',
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),

                  // Editable quantity field with increment and decrement buttons
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
                  Center(
                    child: Container(
                      height: 70,
                      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 45),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Minus Button
                          IconButton(
                            onPressed: _decrementQuantity,
                            icon: Icon(Icons.remove_circle),
                            color: const Color.fromARGB(117, 158, 158, 158),
                            iconSize: 58,
                            padding: EdgeInsets.all(0),
                          ),

                          // Editable Quantity Display
                          Container(
                            width: 60,
                            child: TextField(
                              controller: _quantityController,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w500,
                              ),
                              onSubmitted:
                                  _validateQuantityInput, // Validates only on submit
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.all(0),
                              ),
                            ),
                          ),

                          // Plus Button
                          IconButton(
                            onPressed: _incrementQuantity,
                            icon: Icon(Icons.add_circle),
                            color: Colors.green,
                            iconSize: 58,
                            padding: EdgeInsets.all(0),
                          ),
                        ],
                      ),
                    ),
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
                  Center(
                    child: Container(
                      height: 75,
                      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 25),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
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
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Company Address',
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                                const Text(
                                  'Jeddah - Alrabwah 23223, Bin Khalid Alansari, Near Albaik Almarwah branch 6977',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
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
                                color: const Color.fromARGB(255, 58, 141, 60),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
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
                    child: CustomDatePicker(),
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
                    backgroundColor: Theme.of(context).disabledColor,
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
    );
  }
}
