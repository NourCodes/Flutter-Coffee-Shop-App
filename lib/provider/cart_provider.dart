import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/utilities/methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import '../models/coffee_model.dart';
import '../services/data.dart';
import 'package:intl/intl.dart';

class CartProvider extends ChangeNotifier {
  // list of coffee
  List<Coffee> coff = [
    Coffee(
      price: 4.20,
      rate: 4.5,
      title: "Cappuccino",
      type: "with Oat Milk",
      image:
          'https://images.unsplash.com/photo-1468418143278-41595b1a4c89?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      description:
          "A cappuccino with oat milk is like a cozy hug in a cup! It's made with a shot of espresso and creamy oat milk, all topped off with a fluffy layer of foam. It's the perfect blend of rich coffee flavor and velvety smoothness, without any dairy. Just sip, relax, and enjoy the deliciousness!",
    ),
    Coffee(
        price: 3.14,
        rate: 4.2,
        title: "Cappuccino",
        type: "with Chocolate",
        image:
            'https://images.unsplash.com/photo-1683442032849-9788d3828053?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
        description:
            "A cappuccino with chocolate is like a comforting hug in a cup! It starts with espresso, gets a rich chocolate kick, and then gets all creamy with steamed milk. Topped with a foamy froth, it's a delicious blend of bold coffee and sweet chocolate goodness. Perfect for satisfying those cravings for something indulgent and cozy."),
    Coffee(
      price: 4.20,
      rate: 4.5,
      title: "Cappuccino",
      type: "Regular",
      image:
          'https://images.unsplash.com/photo-1468418143278-41595b1a4c89?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      description:
          "A classic cappuccino made with equal parts espresso, steamed milk, and milk foam. It has a strong, rich flavor with a velvety texture.",
    ),
    Coffee(
      price: 3.50,
      rate: 4.2,
      title: "Espresso",
      type: "Single Shot",
      image:
          'https://plus.unsplash.com/premium_photo-1669687924558-386bff1a0469?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      description:
          "A single shot of pure espresso, made by forcing hot water through finely-ground coffee beans. It has a bold, intense flavor and a rich cream on top.",
    ),
    Coffee(
      price: 4.80,
      rate: 4.7,
      title: "Latte",
      type: "Vanilla Flavored",
      image:
          'https://images.unsplash.com/photo-1542192477-a60644b01f5c?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      description:
          "A creamy latte infused with vanilla syrup, made with espresso and steamed milk. It has a smooth, sweet flavor with a hint of vanilla.",
    ),
    Coffee(
      price: 4.00,
      rate: 4.3,
      title: "Flat White",
      type: "Coconut Milk",
      image:
          'https://images.unsplash.com/photo-1620052087057-bfd8235f5874?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      description:
          "A flat white made with espresso and coconut milk, topped with a thin layer of micro foam. It has a milder flavor compared to a cappuccino, with a subtle hint of coconut.",
    ),
  ];

  // Map of items in user cart
  Map<String, List<Coffee>> cartItems = {};

  // get list of items
  List<Coffee> getCoffeeList() {
    return coff;
  }

// get cart items for a specific user
  List<Coffee> getCartItems(String userId) {
    return cartItems.containsKey(userId) ? cartItems[userId] ?? [] : [];
  }

// Add items to cart
  Future addItems(Coffee coffee, String userId, String orderId) async {
    try {
      // check if the user already exists in the cart
      if (cartItems.containsKey(userId)) {
        // if the user exists, add the coffee item to their existing list of items
        cartItems[userId]?.add(coffee);
      } else {
        cartItems[userId] = [coffee];
      }
      await Data().saveOrder(coffee, userId, orderId);
      // notify any listeners
      notifyListeners();
    } catch (e) {
      // show error message if there's an exception
      Methods().showMessage(e.toString());
    }
  }

  double getTotal(String userId, List<Coffee> cart) {
    double total = 0;
    // loop through each item in the cart
    for (int i = 0; i < cart.length; i++) {
      // for each item, add the product of its price and count to the total
      total += cart[i].price * cart[i].count;
    }
    // return the total price of all items in the cart
    return total;
  }

  // generate a receipt
  String getReceipt(String userId, List<Coffee> cart, Timestamp orderDate,
      BuildContext context) {
    final receipt = StringBuffer();
    receipt.writeln("Here is your Receipt");
    receipt.writeln();
    String date = DateFormat("yyy-MM-dd HH:mm:ss").format(orderDate.toDate());
    receipt.writeln(date);
    receipt.writeln();
    receipt.writeln("----------");

    // header line for the receipt
    String headerLine = '${'Name'.padRight(20)}Count';
    receipt.writeln(headerLine);
    receipt.writeln();

    // loop through each item in the cart
    for (int i = 0; i < cart.length; i++) {
      String title = cart[i].title;
      int count = cart[i].count;
      String formattedLine = title.padRight(28) + count.toString();
      receipt.writeln(formattedLine);
    }

    receipt.writeln("----------");
    receipt.writeln();
    receipt.writeln("Total Items: \t ${cart.length}");
    receipt.writeln("Total Price: \t \$${getTotal(userId, cart).toStringAsFixed(2)}");
    return receipt.toString();
  }

  //removing items from cart
  removeItems(Coffee coffee, String userId, String orderId) async {
    // if the user exists in the cart and the cart is not empty
    if (cartItems.containsKey(userId) && cartItems[userId]!.isNotEmpty) {
      cartItems[userId]!.remove(coffee);
      notifyListeners();
    }
  }
}
