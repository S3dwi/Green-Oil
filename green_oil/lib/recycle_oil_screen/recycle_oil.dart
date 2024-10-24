import 'package:flutter/material.dart';
import 'package:green_oil/primary_button.dart';

class RecycleOil extends StatefulWidget {
  const RecycleOil({super.key, required this.currentStep});

  final int currentStep;

  @override
  State<RecycleOil> createState() => _RecycleOilState();
}

class _RecycleOilState extends State<RecycleOil> {
  final int totalSteps = 3;

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
        title: const Text(
          "Oil Type",
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
                              color: index <= widget.currentStep
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
                            color: index <= widget.currentStep
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
                        color: index < widget.currentStep
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
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return _oilTypes.map((String oilType) {
                      return PopupMenuItem<String>(
                        value: oilType,
                        child: Text(
                          oilType,
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }).toList();
                  },
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
                  constraints: BoxConstraints(
                    minWidth: 350, // Make sure it takes the button's width
                  ),
                  offset: Offset(-20, 50),
                  elevation: 8,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 50),
              PrimaryButton(
                onPressed: () {},
                backgroundColor: Theme.of(context).disabledColor,
                label: "NEXT",
                vertical: 13,
                horizontal: 149,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
