List<String> selectedSize = [
  "S",
  "M",
  "L",
];

class Coffee {
  final String type;
  final double price;
  String selectedSize;
  final String image;
  final String title;
  final String description;
  final double rate;

  Coffee({
    required this.description,
    required this.title,
    required this.price,
    required this.rate,
    required this.type,
    required this.image,
    this.selectedSize = 'S', // default selectedSize to 'S'
  });

  // Static method to construct a Coffee instance from a Map
  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      description: json['description'] as String,
      image: json['image'] as String,
      price: json['price'] as double,
      rate: json['rate'] as double,
      selectedSize:
          json['selectedSize'] as String? ?? 'S', // default to 'S' if null
      title: json['title'] as String,
      type: json['type'] as String,
    );
  }

  // Method to convert a Coffee instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'image': image,
      'price': price,
      'rate': rate,
      'selectedSize': selectedSize,
      'title': title,
      'type': type,
    };
  }
}
