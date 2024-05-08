import 'coffee_model.dart';

class User {
  final String email;
  final String id;
  Coffee order;
  User({required this.order, required this.id, required this.email});
}
