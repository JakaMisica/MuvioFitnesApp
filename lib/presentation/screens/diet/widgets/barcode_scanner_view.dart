import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../data/models/diet_models.dart';

class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({super.key});

  @override
  State<BarcodeScannerView> createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  bool _isProcessing = false;

  Future<void> _onBarcodeDetected(BarcodeCapture capture) async {
    if (_isProcessing) return;
    final barcode = capture.barcodes.firstOrNull?.rawValue;
    if (barcode == null) return;

    setState(() => _isProcessing = true);

    try {
      final response = await http.get(
        Uri.parse(
          'https://world.openfoodfacts.org/api/v2/product/$barcode.json',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 1) {
          final product = data['product'];
          final nutriments = product['nutriments'] ?? {};

          final food = FoodItem()
            ..name = product['product_name'] ?? 'Unknown Food'
            ..brand = product['brands']
            ..calories = (nutriments['energy-kcal_100g'] ?? 0).toDouble()
            ..protein = (nutriments['proteins_100g'] ?? 0).toDouble()
            ..carbs = (nutriments['carbohydrates_100g'] ?? 0).toDouble()
            ..fat = (nutriments['fat_100g'] ?? 0).toDouble()
            ..fiber = (nutriments['fiber_100g'] ?? 0).toDouble()
            ..sugars = (nutriments['sugars_100g'] ?? 0).toDouble()
            ..satFat = (nutriments['saturated-fat_100g'] ?? 0).toDouble()
            ..cholesterol =
                (nutriments['cholesterol_100g'] ?? 0).toDouble() *
                1000 // OFF stores in grams usually if it exists, need to check units but mg is common for label.
            ..sodium = (nutriments['sodium_100g'] ?? 0).toDouble() * 1000
            ..calcium = (nutriments['calcium_100g'] ?? 0).toDouble() * 1000
            ..iron = (nutriments['iron_100g'] ?? 0).toDouble() * 1000
            ..potassium = (nutriments['potassium_100g'] ?? 0).toDouble() * 1000;

          if (mounted) {
            Navigator.pop(context, food);
          }
          return;
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product not found in database')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error scanning: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Scan Food Barcode',
          style: TextStyle(color: Colors.cyanAccent),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          MobileScanner(onDetect: _onBarcodeDetected),
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.cyanAccent),
              ),
            ),
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.cyanAccent, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
