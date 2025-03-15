import 'package:cloud_firestore/cloud_firestore.dart';

class Db {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String,dynamic>?> getUserData(String uid) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db.collection('users').where('uid', isEqualTo: uid).get();
      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> userData = querySnapshot.docs.first.data();
        return userData;
      }
      return null;
    } catch (e) {
      print('error ocurred calling Firebase!: $e');
      return null;
    }
  }

  Future<dynamic> saveOrder(Map<String, dynamic> order) async {
    try {
     final orderData = await _db.collection('orders').add(order);
      final orderSnapshot = await orderData.get();
      print('Order saved with id: ${orderSnapshot.toString()}');
      return orderSnapshot;
    } catch (e) {
      print('error ocurred calling Firebase!: $e');
      return null;
    }
  }

  void setListenerToOrder({required Function(Map<String, dynamic>) onOrderReceived}) {
    _db.collection('orders').snapshots().listen((snapshot) {
      for (var doc in snapshot.docChanges) {
        if (doc.type == DocumentChangeType.modified) {
          print('Order received: ${doc.doc.id}');
          final order = {
            'orderId': doc.doc.id,
            ...doc.doc.data() as Map<String, dynamic>,
          };
          onOrderReceived(order);
        }
      }
    });
  }

  Future<List<Map<String, dynamic>>> getOrders(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db.collection('orders').where('userId', isEqualTo: userId).get();
      List<Map<String, dynamic>> orders = querySnapshot.docs.map((doc) => {
        'orderId': doc.id,
        ...doc.data(),
      }).toList();
      print('Orders received: $orders');
      return orders;
    } catch (e) {
      print('error ocurred calling Firebase!: $e');
      return [];
    }
  }
}