import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:green_oil/auth_button.dart';
import 'package:green_oil/models/customer_info.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:green_oil/models/my_order.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({
    super.key,
    required this.order,
  });

  final MyOrder order;

  @override
  State<StatefulWidget> createState() {
    return _InvoiceScreenState();
  }
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  late Customerinfo _customerInfo;
  bool _isLoading = true; // Default loading state
  bool _loading = false; // Default loading state

  @override
  void initState() {
    super.initState();
    _getCustomerInfo();
  }

  void _getCustomerInfo() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        final databaseRef = FirebaseDatabase.instance
            .ref('requests/$userId/${widget.order.orderID}');
        final snapshot = await databaseRef.get();

        if (snapshot.exists) {
          // Parse the snapshot data
          final data = Map<String, dynamic>.from(snapshot.value as Map);

          final providerData =
              Map<String, dynamic>.from(data['Provider Info'] as Map);

          // Create the Customerinfo instance
          final customerInfo = Customerinfo(
            companyName: providerData['Name'].toString(),
            customerName: providerData['Customer Name'].toString(),
            contactEamil: providerData['Email'].toString(),
            seekerEmail: providerData['Seeker Email'].toString(),
          );

          // Update state with the fetched data
          setState(() {
            _customerInfo = customerInfo;
            _isLoading = false;
          });
        } else {
          // Handle snapshot not existing
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (error) {
      // Handle errors
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "An error occurred while fetching customer info: $error",
            ),
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_isLoading) {
      content = Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 167.5,
          ),
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      content = Card(
        elevation: 2,
        color: Theme.of(context).colorScheme.onPrimary,
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDetailItem('Oil Type', getOrderType(widget.order), context),
              const Divider(),
              buildDetailItem(
                  'Customer Name', _customerInfo.customerName, context),
              const Divider(),
              buildDetailItem(
                  'Company Name', _customerInfo.companyName, context),
              const Divider(),
              buildDetailItem(
                'Estimated Quantity',
                '${widget.order.oilQuantity.toStringAsFixed(1)}L',
                context,
              ),
              const Divider(),
              buildDetailItem(
                'Oil Price',
                '${widget.order.oilPrice.toStringAsFixed(1)} SR',
                context,
              ),
              const Divider(),
              buildDetailItem(
                'Customer Email',
                _customerInfo.contactEamil,
                context,
              ),
              const Divider(),
              buildDetailItem(
                'Seeker Email',
                _customerInfo.seekerEmail,
                context,
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const SizedBox(height: 38),
            Text(
              "Invoice",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 28,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 30,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Card(
              elevation: 2,
              color: Theme.of(context).colorScheme.onPrimary,
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildDetailItem(
                        'Invoice ID',
                        widget.order.orderID
                            .substring(widget.order.orderID.length - 10),
                        context),
                    const Divider(),
                    buildDetailItem(
                      'Date of issue',
                      DateFormat('MMMM d, y').format(DateTime.now()),
                      context,
                    ),
                    const Divider(),
                    buildDetailItem(
                        'Contact Details', 'greenOil@gmail.com', context),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order Details',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
            content,
            const SizedBox(height: 38),
            AuthButton(
              onPressed: _loading
                  ? () {}
                  : () async {
                      await _generateInvoicePDF(context);
                    },
              vertical: _loading ? 15 : 13,
              horizontal: _loading ? 165 : 89.7,
              child: _loading
                  ? SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                  : Text(
                      'SHARE INVOICE',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDetailItem(String label, String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _generateInvoicePDF(BuildContext context) async {
    final pdf = pw.Document();

    setState(() {
      _loading = true;
    });

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Text(
                'Invoice',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              _buildPDFSection(
                'Invoice ID',
                widget.order.orderID.substring(
                  widget.order.orderID.length - 10,
                ),
              ),
              _buildPDFSection(
                'Date of issue',
                DateFormat('MMMM d, y').format(DateTime.now()),
              ),
              _buildPDFSection('Contact Details', 'greenOil@gmail.com'),
              pw.SizedBox(height: 20),
              pw.Text('Order Details',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),
              _buildPDFSection('Oil Type', getOrderType(widget.order)),
              _buildPDFSection('Customer Name', 'Raef Shah'),
              _buildPDFSection('Company Name', 'ALBAIK'),
              _buildPDFSection(
                'Estimated Quantity',
                '${widget.order.oilQuantity.toStringAsFixed(1)}L',
              ),
              _buildPDFSection(
                'Oil Price',
                '${widget.order.oilPrice.toStringAsFixed(1)} SR',
              ),
              _buildPDFSection(
                'Customer Email',
                _customerInfo.contactEamil,
              ),
              _buildPDFSection(
                'Seeker Email',
                _customerInfo.seekerEmail,
              ),
            ],
          );
        },
      ),
    );
    try {
      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename: 'invoice.pdf',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to generate PDF: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false; // Stop loading
        });
      }
    }
  }

  pw.Widget _buildPDFSection(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('$label: $value', style: const pw.TextStyle(fontSize: 14)),
        pw.SizedBox(height: 4),
      ],
    );
  }
}

String getOrderType(MyOrder order) {
  if (order.oilType == OilType.cookingOil) {
    return "Cooking Oil";
  } else if (order.oilType == OilType.motorOil) {
    return "Motor Oil";
  } else if (order.oilType == OilType.lubricating) {
    return "Lubricating Oil";
  } else {
    return "ERROR";
  }
}
