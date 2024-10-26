import 'package:flutter/material.dart';
import 'package:green_oil/primary_button.dart';
import 'package:green_oil/home_screen/new_location.dart';

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

  // Method to increment the quantity
  void _incrementQuantity() {
    setState(() {
      if (quantity < 500) {
        quantity += 1;
      }
    });
  }

  // Method to decrement the quantity
  void _decrementQuantity() {
    setState(() {
      if (quantity > 10) {
        quantity -= 1;
      }
    });
  }

  void _openAddExpense(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NewLocation(),
    );
  }

  final List<String> _oilTypes = [
    'Cooking Oil',
    'Motor Oil',
    'Lubricating Oil'
  ];

  String? _selectedOilType;

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              // Custom Dropdown using PopupMenuButton
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
                      if (newValue == 'Cooking Oil') {
                        currentStep =
                            1; // Update current step when "Cooking Oil" is selected
                      } else {
                        currentStep = 0; // Reset step for other options
                      }
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return _oilTypes.map((String oilType) {
                      bool isDisabled =
                          ['Motor Oil', 'Lubricating Oil'].contains(oilType);
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
                  constraints: BoxConstraints(
                    minWidth: 350,
                  ),
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

              // Additional widgets displayed when currentStep is 1
              if (currentStep == 1) ...[
                Text(
                  'User Choose Cooking Oil, now we put the widgets back here & make them available',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                PrimaryButton(
                  onPressed: () {},
                  backgroundColor: Theme.of(context).disabledColor,
                  label: "NEXT",
                  vertical: 13,
                  horizontal: 149,
                ),
              ] else ...[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    "Add Your Estimated Oil Qunatity (L)",
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
                          color: Colors.black26, // Shadow color
                          blurRadius: 4, // Blur effect for the shadow
                          offset: Offset(0, 1), // Position of the shadow
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

                        // Quantity Display
                        Text(
                          quantity.toStringAsFixed(
                              2), // Display quantity with two decimal places
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w500,
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
                SizedBox(
                  height: 50,
                ),
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
                          color: Colors.black26, // Shadow color
                          blurRadius: 4, // Blur effect for the shadow
                          offset: Offset(0, 1), // Position of the shadow
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
                        SizedBox(
                          width: 230,
                          child: Expanded(
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
                        ),
                        TextButton(
                            onPressed: () {
                              _openAddExpense(context);
                            },
                            child: Text(
                              'CHANGE',
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 58, 141, 60),
                                  fontWeight: FontWeight.w700),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 250,
                ),
                PrimaryButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(
                          child: Text(
                            "Please Select Oil Type!",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors
                            .green.shade300, // Set background color to green
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(14), // Rounded edges
                        ),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 10), // Margin for floating effect
                      ),
                    );
                  },
                  backgroundColor: Theme.of(context).disabledColor,
                  label: "NEXT",
                  vertical: 13,
                  horizontal: 149,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
