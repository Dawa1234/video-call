import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/Customer.dart';
import 'package:demo/models/doctor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

final List DoctorDashBoard = [
  DoctorWidgets(
    "id",
    "assets/images/ic_topDoctor.png",
    'Dr.Stordis Ben',
    'Time:9:00 AM',
  ),
  DoctorWidgets(
    "id",
    "assets/images/profile.png",
    'Dr.Bina Zen',
    'Time:9:00 AM',
  ),
  DoctorWidgets(
    "id",
    "assets/images/ic_topDoctor3.png",
    'Dr.Bina Zen',
    'Time:9:00 AM',
  ),
  DoctorWidgets(
    "id",
    "assets/images/ic_topDoctor2.png",
    'Dr.Bina Zen',
    'Time:9:00 AM',
  ),
];

class demo {
  List doctorList = [
    // Doctor(
    //   "Dr. Raju Pangeni",
    //   "assets/images/ic_topDoctor2.png",
    //   "General Medicine",
    //   "MD, Fellow in Pain",
    //   "6:00 - 9:00",
    //   "Dr. Raju Pangeni MD, FACC (July 24, 1960) is a Cardiothoracic surgeon, professor and "
    //       "Social worker. He is best known for leading the team of Nepalese surgeons that began Open-heart "
    //       "surgery in Nepal. He is considered a good manager of the public hospitals.",
    // ),
  ];
}
