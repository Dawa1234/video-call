import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/doctor_widget.dart';
import 'package:demo/models/Customer.dart';
import 'package:demo/models/doctor.dart';
import 'package:demo/screens/home/doctor_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/data.dart';

class DoctorListScreen extends StatefulWidget {
  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  Customer customer = Customer();
  demo doctor = demo();
  final CollectionReference data =
      FirebaseFirestore.instance.collection('Customer');
  @override
  void initState() {
    super.initState();
    // print('Printed......');

    data.get().then((value) => {
          value.docs.forEach((element) {
            customer = Customer.fromMap(element.data());
            setState(() {
              String? id;
              if (customer.uid != null) {
                id = customer.uid;
              }
              // print(id);
              String? name = customer.first_name;
              String? image = customer.imageURL1;
              this.doctor.doctorList.add(Doctor(id!, name!, image!, "orgName",
                  "qualification", "123123", "description"));
            });
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.amber));
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 16),
              child: Text(
                "Available Doctors",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, top: 20, right: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.green,
              ),
              width: double.infinity,
              height: 150,
              child: Stack(
                children: [
                  Positioned(
                      left: 0,
                      bottom: 10,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => DoctorHistoryScreen()));
                        },
                        child: const Text(
                          "Doctors You've checked",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                      )),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Image.asset(
                      "assets/images/profile.png",
                      height: 130,
                    ),
                  ),
                  const Positioned(
                    top: 0,
                    left: 0,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Looking for your desired\nSpecialist Doctors?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: doctor.doctorList.length,
                itemBuilder: (BuildContext context, index) {
                  return DoctorWidget(doctor.doctorList[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
