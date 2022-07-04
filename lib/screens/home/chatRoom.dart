import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/Customer.dart';
import 'package:demo/models/chatRoom.dart';
import 'package:demo/models/doctor.dart';
import 'package:demo/models/messegeModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ChatRoom extends StatefulWidget {
  String username;
  final targetUser;

  final ChatRoomModel chatroom;

  ChatRoom(
      {required this.targetUser,
      required this.chatroom,
      required this.username,
      Key? key})
      : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  var uuid = Uuid();
  bool isDoctor = false;
  Customer customer = Customer();
  DoctorModel doctor = DoctorModel();
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  final CollectionReference CustomerUserdata =
      FirebaseFirestore.instance.collection('Customer');
  final CollectionReference DoctorUserdata =
      FirebaseFirestore.instance.collection('doctor');

  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('photo............................');
    print(widget.targetUser.imageURL1.toString());
    UserData();
  }

  UserData() async {
    await CustomerUserdata.doc(firebaseUser?.uid).get().then((value) {
      if (value.exists) {
        customer = Customer.fromMap(value.data());
        print("customer uid................................");
        print(customer.uid);
        setState(() {});
      }
    });
    await DoctorUserdata.doc(firebaseUser?.uid).get().then((value) {
      if (value.exists) {
        doctor = DoctorModel.fromMap(value.data());
        setState(() {
          isDoctor = true;
        });
      }
    });
  }

  void sendMessage() async {
    String message = messageController.text.trim();

    if (messageController.text != "") {
      MessageModel newMessage = MessageModel(
        messageId: uuid.v1(),
        sender: isDoctor ? doctor.uid : customer.uid,
        createdOn: DateTime.now(),
        text: message,
        seen: false,
      );

      FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(widget.chatroom.chatroomId)
          .collection('messages')
          .doc(newMessage.messageId)
          .set(newMessage.toMap());

      widget.chatroom.lastMessage = message;
      print(widget.chatroom.lastMessage);

      FirebaseFirestore.instance
          .collection('chatrooms')
          .doc(widget.chatroom.chatroomId)
          .set(widget.chatroom.toMap());
      log("Message Sent");
    }
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            widget.targetUser.imageURL1.toString() != ""
                ? CircleAvatar(
                    backgroundColor: Colors.green[100],
                    backgroundImage:
                        NetworkImage(widget.targetUser.imageURL1.toString()),
                  )
                : CircleAvatar(
                    backgroundColor: Colors.green[100],
                    backgroundImage: AssetImage("assets/images/google.png"),
                  ),
            Text(widget.targetUser.first_name.toString())
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("chatrooms")
                      .doc(widget.chatroom.chatroomId)
                      .collection('messages')
                      .orderBy("createdOn", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        QuerySnapshot dataSnapshot =
                            snapshot.data as QuerySnapshot;
                        // print(dataSnapshot.docs.isNotEmpty);

                        if (dataSnapshot.docs.isNotEmpty) {
                          return ListView.builder(
                              reverse: true,
                              itemCount: dataSnapshot.docs.length,
                              itemBuilder: (context, index) {
                                MessageModel currentMessage =
                                    MessageModel.fromMap(
                                        dataSnapshot.docs[index].data()
                                            as Map<String, dynamic>);
                                return Row(
                                  mainAxisAlignment: isDoctor
                                      ? (currentMessage.sender == doctor.uid)
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start
                                      : (currentMessage.sender == customer.uid)
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        margin:
                                            EdgeInsets.symmetric(vertical: 2),
                                        decoration: BoxDecoration(
                                            color: isDoctor
                                                ? (currentMessage.sender ==
                                                        doctor.uid)
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .secondary
                                                    : Colors.grey
                                                : (currentMessage.sender ==
                                                        customer.uid)
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .secondary
                                                    : Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                            currentMessage.text.toString())),
                                  ],
                                );
                              });
                        } else {
                          return const Center(child: Text('Say Hi!'));
                        }
                      } else if (snapshot.hasError) {
                        return Center(
                            child:
                                Text('Please Check yout Internet Connection.'));
                      } else {
                        return Center(
                          child: Text("Say Hi"),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )),
              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  children: [
                    Flexible(
                        child: TextField(
                      controller: messageController,
                      maxLines: null,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Enter message"),
                    )),
                    IconButton(
                        onPressed: () {
                          sendMessage();
                        },
                        icon: Icon(
                          Icons.send,
                          color: Colors.blue,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
