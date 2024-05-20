import 'package:coffee_shop_app/utilities/methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/coffee_model.dart';

class Data {
  final _firestore = FirebaseFirestore.instance;

  Future saveOrder(Coffee order, String userId, String orderId) async {
    try {
      await _firestore
          .collection("users")
          .doc(userId)
          .collection("orders")
          .doc(orderId)
          .set(order.toJson());
    } catch (e) {
      Methods().showMessage(e.toString());
    }
  }

  Future changeCount(
    int count,
    String userId,
    String orderId,
    Coffee coffee,
  ) async {
    try {
      await _firestore
          .collection("users")
          .doc(userId)
          .collection("orders")
          .doc(orderId)
          .update({"count": count});
    } catch (e) {
      Methods().showMessage(e.toString());
    }
  }

  Future removeOrder(Coffee order, String userId, String orderId) async {
    try {
      await _firestore
          .collection("users")
          .doc(userId)
          .collection("orders")
          .doc(orderId)
          .delete();
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
