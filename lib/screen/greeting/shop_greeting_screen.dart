import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salford_spa_flutter_app/constants.dart';
import 'package:salford_spa_flutter_app/screen/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopGreetingScreen extends StatefulWidget {
  final String serviceSelected;
  final String time;
  final String name;
  final String location;
  final String services;
  final List<String> servicesList;
  final String image;
  const ShopGreetingScreen({Key? key,
    required this.serviceSelected,
    required this.time,
    required this.services,
    required this.location,
    required this.name,
    required this.image,
    required this.servicesList,
  }) : super(key: key);

  @override
  _ShopGreetingScreenState createState() => _ShopGreetingScreenState();
}

class _ShopGreetingScreenState extends State<ShopGreetingScreen> {

  String name = '' , email = '',uid = '',userType = '';
  String text = '';
  int current = 0;
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('userType') != null) {
      setState(() {
        userType = prefs.getString('userType')!;
        email = prefs.getString('userEmail')!;
        uid = prefs.getString('userId')!;
      });
      FirebaseFirestore.instance.collection(userType).where('uid',isEqualTo: _auth.currentUser!.uid.toString()).get().then((value) {
        setState(() {
          name = value.docs[0]['name'];
          email = value.docs[0]['email'];
        });
      });


    } else {
      print('Starting usertype');
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      isLoading = false;
    });
    getData();
    print('we are in 1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: primaryColor,
        //resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.08,
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                    width: size.width * 0.5,
                    child: Image.asset(
                      'assets/images/logo.jpeg',
                      fit: BoxFit.cover,
                      height: size.height * 0.1,
                      width: size.width * 0.5,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                    //height: size.height*0.,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Color(0xFFC4C3AF),
                        borderRadius: BorderRadius.circular(150)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Container(
                          height: size.height * 0.1,
                          width: size.width * 0.9,
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 0,
                                ),
                                child: Center(
                                    child: Text(
                                      'Hi,\nI\'m $name',
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.center,
                                    )),
                              ),
                              Positioned(
                                top: size.height * 0.02,
                                left: size.width * 0.09,
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: SizedBox(
                                          height: 40,
                                          width: 80,
                                          child: Image.asset(
                                            'assets/images/flowers.png',
                                            fit: BoxFit.scaleDown,
                                            height: 40,
                                            width: 80,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: size.height*0.01,
                        // ),
                        Container(
                          width: size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(
                                    'assets/images/location.png',
                                    fit: BoxFit.scaleDown,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 8,
                                ),
                                child: Text(
                                  widget.location,
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 0),
                          child: Container(
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 0,
                                    ),
                                    child: Text(
                                      'Appointment has been booked',
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: size.width * 0.5,
                                      decoration: BoxDecoration(
                                        color: authButtonColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                // height: size.height*0.3,
                                               // width: size.width * 0.1,

                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: size.height * 0.03,
                                                    ),
                                                    Text(
                                                      'Name',
                                                      style: TextStyle(
                                                          color: textColor,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w600),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      height: size.height * 0.02,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          name,
                                                          style: TextStyle(
                                                              color: textColor,
                                                              fontSize: 10,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                          textAlign: TextAlign.center,
                                                        ),

                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: size.height * 0.03,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // height: size.height*0.3,
                                               // width: size.width * 0.27,

                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: size.height * 0.03,
                                                    ),
                                                    Text(
                                                      'Service & Price',
                                                      style: TextStyle(
                                                          color: textColor,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w600),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      height: size.height * 0.01,
                                                    ),
                                                    Column(
                                                      // mainAxisAlignment:
                                                      // MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Text(
                                                          widget.serviceSelected,
                                                          style: TextStyle(
                                                              color: textColor,
                                                              fontSize: 10,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.center,
                                                        ),
                                                        // Text(
                                                        //   '20 OMR',
                                                        //   style: TextStyle(
                                                        //       color: textColor,
                                                        //       fontSize: 10,
                                                        //       fontWeight:
                                                        //       FontWeight.w500),
                                                        //   textAlign: TextAlign.center,
                                                        // ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: size.height * 0.03,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // height: size.height*0.3,
                                               // width: size.width * 0.1,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: size.height * 0.03,
                                                    ),
                                                    Text(
                                                      'Time',
                                                      style: TextStyle(
                                                          color: textColor,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w600),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    SizedBox(
                                                      height: size.height * 0.02,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Text(
                                                          widget.time.toString(),
                                                          style: TextStyle(
                                                              color: textColor,
                                                              fontSize: 10,
                                                              fontWeight:
                                                              FontWeight.w500),
                                                          textAlign: TextAlign.center,
                                                        ),

                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: size.height * 0.03,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Thanks for choosing',
                                            style: TextStyle(
                                                color: textColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: size.height*0.01,
                                          ),
                                          Row(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                             mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                               // width: size.width*0.25,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [

                                                    Padding(
                                                      padding:  EdgeInsets.only(left: 8),
                                                      child: CircleAvatar(
                                                        backgroundColor: authButtonColor,
                                                        backgroundImage: AssetImage(widget.image),
                                                        radius: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Container(
                                                // color: Colors.green,
                                                //  width: size.width*0.2,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [

                                                      Padding(
                                                        padding:  EdgeInsets.only(left: 8,),
                                                        child: Text(widget.name, style: TextStyle(

                                                            color: textColor, fontSize: 12,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),


                                                    ],)),
                                            ],
                                          ),
                                          SizedBox(
                                            height: size.height*0.01,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Text('Please be on time!',
                                      style: TextStyle(
                                        color: textColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Container(
                                    height: size.height * 0.06,
                                    width: size.width * 0.6,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0, 4),
                                            blurRadius: 5.0)
                                      ],
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(60.0),
                                            ),
                                          ),
                                          minimumSize: MaterialStateProperty.all(
                                              Size(size.width * 0.8, 50)),
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              authButtonColor),
                                          // elevation: MaterialStateProperty.all(3),
                                          shadowColor: MaterialStateProperty.all(
                                              Colors.transparent),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => HomeScreen()),
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text('Exit',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500)),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: Image.asset(
                                                'assets/images/outlineFlower.jpeg',
                                                fit: BoxFit.scaleDown,
                                                height: 40,
                                                width: 40,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.01,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
