import 'package:flutter/material.dart';
import '../models/coffee_model.dart';

class CounterBox extends StatelessWidget {
  final Function() decrement;
  final Function() increment;
  final Coffee cof;
  final int minValue;
  final int maxValue;
  final int selectedValue;
  final Color? color;
  final TextStyle? textStyle;
  final int initialValue;
  final double buttonSizeWidth, buttonSizeHeight;

  const CounterBox({
    super.key,
    required this.cof,
    required this.increment,
    required this.decrement,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.selectedValue,
    this.color,
    this.textStyle,
    this.buttonSizeWidth = 30,
    this.buttonSizeHeight = 25,
  })  : assert(maxValue > minValue),
        assert(initialValue >= minValue && initialValue <= maxValue);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => decrement(),
            child: SizedBox(
              width: 50,
              height: 30,
              child: Container(
                decoration: ShapeDecoration(
                  color: color,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                ),
                child: const Center(
                  child: Text(
                    '-',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              selectedValue.toString(),
              style: textStyle == null
                  ? textStyle
                  : const TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => increment(),
            child: SizedBox(
              width: 50,
              height: 30,
              child: Container(
                decoration: ShapeDecoration(
                  color: color,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                ),
                child: const Center(
                  child: Text(
                    '+',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
