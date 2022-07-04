import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/callModel.dart';
import 'package:demo/provider/UserProvider.dart';
import 'package:demo/resources/call_methods.dart';
import 'package:demo/screens/callscreens/pick/pickup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final CallMethods callMethods = CallMethods();
  final User? user = FirebaseAuth.instance.currentUser;

  PickupLayout({
    Key? key,
    required this.scaffold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    print('PickUp Layout Reached');
    return (userProvider != null && userProvider.getUser != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callMethods.callStream(userProvider.getUser.uid!),
            builder: (context, snapshot) {
              print("StreamBuilder Reached");
              if (snapshot.hasData && snapshot.data != null) {
                print(
                    'SnapShot Data................................................');
                print(snapshot.data!.data());
                if (snapshot.data!.exists) {
                  Call call = Call.fromMap(
                      snapshot.data!.data() as Map<String, dynamic>);
                  print("asdasd");

                  if (!call.hasDialled!) {
                    print('Done');
                    print(call.hasDialled);
                    return PickupScreen(call: call);
                  }
                }
              }
              return scaffold;
            },
          )
        // return (user?.emailVerified == false)
        //     ? const Center(
        //         child: Text("done"),
        //       )
        : const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
