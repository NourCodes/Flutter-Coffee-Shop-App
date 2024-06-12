import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/provider/cart_provider.dart';
import 'package:coffee_shop_app/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../models/coffee_model.dart';
import '../services/data.dart';

class Receipt extends StatefulWidget {
  const Receipt({super.key});

  @override
  State<Receipt> createState() => _ReceiptState();
}

class _ReceiptState extends State<Receipt> {
  final currentUserId = Auth().currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: Data().order(currentUserId),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // while waiting for data, show a loading indicator
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // if an error occurs, display an error message
            return Text(
              'Error: ${snapshot.error}',
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            // if there are no documents in the snapshot, display a message
            return const Center(
              child: Text(
                "No Cart Items Yet!",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          } else {
            List<Coffee> cartItems = snapshot.data!.docs.map((doc) {
              return Coffee.fromJson(doc.data() as Map<String, dynamic>);
            }).toList();
            // if data is available, display it
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        Coffee cart = cartItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 50,
                            right: 20,
                            bottom: 20,
                            left: 20,
                          ),
                          child: Column(
                            children: [
                              const Text("Thank you for your order!"),
                              const SizedBox(
                                height: 25,
                              ),
                              Container(
                                padding: const EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  Provider.of<CartProvider>(context).getReceipt(
                                    Auth().currentUser!.uid,
                                    cartItems,
                                    cart.date,
                                    context,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Estimated delivery time is: 4:10 PM",
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ],
            );
          }
        });
  }
}
