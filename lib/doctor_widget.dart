import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/doctor.dart';
import 'package:demo/screens/doctor_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class DoctorWidget extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  final Doctor? doctor;
  DoctorHistoryModel doctorHistoryModel = DoctorHistoryModel();

  DoctorWidget(this.doctor, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorProfileScreen(doctor: doctor)));
        print('User Uid.......');
        print(user?.uid);

        doctorHistoryModel.id = doctor!.id;
        doctorHistoryModel.name = doctor!.name;
        doctorHistoryModel.description = doctor!.description;
        doctorHistoryModel.image = doctor!.image;
        doctorHistoryModel.orgName = doctor!.orgName;
        doctorHistoryModel.qualification = doctor!.qualification;
        doctorHistoryModel.schedule = doctor!.schedule;

        await FirebaseFirestore.instance
            .collection("${user?.uid}")
            .doc(doctor!.id)
            .set(doctorHistoryModel.toMap());
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        width: double.infinity,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              child: Image.network(
                doctor!.image,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    doctor!.id,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: doctor!.orgName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: ' (' + doctor!.qualification + ')',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        size: 16,
                      ),
                      Text(
                        doctor!.schedule,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 100.0,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          print('Clicked');
                          await follower();
                          await following();
                        },
                        child: const Text('Follow'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future following() async {
    print('Reached');
    FirebaseFirestore.instance
        .collection('Following')
        .doc(user?.uid)
        .collection('Follows')
        .doc(doctor!.id)
        .set({});
  }

  Future follower() async {
    print('Reached');
    FirebaseFirestore.instance
        .collection('Follower')
        .doc(doctor!.id)
        .collection('Followers')
        .doc(user!.uid)
        .set({});
  }
}
