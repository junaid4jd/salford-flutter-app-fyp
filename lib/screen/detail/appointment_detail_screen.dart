import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salford_spa_flutter_app/constants.dart';
import 'package:salford_spa_flutter_app/screen/greeting/shop_greeting_screen.dart';
import 'package:salford_spa_flutter_app/screen/payment/payment_method_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppointmentDetailScreen extends StatefulWidget {
  final String serviceSelected;
  final String time;
  final String name;
  final String location;
  final String services;
  final List<String> servicesList;
  final String image;
  const AppointmentDetailScreen({Key? key,
  required this.serviceSelected,
  required this.time,
    required this.services,
    required this.location,
    required this.name,
    required this.image,
    required this.servicesList,
  }) : super(key: key);

  @override
  _AppointmentDetailScreenState createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {

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
    if(widget.servicesList[0].toString() == 'admin') {
      setState(() {
        name = 'admin';
      });
    } else {
      getData();
    }

    print('we are in 1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height*0.035,
                ),

                Container(
                  width: size.width,
                  child: Row(children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: IconButton(onPressed: (){
                        Navigator.of(context).pop();

                      }, icon: Icon(Icons.arrow_back_ios, size: 18,color: buttonColor,)),
                    )

                  ],),
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
                  height: size.height * 0.01,
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
                                    fontSize: 18,
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
                                      padding: const EdgeInsets.only(left: 10),
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
                              borderRadius: BorderRadius.circular(60)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: size.width * 0.25,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 8),
                                            child: CircleAvatar(
                                              backgroundColor: authButtonColor,
                                              backgroundImage: AssetImage(
                                                  widget.image),
                                              radius: 40,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        // color: Colors.green,
                                        width: size.width * 0.48,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: size.height * 0.02,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 0,
                                              ),
                                              child: Text(
                                                widget.name,
                                                style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 0),
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
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 0,
                                  ),
                                  child: Text(
                                    'Appointment details :',
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      // height: size.height*0.3,
                                      width: size.width * 0.35,
                                      decoration: BoxDecoration(
                                        color: authButtonColor,
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          Text(
                                            'Service & Price',
                                            style: TextStyle(
                                                color: textColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                widget.serviceSelected,
                                                style: TextStyle(
                                                    color: textColor,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                textAlign: TextAlign.center,
                                              ),
                                              // Text(
                                              //   '20 OMR',
                                              //   style: TextStyle(
                                              //       color: textColor,
                                              //       fontSize: 10,
                                              //       fontWeight:
                                              //           FontWeight.w500),
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
                                      width: size.width * 0.35,
                                      decoration: BoxDecoration(
                                        color: authButtonColor,
                                        borderRadius: BorderRadius.circular(60),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          Text(
                                            'Time',
                                            style: TextStyle(
                                                color: textColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          Text(
                                              widget.time,
                                            style: TextStyle(
                                                color: textColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                widget.services == 'detail' ? Container() :
                                isLoading ? CircularProgressIndicator(
                                  color: buttonColor,
                                  strokeWidth: 2
                                  ,
                                ) :
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
                                        // setState(() {
                                        //   isLoading = true;
                                        // });
                                        //
                                        // FirebaseFirestore.instance.collection('Appointments').doc().set({
                                        //   'name': name,
                                        //   'uid': _auth.currentUser!.uid.toString(),
                                        //   'email': email,
                                        //   'salonName': widget.name,
                                        //   'salonLocation': widget.location,
                                        //   'salonImage': widget.image,
                                        //   'time': widget.time,
                                        //   'service': widget.serviceSelected,
                                        //   'status': 'Pending',
                                        // }).then((value) {
                                        //
                                        //   setState(() {
                                        //     isLoading = false;
                                        //   });
                                        //
                                        //
                                        //
                                        //
                                        // });

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => PaymentMethodScreen(

                                            name: widget.name,
                                            servicesList: widget.servicesList,
                                            services: widget.services,
                                            location: widget.location,
                                            image: widget.image,
                                            serviceSelected: widget.serviceSelected,
                                            time: widget.time,

                                          )),
                                        );

                                        },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Confirm',
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
                        height: size.height * 0.08,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
