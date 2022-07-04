import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/Customer.dart';
// import 'package:demo/models/DoctorModel.dart';
import 'package:demo/screens/authenticate/login.dart';
import 'package:demo/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController first_name = TextEditingController();
  final TextEditingController last_name = TextEditingController();
  // Form
  final formkey = GlobalKey<FormState>();

  // Firebase instance
  FirebaseAuth _authenticate = FirebaseAuth.instance;

  // Firestore database instance
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Authentication file
  AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Page"),
        centerTitle: true,
        actions: [
          FlatButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Login()));
              },
              icon: Icon(Icons.person),
              label: Text('SIGN IN'))
        ],
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // -------------------------- FirstName Field--------------------------

                TextFormField(
                  controller: first_name,
                  decoration: InputDecoration(
                    hintText: 'First Name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.pink),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.pink),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'First name is empty!';
                    } else {
                      return null;
                    }
                  },
                ),

                //  -------------------------- Height Gap --------------------------
                SizedBox(height: 20.0),
                // -------------------------- Email Field--------------------------

                TextFormField(
                  controller: last_name,
                  decoration: InputDecoration(
                    hintText: 'Last Name',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.pink),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.pink),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Last Name is empty!';
                    } else {
                      return null;
                    }
                  },
                ),

                //  -------------------------- Height Gap --------------------------
                SizedBox(height: 20.0),
                // -------------------------- Email Field--------------------------

                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
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
                SizedBox(height: 20.0),

                //  -------------------------- Password Field --------------------------
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton.icon(
                        color: Colors.pink,
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            Future result =
                                await _auth.RegisterWithEmailAndPassword(
                                        email.text, password.text)
                                    .then((value) => (postDetails()));

                            print(result);
                            if (result != null) {
                              print('Registered Successfully');
                              first_name.clear();
                              last_name.clear();
                              email.clear();
                              password.clear();
                            } else {
                              print('Register Process Fail');
                            }
                          } else {
                            print('Bad Form');
                          }
                        },
                        icon: Icon(Icons.login),
                        label: Text('REGISTER')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future postDetails() async {
    try {
      DoctorModel doctor = DoctorModel();
      User? user = _authenticate.currentUser;

      doctor.uid = user?.uid;
      doctor.first_name = first_name.text;
      doctor.last_name = last_name.text;
      doctor.email = email.text;
      doctor.isNormalUser = true;
      doctor.isGoogleUser = false;
      doctor.isDoctor = true;

      return await firebaseFirestore
          .collection('doctor')
          .doc(user?.uid)
          .set(doctor.toMap());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
