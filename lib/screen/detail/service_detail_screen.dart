import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salford_spa_flutter_app/constants.dart';
import 'package:salford_spa_flutter_app/screen/detail/appointment_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceDetailScreen extends StatefulWidget {
  final String name;
  final String location;
  final String services;
  final List<String> servicesList;
  final String image;
  const ServiceDetailScreen({Key? key,
    required this.services,
    required this.location,
    required this.name,
    required this.image,
    required this.servicesList,
  }) : super(key: key);


  @override
  _ServiceDetailScreenState createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {

  String name = '' , email = '',uid = '',userType = '',selectedService = '', selectedTime = '';
  String text = '';
  int current = 0;
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
    getData();
    setState(() {
      selectedService = '';
      selectedTime = '';
    });
    print('we are in 3');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: primaryColor,
      //resizeToAvoidBottomInset: false,
      body:   SingleChildScrollView(
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
                  height: size.height*0.1,
                  width: size.width*0.5,
                  child: Image.asset('assets/images/logo.jpeg', fit: BoxFit.cover,
                    height: size.height*0.1,
                    width: size.width*0.5,
                  ),
                ),

                SizedBox(
                  height: size.height*0.01,
                ),

                Container(
                  //height: size.height*0.,
                  width: size.width*0.9,
                  decoration: BoxDecoration(
                      color: Color(0xFFC4C3AF),
                      borderRadius: BorderRadius.circular(150)
                  ),
                  child: Column(
                    children: [

                      SizedBox(
                        height: size.height*0.015,
                      ),
                      Container(
                        height: size.height*0.1,
                        width: size.width*0.9,
                        child: Stack(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: 0,),
                              child: Center(
                                  child: Text('Hi,\nI\'m $name', style: TextStyle(

                                      color: textColor, fontSize: 18,fontWeight: FontWeight.w400),textAlign: TextAlign.center,)
                              ),
                            ),

                            Positioned(
                              top: size.height*0.02,
                              left: size.width*0.09,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: SizedBox(
                                        height: 40,
                                        width: 80,
                                        child: Image.asset('assets/images/flowers.png', fit: BoxFit.scaleDown,
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
                        width: size.width*0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: Image.asset('assets/images/location.png', fit: BoxFit.scaleDown,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                            ),

                            Padding(
                              padding:  EdgeInsets.only(left: 8,),
                              child: Text(widget.location, style: TextStyle(

                                  color: textColor, fontSize: 13,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                            ),
                          ],),
                      ),

                      SizedBox(
                        height: size.height*0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 0),
                        child: Container(
                          width: size.width*0.8,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(60)
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height*0.01,
                                ),

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: size.width*0.25,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [

                                          Padding(
                                            padding:  EdgeInsets.only(left: 8),
                                            child: CircleAvatar(
                                              backgroundColor: authButtonColor,
                                              backgroundImage: AssetImage(widget.image.toString()),
                                              radius: 40,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      // color: Colors.green,
                                        width: size.width*0.48,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: size.height*0.02,
                                            ),
                                            Padding(
                                              padding:  EdgeInsets.only(left: 0,),
                                              child: Text(widget.name.toString(), style: TextStyle(

                                                  color: textColor, fontSize: 18,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Row(children: [

                                              Padding(
                                                padding: const EdgeInsets.only(left: 0),
                                                child: SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: Image.asset('assets/images/location.png', fit: BoxFit.scaleDown,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                ),
                                              ),

                                              Padding(
                                                padding:  EdgeInsets.only(left: 8,),
                                                child: Text(widget.location.toString(), style: TextStyle(

                                                    color: textColor, fontSize: 13,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                                              ),
                                            ],),

                                            SizedBox(
                                              height: 4,
                                            ),
                                          ],
                                        ),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: size.height*0.01,
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(left: 0,),
                                  child:
                                  Text('Please choose time & service', style: TextStyle(

                                      color: textColor, fontSize: 13,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                                ),
                                SizedBox(
                                  height: size.height*0.01,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                  Container(
                                    height: size.height*0.3,
                                    width: size.width*0.35,
                                    decoration: BoxDecoration(
                                      color: authButtonColor,
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: Column(children: [
                                      SizedBox(
                                        height:size.height*0.03,
                                      ),
                                      Text('Service & Price', style: TextStyle(

                                          color: textColor, fontSize: 13,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                                      SizedBox(
                                        height:size.height*0.02,
                                      ),
                                      widget.name == 'Maldives spa' ? Column(children: [


                                        Container(
                                          decoration: BoxDecoration(
                                              color: selectedService == 'Acrylie nails\n20 OMR' ? buttonColor : Colors.transparent,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Padding(
                                            padding:  EdgeInsets.all( selectedService == 'Acrylie nails\n20 OMR'?3.0 : 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                GestureDetector(
                                                  onTap:() {
                                                    setState(() {
                                                      selectedService = 'Acrylie nails\n20 OMR';
                                                    });
                                                  },
                                                  child: Text('Acrylie nails',
                                                    style: TextStyle(
                                                        color:
                                                        selectedService == 'Acrylie nails\n20 OMR' ? Colors.white :

                                                        textColor, fontSize: 10,fontWeight:
                                                    selectedService == 'Acrylie nails\n20 OMR' ? FontWeight.bold :
                                                    FontWeight.w500),textAlign: TextAlign.center,),
                                                ),
                                                Text('20 OMR', style: TextStyle(

                                                    color:  selectedService == 'Acrylie nails\n20 OMR' ? Colors.white : textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                              ],
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height:size.height*0.04,
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(left: 4,right: 4),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: selectedService == 'Special mani & padi\n35 OMR' ? buttonColor : Colors.transparent,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Padding(
                                              padding:  EdgeInsets.all( selectedService == 'Special mani & padi\n35 OMR' ?3.0 : 0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  SizedBox(
                                                    width: size.width*0.18,
                                                    child: GestureDetector(
                                                      onTap:() {
                                                        setState(() {
                                                          selectedService ='Special mani & padi\n35 OMR';
                                                        });
                                                      },
                                                      child: Text('Special mani & padi',
                                                        style: TextStyle(
                                                          color:
                                                          selectedService == 'Special mani & padi\n35 OMR' ? Colors.white :
                                                          textColor, fontSize: 10,fontWeight:
                                                        selectedService == 'Special mani & padi\n35 OMR' ? FontWeight.bold :
                                                        FontWeight.w500,),textAlign: TextAlign.center,maxLines: 2,),
                                                    ),
                                                  ),
                                                  Text('35 OMR', style: TextStyle(

                                                      color:  selectedService == 'Special mani & padi\n35 OMR' ? Colors.white : textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(
                                          height:size.height*0.04,
                                        ),

                                        Container(
                                          decoration: BoxDecoration(
                                              color: selectedService == 'Normal Extension\n15 OMR' ? buttonColor : Colors.transparent,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Padding(
                                            padding:  EdgeInsets.all( selectedService == 'Normal Extension\n15 OMR' ?3.0 : 0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: size.width*0.18,
                                                  child: GestureDetector(
                                                    onTap:() {
                                                      setState(() {
                                                        selectedService = 'Normal Extension\n15 OMR';
                                                      });
                                                    },
                                                    child: Text('Normal Extension',
                                                      style: TextStyle(
                                                        color: selectedService == 'Normal Extension\n15 OMR' ? Colors.white : textColor, fontSize: 10,fontWeight:
                                                      selectedService == 'Normal Extension\n15 OMR' ?  FontWeight.bold :
                                                      FontWeight.w500,),textAlign: TextAlign.center,maxLines: 2,),
                                                  ),
                                                ),
                                                Text('15 OMR', style: TextStyle(

                                                    color: selectedService == 'Normal Extension\n15 OMR' ? Colors.white : textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                              ],
                                            ),
                                          ),
                                        ),

                                      ],) :
                                      widget.name == 'Nails by Azza' ? Container(
                                        decoration: BoxDecoration(
                                            color: selectedService == 'Nail Service\n15 OMR' ? buttonColor : Colors.transparent,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Padding(
                                          padding:  EdgeInsets.all( selectedService == 'Nail Service\n15 OMR' ?3.0 : 0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap:() {
                                                  setState(() {
                                                    selectedService = 'Nail Service\n15 OMR';
                                                  });
                                                },
                                                child: Text('Nail Service',
                                                  style: TextStyle(
                                                      color:
                                                      selectedService == 'Nail Service\n15 OMR' ? Colors.white :

                                                      textColor, fontSize: 10,fontWeight:
                                                  selectedService == 'Nail Service\n15 OMR' ? FontWeight.bold :
                                                  FontWeight.w500),textAlign: TextAlign.center,),
                                              ),
                                              Text('20 OMR', style: TextStyle(

                                                  color:  selectedService == 'Nail Service\n15 OMR' ? Colors.white : textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                            ],
                                          ),
                                        ),
                                      ) :
                                      widget.name == 'Wadhha' ? Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: selectedService == 'Polish Gel Hand\n6 OMR' ? buttonColor : Colors.transparent,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Padding(
                                              padding:  EdgeInsets.all( selectedService == 'Polish Gel Hand\n6 OMR' ?3.0 : 0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap:() {
                                                      setState(() {
                                                        selectedService = 'Polish Gel Hand\n6 OMR';
                                                      });
                                                    },
                                                    child: Text('Polish Gel Hand',
                                                      style: TextStyle(
                                                          color:
                                                          selectedService == 'Polish Gel Hand\n6 OMR' ? Colors.white :

                                                          textColor, fontSize: 10,fontWeight:
                                                      selectedService == 'Polish Gel Hand\n6 OMR' ? FontWeight.bold :
                                                      FontWeight.w500),textAlign: TextAlign.center,),
                                                  ),
                                                  Text('6 OMR', style: TextStyle(

                                                      color:  selectedService == 'Polish Gel Hand\n6 OMR' ? Colors.white : textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:size.height*0.04,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: selectedService == 'Polish Gel Foot\n6 OMR' ? buttonColor : Colors.transparent,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Padding(
                                              padding:  EdgeInsets.all( selectedService == 'Polish Gel Foot\n6 OMR' ?3.0 : 0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap:() {
                                                      setState(() {
                                                        selectedService = 'Polish Gel Foot\n6 OMR';
                                                      });
                                                    },
                                                    child: Text('Polish Gel Foot',
                                                      style: TextStyle(
                                                          color:
                                                          selectedService == 'Polish Gel Foot\n6 OMR' ? Colors.white :

                                                          textColor, fontSize: 10,fontWeight:
                                                      selectedService == 'Polish Gel Foot\n6 OMR' ? FontWeight.bold :
                                                      FontWeight.w500),textAlign: TextAlign.center,),
                                                  ),
                                                  Text('6 OMR', style: TextStyle(

                                                      color:  selectedService == 'Polish Gel Foot\n6 OMR' ? Colors.white : textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:size.height*0.04,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: selectedService == 'Gel Extension\n15 OMR' ? buttonColor : Colors.transparent,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Padding(
                                              padding:  EdgeInsets.all( selectedService == 'Gel Extension\n15 OMR' ?3.0 : 0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap:() {
                                                      setState(() {
                                                        selectedService = 'Gel Extension\n15 OMR';
                                                      });
                                                    },
                                                    child: Text('Gel Extension',
                                                      style: TextStyle(
                                                          color:
                                                          selectedService == 'Gel Extension\n15 OMR' ? Colors.white :

                                                          textColor, fontSize: 10,fontWeight:
                                                      selectedService == 'Gel Extension\n15 OMR' ? FontWeight.bold :
                                                      FontWeight.w500),textAlign: TextAlign.center,),
                                                  ),
                                                  Text('15 OMR', style: TextStyle(

                                                      color:  selectedService == 'Gel Extension\n15 OMR' ? Colors.white : textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:size.height*0.04,
                                          ),

                                          Container(
                                            decoration: BoxDecoration(
                                                color: selectedService == 'Acrylie nails\n20 OMR' ? buttonColor : Colors.transparent,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Padding(
                                              padding:  EdgeInsets.all( selectedService == 'Acrylie nails\n20 OMR'?3.0 : 0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap:() {
                                                      setState(() {
                                                        selectedService = 'Acrylie nails\n20 OMR';
                                                      });
                                                    },
                                                    child: Text('Acrylie nails',
                                                      style: TextStyle(
                                                          color:
                                                          selectedService == 'Acrylie nails\n20 OMR' ? Colors.white :

                                                          textColor, fontSize: 10,fontWeight:
                                                      selectedService == 'Acrylie nails\n20 OMR' ? FontWeight.bold :
                                                      FontWeight.w500),textAlign: TextAlign.center,),
                                                  ),
                                                  Text('20 OMR', style: TextStyle(

                                                      color:  selectedService == 'Acrylie nails\n20 OMR' ? Colors.white : textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ) :
                                      widget.name == 'Melons' ? Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: selectedService == 'Normal Polish Hand\n2 OMR' ? buttonColor : Colors.transparent,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Padding(
                                              padding:  EdgeInsets.all( selectedService == 'Normal Polish Hand\n2 OMR' ?3.0 : 0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap:() {
                                                      setState(() {
                                                        selectedService = 'Normal Polish Hand\n2 OMR';
                                                      });
                                                    },
                                                    child: Text('Normal Polish Hand',
                                                      style: TextStyle(
                                                          color:
                                                          selectedService == 'Normal Polish Hand\n2 OMR' ? Colors.white :

                                                          textColor, fontSize: 10,fontWeight:
                                                      selectedService == 'Normal Polish Hand\n2 OMR' ? FontWeight.bold :
                                                      FontWeight.w500),textAlign: TextAlign.center,),
                                                  ),
                                                  Text('2 OMR', style: TextStyle(

                                                      color:  selectedService == 'Normal Polish Hand\n2 OMR' ? Colors.white : textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:size.height*0.02,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: selectedService == 'Normal Polish Foot\n2 OMR' ? buttonColor : Colors.transparent,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Padding(
                                              padding:  EdgeInsets.all( selectedService == 'Normal Polish Foot\n2 OMR' ?3.0 : 0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap:() {
                                                      setState(() {
                                                        selectedService = 'Normal Polish Foot\n2 OMR';
                                                      });
                                                    },
                                                    child: Text('Normal Polish Foot',
                                                      style: TextStyle(
                                                          color:
                                                          selectedService == 'Normal Polish Foot\n2 OMR' ? Colors.white :

                                                          textColor, fontSize: 10,fontWeight:
                                                      selectedService == 'Normal Polish Foot\n2 OMR' ? FontWeight.bold :
                                                      FontWeight.w500),textAlign: TextAlign.center,),
                                                  ),
                                                  Text('2 OMR', style: TextStyle(

                                                      color:  selectedService == 'Normal Polish Foot\n2 OMR' ? Colors.white : textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:size.height*0.02,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: selectedService == 'Gell Polish French Hand\n8 OMR' ? buttonColor : Colors.transparent,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Padding(
                                              padding:  EdgeInsets.all( selectedService == 'Gell Polish French Hand\n8 OMR' ?3.0 : 0),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap:() {
                                                      setState(() {
                                                        selectedService = 'Gell Polish French Hand\n8 OMR';
                                                      });
                                                    },
                                                    child: Text('Gell Polish French Hand',
                                                      style: TextStyle(
                                                          color:
                                                          selectedService == 'Gell Polish French Hand\n8 OMR' ? Colors.white :

                                                          textColor, fontSize: 10,fontWeight:
                                                      selectedService == 'Gell Polish French Hand\n8 OMR' ? FontWeight.bold :
                                                      FontWeight.w500),textAlign: TextAlign.center,),
                                                  ),
                                                  Text('8 OMR', style: TextStyle(

                                                      color:  selectedService == 'Gell Polish French Hand\n8 OMR' ? Colors.white : textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:size.height*0.02,
                                          ),

                                          Container(
                                            decoration: BoxDecoration(
                                                color: selectedService == 'Acrylie nails\n20 OMR' ? buttonColor : Colors.transparent,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Padding(
                                              padding:  EdgeInsets.all( selectedService == 'Acrylie nails\n20 OMR'?3.0 : 0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap:() {
                                                      setState(() {
                                                        selectedService = 'Acrylie nails\n20 OMR';
                                                      });
                                                    },
                                                    child: Text('Acrylie nails',
                                                      style: TextStyle(
                                                          color:
                                                          selectedService == 'Acrylie nails\n20 OMR' ? Colors.white :

                                                          textColor, fontSize: 10,fontWeight:
                                                      selectedService == 'Acrylie nails\n20 OMR' ? FontWeight.bold :
                                                      FontWeight.w500),textAlign: TextAlign.center,),
                                                  ),
                                                  Text('20 OMR', style: TextStyle(

                                                      color:  selectedService == 'Acrylie nails\n20 OMR' ? Colors.white : textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ) :
                                      Container()
                                      ,
                                    ],),
                                  ),
                                  Container(
                                    height: size.height*0.3,
                                    width: size.width*0.35,
                                    decoration: BoxDecoration(
                                      color: authButtonColor,
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    child: Column(children: [
                                      SizedBox(
                                        height:size.height*0.03,
                                      ),
                                      Text('Time', style: TextStyle(

                                          color: textColor, fontSize: 13,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                                      SizedBox(
                                        height:size.height*0.02,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                        setState(() {
                                          selectedTime = '10 AM';
                                        });
                                        },
                                        child: Container(
                                          child: Text('10 AM', style: TextStyle(

                                              color:
                                              selectedTime == '10 AM' ? Colors.white :
                                              textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                        ),
                                      ),

                                      SizedBox(
                                        height:size.height*0.02,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedTime = '11:15 AM';
                                          });
                                        },
                                        child: Text('11:15 AM', style: TextStyle(

                                            color:
                                            selectedTime == '11:15 AM' ? Colors.white :
                                            textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                      ),

                                      SizedBox(
                                        height:size.height*0.02,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedTime = '12:00 PM';
                                          });
                                        },
                                        child: Text('12 PM', style: TextStyle(

                                            color: selectedTime == '12:00 PM' ? Colors.white : textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                      ),

                                      SizedBox(
                                        height:size.height*0.02,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedTime = '3:40 PM';
                                          });
                                        },

                                        child: Text('3:40 PM', style: TextStyle(

                                            color: selectedTime == '3:40 PM' ? Colors.white :  textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                      ),

                                      SizedBox(
                                        height:size.height*0.02,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedTime = '5:30 PM';
                                          });
                                        },
                                        child: Text('5:30 PM', style: TextStyle(

                                            color: selectedTime == '5:30 PM' ? Colors.white : textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                      ),
                                      SizedBox(
                                        height:size.height*0.02,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedTime = '7:00 PM';
                                          });
                                        },
                                        child: Text('7:00 PM', style: TextStyle(

                                            color: selectedTime == '7:00 PM' ? Colors.white : textColor, fontSize: 10,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                      ),



                                    ],),
                                  ),


                                ],),
                                SizedBox(
                                  height: size.height*0.01,
                                ),

                                Container(
                                  height: size.height*0.06,
                                  width: size.width*0.6,

                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                                    ],
                                    borderRadius: BorderRadius.circular(60),
                                  ),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(60.0),
                                          ),
                                        ),
                                        minimumSize: MaterialStateProperty.all(Size(size.width*0.8, 50)),
                                        backgroundColor:
                                        MaterialStateProperty.all(authButtonColor),
                                        // elevation: MaterialStateProperty.all(3),
                                        shadowColor:
                                        MaterialStateProperty.all(Colors.transparent),
                                      ),

                                      onPressed: () {

                                        if(selectedService == '') {
                                          Fluttertoast.showToast(
                                              msg: "Choose Service",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }
                                        else if(selectedTime == '') {
                                          Fluttertoast.showToast(
                                              msg: "Choose Time",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: 16.0
                                          );
                                        }
                                        else {


                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => AppointmentDetailScreen(
                                              name: widget.name,
                                              servicesList: widget.servicesList,
                                              services: widget.services,
                                              location: widget.location,
                                              image: widget.image,
                                              serviceSelected: selectedService,
                                              time: selectedTime,
                                            )),
                                          );
                                        }


                                      }, child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Text('Book Appointment', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Image.asset('assets/images/outlineFlower.jpeg', fit: BoxFit.scaleDown,
                                          height: 40,
                                          width: 40,
                                        ),
                                      ),
                                    ],
                                  )),
                                ),
                                SizedBox(
                                  height: size.height*0.01,
                                ),
                              ],
                            ),
                          ),

                        ),
                      ),
                      SizedBox(
                        height: size.height*0.08,
                      ),


                    ],
                  ),

                ),


              ],),
          ),
        ),
      ),
    );
  }
}
