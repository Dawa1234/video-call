import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/screens/home/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  User? user = FirebaseAuth.instance.currentUser;
  String imageURL1 = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageURL1 = "${user?.photoURL}";
    print('ImageURL...........');
    print(imageURL1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Page'),
      ),
      body: Center(
        child: Column(
          children: [
            imageURL1 == ""
                ? const CircleAvatar(
                    radius: 40.0,
                    child: CircularProgressIndicator(),
                  )
                : CircleAvatar(
                    radius: 40.0,
                    backgroundImage: NetworkImage("${user?.photoURL}"),
                  ),
            FlatButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('Customer')
                      .doc(user?.uid)
                      .update({
                    'imageURL1': imageURL1,
                    'isFormCompleted': true,
                  }).whenComplete(() {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Dashboard()));
                  });
                },
                child: const Text('Submit')),
          ],
        ),
      ),
    );
  }
}
