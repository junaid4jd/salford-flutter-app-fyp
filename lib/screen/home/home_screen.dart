import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salford_spa_flutter_app/constants.dart';
import 'package:salford_spa_flutter_app/screen/appointments/appointments_screen.dart';
import 'package:salford_spa_flutter_app/screen/auth/userType/usertype_screen.dart';
import 'package:salford_spa_flutter_app/screen/detail/detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key, }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  String name = '' , email = '',uid = '',userType = '';
  String text = '';
  int current = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        //userType = prefs.getString('userType')!;
        email = prefs.getString('userEmail')!;
        uid = prefs.getString('userId')!;
      });

      FirebaseFirestore.instance.collection('Users').where('uid',isEqualTo: _auth.currentUser!.uid.toString()).get().then((value) {
        setState(() {
          name = value.docs[0]['name'];
          email = value.docs[0]['email'];
        });
      });




  }

  List<ParlorModel> _parlorList = [
    ParlorModel(
        name: 'Maldives spa', location: 'Seeb, Mabila', services: 'Padi, Mani, Massage, Hair & more', image: 'assets/images/parlor1.jpg',
      servicesList: ['Acrylie nails  20 OMR','Special mani & padi  35 OMR','Normal Extension  15 OMR']

    ),

    ParlorModel(name: 'Wadhha', location: 'Almouj Street', services: 'Polish Gel Hand & Foot, Gel Extension, Acrylic nails', image: 'assets/images/parlor3.jpg',
        servicesList: ['Nail Service  20 OMR',]
    ),

    ParlorModel(name: 'Melons', location: 'Almawalih', services: 'Normal Polish Hand & Foot, Gel Polish Hand & Feet, Nail Art Heavy', image: 'assets/images/parlor4.jpg',
        servicesList: ['Nail Service  20 OMR',]
    ),

    ParlorModel(name: 'Nails by Azza', location: 'Seeb, Mabila', services: 'Nail Service', image: 'assets/images/parlor2.png',
        servicesList: ['Nail Service  20 OMR',]
    ),

  ];

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: buttonColor,
          ),

        //  title: Text('Salford SPA',style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        drawer: Drawer(
          backgroundColor: lightButtonGreyColor, //Colors.white,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              // SizedBox(
              //   height: 20,
              // ),
              DrawerHeader(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), bottomLeft: Radius.circular(50)),
                  gradient: LinearGradient(begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0.1,
                      0.9
                    ], colors: [
                      primaryColor,
                      buttonColor,
                    ],
                  ),
                ),
                margin: EdgeInsets.zero,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                            'assets/images/logo.jpeg'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        name,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        email,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    //<-- SEE HERE
                    side: BorderSide(width: 1, color: whiteColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: whiteColor,
                  leading: Container(
                      width: 30,
                      height: 30,
                      //devSize.height*0.05,
                      child: Image.asset('assets/images/appointment.png', fit: BoxFit.scaleDown,
                        width: 30,
                        height: 30,

                      )

                    // Icon(
                    //   Icons.local_fire_department,
                    //   color: Colors.white,
                    //   size: 20,
                    // )

                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 15,
                  ),
                  title: Text('Appointments',),
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AppointmentScreen()
                        ));
                  },
                ),
              ),


              Padding(
                padding:
                const EdgeInsets.only(top: 4, bottom: 4, left: 10, right: 10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    //<-- SEE HERE
                    side: BorderSide(width: 1, color: whiteColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: whiteColor,
                  leading: Container(
                      width: 30,
                      height: 30,
                      //devSize.height*0.05,
                      child: Image.asset('assets/images/shutdown.png', fit: BoxFit.scaleDown,
                        width: 30,
                        height: 30,

                      )

                    // Icon(
                    //   Icons.local_fire_department,
                    //   color: Colors.white,
                    //   size: 20,
                    // )

                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 15,
                  ),
                  title: Text('Logout',),
                  onTap: () async {

                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    try {
                      return await _auth.signOut().whenComplete(() {
                        prefs.remove('userEmail');
                        prefs.remove('userType');
                        prefs.remove('userPassword');
                        prefs.remove('userId');
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserType()));


                      });
                    } catch (e) {
                      return null;
                    }
                    // Navigator.push(
                    //   context,
                    //   PageRouteBuilder(
                    //     pageBuilder: (c, a1, a2) => AppBottomNavBarScreen(
                    //       index: 5,
                    //       title: '',
                    //       subTitle: '',
                    //     ),
                    //     transitionsBuilder: (c, anim, a2, child) =>
                    //         FadeTransition(opacity: anim, child: child),
                    //     transitionDuration: Duration(milliseconds: 100),
                    //   ),
                    // );
                  },
                ),
              ),

            ],
          ),
        ),
        //resizeToAvoidBottomInset: false,
        body:   SingleChildScrollView(
          child: Center(
            child: Container(

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

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
                                padding:  EdgeInsets.only(left: 20),
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


                                    ],),
                                ),
                              ),
                            ],
                          ),
                        ),


                        // SizedBox(
                        //   height: size.height*0.025,
                        // ),

                        SizedBox(
                          height: size.height*0.025,
                        ),

                        Container(
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(60.0),
                              color: Colors.white

                          ),
                          margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                          child: TextFormField(
                            controller: searchController,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,

                            ),
                            onChanged: (value) {
                              // setState(() {
                              //   userInput.text = value.toString();
                              // });
                            },
                            decoration: InputDecoration(
                              //contentPadding: EdgeInsets.only(top: 15,bottom: 15),
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              focusColor: buttonColor,
                              //add prefix icon

                              // errorText: "Error",

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60.0),
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                                borderRadius: BorderRadius.circular(60.0),
                              ),
                              fillColor: Colors.white,
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search, color: textColor,),
                              //make hint text
                              hintStyle: TextStyle(
                                color: textColor,
                                fontSize: 13,
                                fontFamily: "verdana_regular",
                                fontWeight: FontWeight.w400,
                              ),

                              //create lable
                              // labelText: 'Email Address',
                              // //lable style
                              // labelStyle: TextStyle(
                              //   color: darkRedColor,
                              //   fontSize: 16,
                              //   fontFamily: "verdana_regular",
                              //   fontWeight: FontWeight.w400,
                              // ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: size.height*0.025,
                        ),

                        Container(
                          height: size.height*0.4,
                          child: ListView.builder(
                              itemCount: _parlorList.length,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => DetailScreen(
                                    name: _parlorList[index].name.toString(),
                                    image:  _parlorList[index].image.toString(),
                                    services:  _parlorList[index].services.toString(),
                                    location:  _parlorList[index].location.toString(),
                                    servicesList: _parlorList[index].servicesList,

                                  )),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20,top: 6),
                                child: Container(
                                  width: size.width*0.8,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(60)
                                  ),

                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: size.width*0.25,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [

                                              CircleAvatar(
                                                backgroundColor: authButtonColor,
                                                backgroundImage: AssetImage(_parlorList[index].image.toString()),
                                                radius: 40,
                                              )
                                            // SizedBox(
                                            //   height: size.height*0.2,
                                            //
                                            //   child: Image.asset('assets/images/parlor1.jpg', fit: BoxFit.scaleDown,
                                            //     height: size.height*0.2,
                                            //   ),
                                            // ),
                                          ],),
                                        ),
                                        Container(
                                         // color: Colors.green,
                                            width: size.width*0.48,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                              Padding(
                                                padding:  EdgeInsets.only(left: 0,),
                                                child: Text(_parlorList[index].name.toString(), style: TextStyle(

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
                                                    child: Text(_parlorList[index].location.toString(), style: TextStyle(

                                                        color: textColor, fontSize: 13,fontWeight: FontWeight.w400),textAlign: TextAlign.center,),
                                                  ),
                                                ],),

                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Row(children: [

                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 0),
                                                    child: SizedBox(
                                                      height: 25,
                                                      width: 25,
                                                      child: Image.asset('assets/images/care.jpeg', fit: BoxFit.scaleDown,
                                                        height: 30,
                                                        width: 30,
                                                      ),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding:  EdgeInsets.only(left: 8,),
                                                    child: Container(
                                                      width: size.width*0.35,
                                                      alignment: Alignment.topLeft,
                                                      child: Text(_parlorList[index].services.toString(), style: TextStyle(

                                                          color: textColor, fontSize: 13,fontWeight: FontWeight.w400),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.left,),
                                                    ),
                                                  ),
                                                ],),

                                            ],)),
                                      ],
                                    ),
                                  ),

                                ),
                              ),
                            );
                          }),
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
      ),
    );
  }
  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit the App?'),
        actions:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: buttonColor,
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No'),
          ),

          ElevatedButton(
            onPressed: () {
              SystemNavigator.pop();
            },



            //return true when click on "Yes"
            style: ElevatedButton.styleFrom(
                primary: Colors.red,
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            child:Text('Yes'),
          ),

        ],
      ),
    )??false; //if showDialouge had returned null, then return false
  }
}

class ParlorModel {
  final String name;
  final String location;
  final String services;
  final String image;
  final List<String> servicesList;

  ParlorModel({
    required this.name,
    required this.location,
    required this.services,
    required this.image,
    required this.servicesList,
  });


}