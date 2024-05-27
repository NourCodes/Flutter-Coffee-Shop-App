import 'package:coffee_shop_app/utilities/counter_box.dart';
import 'package:flutter/material.dart';
import '../models/coffee_model.dart';
import '../services/data.dart';

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
  int max = 10;
  int min = 0;

  Future incrementCounter() async {
    if (widget.count + 1 <= max) {
      setState(() {
        widget.count += 1;
      });
    }
    await Data().changeCount(
      widget.count,
      widget.userId,
      widget.coffee,
      widget.orderId,
    );
  }

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
        trailing: CounterBox(
          cof: widget.coffee,
          color: Theme.of(context).primaryColorLight,
          selectedValue: widget.count,
          increment: () => incrementCounter(),
          decrement: () {},
          initialValue: widget.count,
          minValue: min,
          maxValue: max,
        ),
      ),
    );
  }
}
