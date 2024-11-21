import 'package:flutter/material.dart';

class TrackOrderScreen extends StatefulWidget {
  final String orderId;

  const TrackOrderScreen({super.key, required this.orderId});

  @override
  State<StatefulWidget> createState() {
    return _TrackOrderScreenState();
  }
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  int _currentStep = 1; // Default to "Order Placed" checked.

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Track Order',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: colorScheme.secondary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/images/GreenOilLogo.png',
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Order ID: ${widget.orderId}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _steps.length,
                itemBuilder: (context, index) {
                  final isCompleted = _currentStep > index;
                  final isActive = _currentStep == index + 1;

                  return GestureDetector(
                    onTap: () => _onStepTapped(index + 1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 4.0),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: isCompleted
                                    ? colorScheme.primary // Green for completed
                                    : Colors
                                        .transparent, // Transparent for incomplete
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isCompleted
                                      ? colorScheme
                                          .primary // Green for completed
                                      : Colors.grey, // Gray for incomplete
                                  width: 2.0,
                                ),
                              ),
                              child: isCompleted
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white, // White checkmark
                                    )
                                  : const SizedBox.shrink(),
                            ),
                            if (index < _steps.length - 1)
                              SizedBox(
                                height:
                                    60, // Fixed height for consistent spacing
                                child: Container(
                                  width: 2,
                                  color: isCompleted
                                      ? colorScheme.primary // Green line
                                      : Colors.grey, // Gray for incomplete
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _steps[index]['title']!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isCompleted || isActive
                                      ? colorScheme.primary
                                      : colorScheme.secondary,
                                ),
                              ),
                              Text(
                                _steps[index]['content']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isCompleted || isActive
                                      ? colorScheme.primary
                                      : Theme.of(context).disabledColor,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'BACK TO ORDER',
                style: TextStyle(color: colorScheme.onPrimary, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _onStepTapped(int step) {
    if (step == _currentStep + 1) {
      _showConfirmationDialog(step);
    }
  }

  void _showConfirmationDialog(int step) {
    showDialog(
      context: context,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        return AlertDialog(
          backgroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            'Confirm Step',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          content: Text(
            'Are you sure you want to proceed to this step?\n',
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.secondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without changing.
              },
              child: Text(
                'NOT SURE',
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.secondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentStep = step; // Move to the next step.
                });
                Navigator.pop(context); // Close the dialog.
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'CONFIRM',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  final List<Map<String, String>> _steps = [
    {
      'title': 'Order Placed',
      'content': 'Your order is being processed.',
    },
    {
      'title': 'Order Accepted',
      'content': 'Your order has been accepted by the provider.',
    },
    {
      'title': 'Pickup Scheduled',
      'content': 'Your order is scheduled for pickup on the selected date.',
    },
    {
      'title': 'Pickup Confirmed',
      'content': 'Your pickup has been confirmed.',
    },
    {
      'title': 'Order Completed',
      'content': 'Your order is complete.',
    },
  ];
}
