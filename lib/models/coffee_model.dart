List<String> selectedSize = [
  "S",
  "M",
  "L",
];

class Coffee {
  final String type;
  final double price;
  String selectedSize;
  String uid;
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
    this.uid = "",
  });
}
