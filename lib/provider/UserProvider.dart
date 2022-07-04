import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/Customer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserProvider with ChangeNotifier {
  Customer _user = Customer();

  Customer get getUser => _user;

  void refreshUser() async {
    _user = await getUserDetails();
    notifyListeners();
  }

  Future<Customer> getUserDetails() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("Customer")
        .doc(currentUser?.uid)
        .get();

    return Customer.fromMap(documentSnapshot.data());
  }
}
