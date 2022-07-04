import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPageDoc extends StatefulWidget {
  const LoginPageDoc({Key? key}) : super(key: key);

  @override
  State<LoginPageDoc> createState() => _LoginPageDocState();
}

class _LoginPageDocState extends State<LoginPageDoc> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();

    final TapGestureRecognizer _gesturesRecongnizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.of(context).pushNamed('/register_doctor');
      };
    final screen = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/auth");
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SizedBox(
        height: screen.height,
        width: screen.width,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/ic_login_bg.png",
              width: screen.width,
              height: screen.height / 3,
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 0,
              child: Image.asset("assets/images/ic_login_bottom.png",
                  width: screen.width, fit: BoxFit.fill),
            ),
            Positioned(
                top: screen.height / 3 - 80,
                height: screen.height - screen.height / 3 + 80,
                width: screen.width,
                child: Container(
                  padding: const EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sign In",
                            style: TextStyle(color: Colors.red, fontSize: 30),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "E-mail",
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email should not be empty";
                              } else if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return "Please! Enter a valid Email";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              emailController.text = value!;
                            },
                            decoration: const InputDecoration(
                              fillColor: Colors.black12,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            style: const TextStyle(
                                fontSize: 16,
                                height: 0.8,
                                color: Colors.black54),
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Password",
                            style: themeData.textTheme.bodyText2
                                ?.copyWith(color: Colors.red, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password should not be empty";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              passwordController.text = value!;
                            },
                            obscureText: true,
                            decoration: const InputDecoration(
                              fillColor: Colors.black12,
                              filled: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            style: const TextStyle(
                                fontSize: 16,
                                height: 0.8,
                                color: Colors.black54),
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                                text: "Forgot your password? ",
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 16),
                                children: [
                                  TextSpan(
                                      text: "Click Here",
                                      style: const TextStyle(color: Colors.red),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => {})
                                ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: MaterialButton(
                              onPressed: () {},
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              minWidth: screen.width / 2,
                              height: 50,
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Sign In with Google'),
                              Center(
                                  child: SizedBox(
                                width: 40.0,
                                height: 40.0,
                                child: Image.asset('assets/images/google.png'),
                              )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, "/register_doctor");
                              },
                              child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                      children: [
                                    const TextSpan(
                                        text: "Don't have account? "),
                                    TextSpan(
                                        text: "Sign Up",
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                        recognizer: _gesturesRecongnizer)
                                  ])),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
