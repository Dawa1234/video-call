import 'package:demo/screens/authenticate/login.dart';
import 'package:demo/screens/authenticate/register.dart';
import 'package:demo/screens/doctor_list_screen.dart';
import 'package:demo/screens/home/HomepageDoctor.dart';
import 'package:demo/screens/home/HomepageDoctor.dart';
import 'package:demo/screens/home/RedirectingPage.dart';
import 'package:demo/screens/home/SearchPage.dart';
import 'package:demo/Video%20Call/call.dart';
import 'package:demo/screens/home/dashboard.dart';
import 'package:demo/screens/home/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authprovider extends StatelessWidget {
  const Authprovider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          } else if (snapshot.hasData) {
            return const Search();
            // return const Call();
          } else {
            return const Login();
          }
        },
      ),
    );
  }
}
