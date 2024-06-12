import 'package:coffee_shop_app/utilities/receipt.dart';
import 'package:flutter/material.dart';

class DeliveryProgressScreen extends StatelessWidget {
  const DeliveryProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delivery in Progress"),
        backgroundColor: Colors.transparent,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Receipt(),
          ),
        ],
      ),
    );
  }
}
