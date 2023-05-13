import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salford_spa_flutter_app/constants.dart';
import 'package:salford_spa_flutter_app/screen/detail/service_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  final String name;
  final String location;
  final String services;
  final String image;
  final List<String> servicesList;
  const DetailScreen({Key? key
  ,
    required this.services,
    required this.location,
    required this.name,
    required this.image,
    required this.servicesList,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  String name = '' , email = '',uid = '',userType = '';
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
    print('we are in 2');
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
         //   height: size.height,

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
                // SizedBox(
                //   height: size.height*0.055,
                // ),
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
                            child: Text(widget.location.toString(), style: TextStyle(

                                color: textColor, fontSize: 13,fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                          ),
                        ],),
                      ),
                      SizedBox(
                        height: size.height*0.02,
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
                                                  height: 25,
                                                  width: 25,
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


                                          ],)),
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: SizedBox(
                                    height: size.height*0.2,
                                    width: size.width*0.7,
                                    child: Image.asset('assets/images/map.jpeg', fit: BoxFit.scaleDown,
                                      height: size.height*0.2,
                                      width: size.width*0.7,
                                    ),
                                  ),
                                ),

                                Container(
                                //  width: size.width*0.7,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                       // width: size.width*0.25,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [

                                            Padding(
                                              padding: const EdgeInsets.only(left: 0),
                                              child: SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Image.asset('assets/images/time.jpeg', fit: BoxFit.scaleDown,
                                                  height: 50,
                                                  width: 50,
                                                ),
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
                                                height: size.height*0.01,
                                              ),
                                              Padding(
                                                padding:  EdgeInsets.only(left: 8,),
                                                child: Text('Working days & hours', style: TextStyle(

                                                    color: textColor, fontSize: 15,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [

                                                Padding(
                                                  padding:  EdgeInsets.only(left: 0,),
                                                  child: Text('Saturday-Thursday', style: TextStyle(

                                                      color: textColor, fontSize: 13,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                                                ),
                                              ],),

                                              SizedBox(
                                                height: 4,
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [

                                                  Padding(
                                                    padding:  EdgeInsets.only(left: 0,),
                                                    child: Text('Friday Off', style: TextStyle(

                                                        color: textColor, fontSize: 13,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                                                  ),
                                                ],),

                                              SizedBox(
                                                height: 4,
                                              ),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [

                                                  Padding(
                                                    padding:  EdgeInsets.only(left: 0,),
                                                    child: Text('10 AM - 8 PM', style: TextStyle(

                                                        color: textColor, fontSize: 13,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                                                  ),
                                                ],),

                                            ],
                                          ),
                                      ),
                                    ],
                                  ),
                                ),

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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => ServiceDetailScreen(
                                            name: widget.name,
                                            servicesList: widget.servicesList,
                                            services: widget.services,
                                            location: widget.location,
                                            image: widget.image,
                                          )),
                                        );
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
