import 'package:flutter/material.dart';
import '../models/coffee_model.dart';

class CartItem extends StatefulWidget {
  final Coffee coffee;
  final String userId;
  final String orderId;
  int count;

  CartItem({
    super.key,
    required this.coffee,
    required this.userId,
    required this.orderId,
    required this.count,
  });

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Colors.black38,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: NetworkImage(widget.coffee.image),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.coffee.title,
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              "${widget.coffee.type}  (${widget.coffee.selectedSize})",
              style: const TextStyle(fontSize: 10, color: Colors.white),
            ),
            Text(
              "\$ ${widget.coffee.price.toString()}",
            ),
          ],
        ),
      ),
    );
  }
}
