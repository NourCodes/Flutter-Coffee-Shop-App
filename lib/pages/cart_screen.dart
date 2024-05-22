import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                Coffee cart = cartItems[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(cart.image),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cart.title,
                          style: const TextStyle(fontSize: 15),
                        ),
                        Text(
                          "${cart.type}  (${cart.selectedSize})",
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        ),
                        Text(
                          "\$ ${cart.price.toString()}",
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
