import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomerDetail {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference result =
      FirebaseFirestore.instance.collection('Customer');
  String? uid;
  String? email;
  String? firstname;
  String? lastname;

  var data;
  Future<void> getData() async {
    try {
      final User? user = _auth.currentUser;
      dynamic details = await result
          .doc(user?.uid)
          .get()
          .then((doc) => {data = doc.data()})
          .catchError((error) =>
              {print("Error on get data from User"), print(error.toString())});

      this.uid = data["uid"];
      this.email = data["email"];
      this.firstname = data["first_name"];
      this.lastname = data["last_name"];
    } catch (e) {
      print(e.toString());
    }
  }

  CustomerDetail({this.uid, this.email, this.firstname, this.lastname});
}
