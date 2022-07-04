import 'dart:math';

import 'package:demo/models/Customer.dart';
import 'package:demo/models/callModel.dart';
import 'package:demo/models/user.dart';
import 'package:demo/resources/call_methods.dart';
import 'package:demo/screens/callscreens/call_screen.dart';
import 'package:flutter/material.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial(Customer from, Customer to, context) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.first_name,
      callerPic: from.imageURL1,
      receiverId: to.uid,
      receiverName: to.first_name,
      receiverPic: to.imageURL1,
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeCall(call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(call: call),
          ));
    }
  }
}
