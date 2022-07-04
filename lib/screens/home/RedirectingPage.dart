import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/Customer.dart';
import 'package:demo/screens/authenticate/login.dart';
import 'package:demo/screens/doctor_list_screen.dart';
import 'package:demo/screens/home/SearchPage.dart';
import 'package:demo/screens/home/dashboard.dart';
import 'package:demo/screens/home/form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RedirectingPage extends StatefulWidget {
  const RedirectingPage({Key? key}) : super(key: key);

  @override
  _RedirectingPageState createState() => _RedirectingPageState();
}

class _RedirectingPageState extends State<RedirectingPage> {
  User? user = FirebaseAuth.instance.currentUser;
  Customer customer = Customer();

  bool? isFormCompleted;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('Customer')
        .doc(user?.uid)
        .get()
        .then((value) {
      customer = Customer.fromMap(value.data());
    }).whenComplete(() {
      setState(() {
        isFormCompleted = customer.isFormCompleted;
        print("isFormCompleted.........");
        print(isFormCompleted);
      });
    });
  }

  route() {
    if (isFormCompleted == true) {
      return const Messenger();
      // return DoctorListScreen();
    } else {
      const CircularProgressIndicator();
      return const FormPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return route();
  }
}
