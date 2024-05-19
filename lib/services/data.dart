import 'package:coffee_shop_app/utilities/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/coffee_model.dart';

class Data {
  final _firestore = FirebaseFirestore.instance;
  saveOrder(Coffee order, String size, String userId) {
    try {
      _firestore
          .collection("users")
          .doc(userId)
          .collection("orders")
          .add(order.toJson());
    } catch (e) {
      Methods().showMessage(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> order(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("orders")
        .snapshots();
  }
}
