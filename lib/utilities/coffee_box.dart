import 'package:flutter/material.dart';
import '../models/coffee_model.dart';

class CoffeeBox extends StatelessWidget {
  final Coffee coffee;
  final String userId;
  final Function(Coffee coffee, String size, String userId) onPressed;
  const CoffeeBox({
    super.key,
    required this.onPressed,
    required this.coffee,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black54,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    coffee.image,
                    width: 180,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        coffee.rate.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(coffee.title),
                Text(
                  coffee.type,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$ ${coffee.price}"),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                    ),
                    onPressed: () =>
                        onPressed(coffee, coffee.selectedSize, userId),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
