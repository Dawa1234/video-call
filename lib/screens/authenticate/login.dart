// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/Customer.dart';
import 'package:demo/provider/google_sign_in.dart';
import 'package:demo/screens/authenticate/register.dart';
import 'package:demo/screens/doctor_list_screen.dart';
import 'package:demo/screens/home/HomepageDoctor.dart';
import 'package:demo/screens/home/SearchPage.dart';
import 'package:demo/Video%20Call/call.dart';
import 'package:demo/screens/home/dashboard.dart';
import 'package:demo/screens/home/RedirectingPage.dart';
import 'package:demo/screens/home/search.dart';
import 'package:demo/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  AuthServices _auth = AuthServices();
  Customer customer = Customer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
        actions: [
          FlatButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Register()));
              },
              icon: Icon(Icons.person),
              label: Text('SIGN UP'))
        ],
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // -------------------------- Email Field--------------------------

              TextFormField(
                controller: username,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.pink),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.pink),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email Field is empty!';
                  } else if (value.contains('@') == false) {
                    return 'Please enter email in a proper format!';
                  } else {
                    return null;
                  }
                },
              ),

              //  -------------------------- Height Gap --------------------------
              const SizedBox(height: 20.0),

              //  -------------------------- Password Field --------------------------
              TextFormField(
                controller: password,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.pink),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0, color: Colors.pink),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password Field is empty!';
                  } else if (value.length < 6) {
                    return 'Password cannot be less than 6 digit!';
                  } else {
                    return null;
                  }
                },
              ),

              //  -------------------------- Height Gap --------------------------
              const SizedBox(height: 20.0),

// ------------------------ Normal Login  ---------------------------------
              Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton.icon(
                      color: Colors.pink,
                      onPressed: () async {
                        if (formkey.currentState!.validate()) {
                          print('Username.......');
                          print(username.text);
                          print('Password.......');
                          print(password.text);
                          dynamic result =
                              await _auth.SignInWithEmailAndPassword(
                                  username.text, password.text);
                          if (result != null) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => Search()),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                "Logged In!",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.green,
                              duration: Duration(
                                seconds: 3,
                              ),
                              dismissDirection: DismissDirection.down,
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                "Invalid email or password! Login Failed!",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(
                                seconds: 3,
                              ),
                              dismissDirection: DismissDirection.down,
                            ));
                          }
                        } else {
                          print('Bad Form');
                        }
                      },
                      icon: const Icon(Icons.login),
                      label: const Text('SIGN IN')),

// ------------------------ Login With Google ---------------------------------
                  FlatButton.icon(
                      color: Colors.grey[800],
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin().then((data) => {
                              print('Document data.........'),
                              postDetails(data),
                            });
                      },
                      icon: const FaIcon(FontAwesomeIcons.google,
                          color: Colors.red),
                      label: const Text(
                        "Login with google",
                        style: TextStyle(color: Colors.white),
                      )),

// ------------------------ Log OUT ---------------------------------
                  Center(
                    child: FlatButton.icon(
                        color: Colors.pink,
                        onPressed: () async {
                          _auth.SignOut();
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.logout();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        icon: const Icon(Icons.logout),
                        label: const Text('Log Out')),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future postDetails(data) async {
    await FirebaseFirestore.instance
        .collection('Customer')
        .doc(data.uid)
        .get()
        .then((value) => {
              print('Value ID........'),
              print(value.exists),
              if (value.exists)
                {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const RedirectingPage()))
                }
              else
                {
                  customer.first_name = data.displayName.toString(),
                  customer.email = data.email.toString(),
                  customer.isGoogleUser = true,
                  customer.isNormalUser = false,
                  customer.isFormCompleted = false,
                  FirebaseFirestore.instance
                      .collection('Customer')
                      .doc(data.uid)
                      .set(customer.toMap())
                      .whenComplete(() => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const RedirectingPage()))),
                },
            });
  }
}
