import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/doctor_widget.dart';
import 'package:demo/models/Customer.dart';
import 'package:demo/models/doctor.dart';
import 'package:demo/provider/UserProvider.dart';
import 'package:demo/provider/google_sign_in.dart';
import 'package:demo/screens/authenticate/login.dart';
import 'package:demo/screens/callscreens/pick/pickup_layout.dart';
import 'package:demo/utils/call_utilities.dart';
import 'package:demo/utils/permissions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference data =
      FirebaseFirestore.instance.collection("Customer");
  Customer customer = Customer();
  List<Customer> AllCustomer = [];
  List<Customer> SearchedCustomer = [];
  TextEditingController _textEditingController = TextEditingController();

  Customer? sender;

  UserProvider userProvider = UserProvider();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
    });
    getCustomers();
    getCurrentUserData();
  }

  // getUserDetail() async {
  //   await data.doc(user?.uid).get().then((value) {
  //     setState(() {
  //       _user = Customer.fromMap(value.data());
  //     });
  //   });
  // }

  getCustomers() async {
    await FirebaseFirestore.instance.collection("Customer").get().then((value) {
      value.docs.forEach((element) {
        customer = Customer.fromMap(element.data());
        AllCustomer.add(Customer(
            uid: customer.uid,
            imageURL1: customer.imageURL1,
            first_name: customer.first_name));
        // print(AllCustomer.length);
      });
    });
  }

  getCurrentUserData() async {
    await FirebaseFirestore.instance
        .collection("Customer")
        .doc(user?.uid)
        .get()
        .then((value) {
      setState(() {
        sender = Customer.fromMap(value.data());
        print('User Name............................');
        print(sender!.first_name);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
        scaffold: Scaffold(
      appBar: AppBar(
          actions: [
            FlatButton.icon(
                color: Colors.pink,
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                icon: const Icon(Icons.logout),
                label: const Text('Log Out')),
          ],
          title: TextField(
            decoration: InputDecoration(hintText: 'Search'),
            controller: _textEditingController,
            onChanged: (value) {
              setState(() {
                SearchedCustomer = AllCustomer.where((element) => element
                    .first_name!
                    .toLowerCase()
                    .contains(value.toString().toLowerCase())).toList();
              });
              print(SearchedCustomer.length);
            },
          )),
      body: _textEditingController.text.isEmpty || SearchedCustomer.length == 0
          ? Center(child: Text('No Results'))
          : ListView.builder(
              itemCount: SearchedCustomer.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    print(SearchedCustomer[index].uid);
                    await Permissions.cameraAndMicrophonePermissionsGranted()
                        ? CallUtils.dial(
                            sender!, SearchedCustomer[index], context)
                        : {};
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Card(
                      color: Colors.blueGrey[50],
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.green[100],
                              radius: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                    SearchedCustomer[index].imageURL1!),
                              ),
                            ),
                            Text(SearchedCustomer[index].first_name!)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
    ));
  }
}
