import 'package:coffee_shop_app/pages/coffee_detail.dart';
import 'package:coffee_shop_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/coffee_model.dart';
import '../provider/cart_provider.dart';
import '../utilities/coffee_box.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final String orderId = const Uuid().v1();

  List<String> coffeeTypes = [
    "All",
    "Cappuccino",
    "Espresso",
    "Latte",
    "Flat White"
  ];
  List<Coffee> filteredCoffee = [];
  late String selectedFilter;
  final TextEditingController _searchController = TextEditingController();
  final currentUserId = Auth().currentUser!.uid;

  @override
  void initState() {
    selectedFilter = coffeeTypes[0];
    _searchController.clear();
    filteredCoffee = Provider.of<CartProvider>(context, listen: false).coff;
    super.initState();
  }

  addItem(
    Coffee coffee,
    String size,
    String userId,
  ) {
    Provider.of<CartProvider>(context, listen: false).addItems(
      Coffee(
        description: coffee.description,
        title: coffee.title,
        price: coffee.price,
        rate: coffee.rate,
        type: coffee.type,
        image: coffee.image,
        selectedSize: size,
        id: orderId,
        count: coffee.count,
      ),
      userId,
      orderId,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, value, child) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Find the Best \nCoffee for you",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                onChanged: (searchText) {
                  filteredCoffee = value
                      .getCoffeeList()
                      .where(
                        (element) =>
                            element.title.toLowerCase() ==
                            searchText.toLowerCase(),
                      )
                      .toList();
                  setState(() {});
                },
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  contentPadding: const EdgeInsets.all(0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  hintText: "Find your Coffee",
                  fillColor: Colors.grey,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                itemCount: coffeeTypes.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final selectedF = coffeeTypes[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedFilter = selectedF;
                          if (selectedF == "All") {
                            filteredCoffee = value.getCoffeeList();
                          } else {
                            filteredCoffee = value
                                .getCoffeeList()
                                .where((element) =>
                                    element.title == coffeeTypes[index])
                                .toList();
                          }
                        });
                      },
                      child: Text(
                        coffeeTypes[index],
                        style: TextStyle(
                          color: selectedF == selectedFilter
                              ? Colors.blue
                              : Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: filteredCoffee.isEmpty
                  ? const Center(
                      child: Text(
                      "Type Not Found",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ))
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredCoffee.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CoffeeDetails(
                                  addItem: (coffee, size, userId) =>
                                      addItem(coffee, size, userId),
                                  coff: filteredCoffee[index],
                                  size: selectedSize,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CoffeeBox(
                              userId: currentUserId,
                              coffee: filteredCoffee[index],
                              onPressed: (coffee, size, userId) =>
                                  addItem(coffee, size, userId),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
