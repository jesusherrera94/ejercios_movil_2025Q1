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

}