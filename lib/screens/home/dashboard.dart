import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/provider/google_sign_in.dart';
import 'package:demo/screens/authenticate/login.dart';
import 'package:demo/services/Customer_data.dart';
import 'package:demo/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:demo/models/Customer_detail.dart';
import 'package:provider/provider.dart';

import '../../models/Customer.dart';

//  ------------------------------ Dashboard ------------------------------
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final AuthServices _authServices = AuthServices();
  User? user = FirebaseAuth.instance.currentUser;

  Customer loginUserModel = Customer();

  @override
  void initState() {
    super.initState();
    print('Google Photo URL......');
    print(user?.photoURL);
    Alldata();
    getFollowers();
    getFollowing();
  }

  getFollowers() {
    FirebaseFirestore.instance
        .collection('Follower')
        .doc(user?.uid)
        .collection('Followers')
        .get()
        .then((value) {
      for (var element in value.docs) {
        print('Elements');
        print(element.id);
        setState(() {
          follower += 1;
        });
      }
      print('follower......');
      print(follower);
    });
  }

  getFollowing() {
    FirebaseFirestore.instance
        .collection('Following')
        .doc(user?.uid)
        .collection('Follows')
        .get()
        .then((value) {
      for (var element in value.docs) {
        print('Elements');
        print(element.id);
        setState(() {
          following += 1;
        });
      }
      print('followong......');
      print(following);
    });
  }

  Alldata() {
    FirebaseFirestore.instance
        .collection('Customer')
        .doc(user?.uid)
        .get()
        .then((value) {
      this.loginUserModel = Customer.fromMap(value.data());
    }).whenComplete(() {
      setState(() {
        if (loginUserModel.isGoogleUser!) {
          email = loginUserModel.email.toString();
          id = loginUserModel.uid.toString();
          imageURL = user!.photoURL.toString();
        }
        if (loginUserModel.isNormalUser!) {
          email = loginUserModel.email.toString();
          id = loginUserModel.uid.toString();
          imageURL = loginUserModel.imageURL1.toString();
        }
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  late String? id;
  var email;
  String? isCustomer;
  String? imageURL = "";
  bool? isGoogleUser;
  int follower = 0;
  int following = 0;

  @override
  Widget build(BuildContext context) {
    // Future<dynamic> getData() async {
    //   await customer
    //       .doc(user?.uid)
    //       .get()
    //       .then((doc) => {this.data = doc.data()})
    //       .catchError((error) =>
    //           {print("Error on get data from User"), print(error.toString())});
    // }

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // for (dynamic details in detail) Text('${details}'),
                // Card(
                //   child: Padding(
                //     padding: const EdgeInsets.all(15.0),
                //     child: Text('$id'),
                //   ),
                // ),
                // const SizedBox(height: 20.0),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('${user?.uid}'),
                  ),
                ),
                const SizedBox(height: 20.0),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('${user?.email}'),
                  ),
                ),
                const SizedBox(height: 20.0),
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.green[100],
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    child: imageURL == ""
                        ? const CircularProgressIndicator()
                        : Image.network("$imageURL"),
                  ),
                ),
                // CircleAvatar(
                //   radius: 30.0,
                //   backgroundColor: Colors.green,
                //   child: ClipRRect(
                //     child: Image.network("${user?.photoURL}"),
                //   ),
                // ),
                const SizedBox(height: 20.0),
                // Card(
                //   child: Padding(
                //     padding: const EdgeInsets.all(15.0),
                //     child: Text('Customer : $isCustomer'),
                //   ),
                // ),
                // const SizedBox(height: 20.0),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('${user?.emailVerified}'),
                  ),
                ),
                const SizedBox(height: 20.0),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('$imageURL'),
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: FlatButton.icon(
                      color: Colors.pink,
                      onPressed: () async {
                        _authServices.SignOut();
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.logout();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const Login()));
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('Log Out')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
