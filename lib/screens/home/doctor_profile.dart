import 'package:division/division.dart';
import 'package:flutter/material.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({Key? key}) : super(key: key);

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  int _value = -1;
  String? AreYou;
  List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];

  String? selectedItem = 'Item1';
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Positioned(
                  right: 0,
                  child: Image.asset('assets/images/Vector.png',
                      fit: BoxFit.cover, width: screen.width),
                ),
                Txt(
                  'Personal Data',
                  style: TxtStyle()
                    ..fontSize(24)
                    ..padding(left: 16)
                    ..fontFamily('quicksand')
                    ..fontWeight(FontWeight.bold)
                    ..textColor(const Color(0xff76B5C5)),
                ),
                Txt(
                  'Profile Picture',
                  style: TxtStyle()
                    ..fontSize(20)
                    ..fontFamily('quicksand')
                    ..padding(left: 16)
                    ..fontWeight(FontWeight.bold)
                    ..textColor(Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: Image.asset(
                          "assets/images/profile.png",
                          height: 70,
                          width: 70,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print('Select Picture');
                        },
                        child: Parent(
                            style: ParentStyle()
                              ..height(48)
                              ..elevation(3, color: Colors.black12)
                              ..width(170)
                              ..borderRadius(all: 16)
                              ..background.color(const Color(0xff76B5C5)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.upload,
                                  size: 22,
                                  color: Colors.white,
                                ),
                                Txt(
                                  'Select Picture',
                                  style: TxtStyle()
                                    ..fontSize(18)
                                    ..margin(left: 8)
                                    ..alignmentContent.centerRight()
                                    ..fontFamily('quicksand')
                                    ..fontWeight(FontWeight.bold)
                                    ..textColor(Colors.white),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Txt(
                  'Are you ____________ ?',
                  style: TxtStyle()
                    ..fontSize(18)
                    ..fontFamily('quicksand')
                    ..padding(left: 16)
                    ..textColor(Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 0,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value as int;
                                AreYou = 'Medical Officer';
                                print(AreYou);
                              });
                            },
                            activeColor: const Color(0xff76B5C5),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Medical Officer'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: _value,
                            onChanged: (value) {
                              setState(() {
                                _value = value as int;
                                AreYou = 'Medical Manager';
                                print(AreYou);
                              });
                            },
                            activeColor: const Color(0xff76B5C5),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Medical Manager'),
                        ],
                      ),
                      Txt(
                        'Your Specialization',
                        style: TxtStyle()
                          ..fontSize(16)
                          ..fontFamily('quicksand')
                          ..fontWeight(FontWeight.bold)
                          ..textColor(Colors.black),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Parent(
                        style: ParentStyle()
                          ..height(42)
                          ..elevation(3, color: Colors.black12)
                          ..width(screen.width)
                          ..margin(left: 16, right: 16)
                          ..borderRadius(all: 16)
                          ..background.color(const Color(0xff76B5C5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButton<String>(
                                value: selectedItem,
                                items: items
                                    .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                              // backgroundColor: Colors.red,
                                              color: Colors.black,
                                              fontFamily: 'quicksand',
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal),
                                        )))
                                    .toList(),
                                onChanged: (item) => setState(() {
                                      selectedItem = item;
                                      print(selectedItem);
                                    }),
                                style: const TextStyle(

                                    // fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Txt(
                        'Upload Your identification ',
                        style: TxtStyle()
                          ..fontSize(16)
                          ..fontFamily('quicksand')
                          ..fontWeight(FontWeight.bold)
                          ..textColor(Colors.black),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Txt(
                            'No File Selected',
                            style: TxtStyle()
                              ..fontSize(16)
                              ..fontFamily('quicksand')
                              ..fontWeight(FontWeight.bold)
                              ..textColor(Colors.grey)
                              ..margin(bottom: 10),
                          ),
                          InkWell(
                            onTap: () {
                              print('Choose Your Identifiction');
                            },
                            child: Parent(
                              style: ParentStyle()
                                ..height(40)
                                ..elevation(3, color: Colors.black12)
                                ..width(160)
                                ..margin(bottom: 12, right: 8)
                                ..alignment.centerRight(true)
                                ..borderRadius(all: 16)
                                ..background.color(const Color(0xff76B5C5)),
                              child: Txt(
                                'Choose a file',
                                style: TxtStyle()
                                  ..fontSize(16)
                                  ..padding(left: 30, top: 8)
                                  ..fontFamily('quicksand')
                                  ..fontWeight(FontWeight.bold)
                                  ..textColor(Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Txt(
                        'Upload Your Doctor license ',
                        style: TxtStyle()
                          ..fontSize(16)
                          ..fontFamily('quicksand')
                          ..fontWeight(FontWeight.bold)
                          ..textColor(Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Txt(
                            'No File Selected',
                            style: TxtStyle()
                              ..fontSize(16)
                              ..fontFamily('quicksand')
                              ..fontWeight(FontWeight.bold)
                              ..textColor(Colors.grey)
                              ..margin(bottom: 5),
                          ),
                          InkWell(
                            onTap: () {
                              print('Choose Doctor Liscense');
                            },
                            child: Parent(
                              style: ParentStyle()
                                ..height(40)
                                ..elevation(3, color: Colors.black12)
                                ..width(160)
                                ..margin(right: 8)
                                ..alignment.centerRight(true)
                                ..borderRadius(all: 16)
                                ..background.color(const Color(0xff76B5C5)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Txt(
                                      'Choose a file',
                                      style: TxtStyle()
                                        ..fontSize(16)
                                        ..padding(
                                          left: 26,
                                        )
                                        ..fontFamily('quicksand')
                                        ..fontWeight(FontWeight.bold)
                                        ..textColor(Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Parent(
                          style: ParentStyle()
                            ..height(44)
                            ..elevation(3, color: Colors.black12)
                            ..width(136)
                            ..margin(top: 8)
                            ..borderRadius(all: 16)
                            ..background.color(const Color(0xffEFB492)),
                          child: InkWell(
                            onTap: () {
                              print('Submit');
                            },
                            child: Txt(
                              'Submit',
                              style: TxtStyle()
                                ..fontSize(16)
                                ..alignmentContent.center(true)
                                ..fontFamily('quicksand')
                                ..fontWeight(FontWeight.bold)
                                ..textColor(Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
