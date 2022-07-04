import 'package:demo/provider/UserProvider.dart';
import 'package:demo/provider/google_sign_in.dart';
import 'package:demo/screens/doctor_dashboard.dart';
import 'package:demo/screens/doctor_list_screen.dart';
import 'package:demo/screens/history.dart';
import 'package:demo/screens/home/doctor_profile.dart';
import 'package:demo/screens/home/logincheck.dart';
import 'package:demo/screens/patientDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:demo/screens/authenticate/login.dart';
import 'package:provider/provider.dart';
import 'screens/authenticate/doctir_login.dart';
import 'screens/patient_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
        ],
        child: MaterialApp(
          routes: {
            "/": (context) => const Authprovider(),
            // "/": (context) => userHistory(),
          },
          // routes: {
          //   "/": (context) => ProfileScreen(),
          //   "/report": (context) => ReportScreen(),
          // }
        ),
      );

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Login(),
  //   );
  // }
}
