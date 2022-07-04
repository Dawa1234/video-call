import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/Customer.dart';

class CustomerData extends StatefulWidget {
  var uid;
  var email;
  var first_name;
  var last_name;

  @override
  _CustomerDataState createState() => _CustomerDataState();
}

class _CustomerDataState extends State<CustomerData> {
  var uid;
  var email;
  var first_name;
  var last_name;
  CustomerData() {
    Customer Customer_Model = Customer();
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Customer')
        .doc(user?.uid)
        .get()
        .then((value) {
      Customer_Model = Customer.fromMap(value.data());
    }).whenComplete(() {
      const CircularProgressIndicator();
      setState(() {
        this.widget.uid = Customer_Model.uid.toString();
        this.widget.email = Customer_Model.email.toString();
        this.widget.first_name = Customer_Model.first_name.toString();
        this.widget.last_name = Customer_Model.last_name.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
