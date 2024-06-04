import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/pages/checkout_page.dart';
import 'package:coffee_shop_app/provider/cart_provider.dart';
import 'package:coffee_shop_app/utilities/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/coffee_model.dart';
import '../services/auth.dart';
import '../services/data.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final currentUserId = Auth().currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                return Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            Coffee cart = cartItems[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CartItem(
                                orderId: cart.id,
                                count: cart.count,
                                userId: currentUserId,
                                coffee: cart,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 35, right: 25, left: 25, bottom: 10),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).focusColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Total Price",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "\$ ${Provider.of<CartProvider>(context).getTotal(currentUserId, cartItems).toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      10,
                                    ),
                                  ),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const CheckoutScreen(),
                                      ),
                                    );
                                  },
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Go to Checkout",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
