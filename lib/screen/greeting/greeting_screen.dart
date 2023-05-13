import 'package:flutter/material.dart';
import 'package:salford_spa_flutter_app/constants.dart';
import 'package:salford_spa_flutter_app/screen/home/home_screen.dart';

class GreetingScreen extends StatefulWidget {
  const GreetingScreen({Key? key}) : super(key: key);

  @override
  _GreetingScreenState createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return  Scaffold(
      backgroundColor: primaryColor,
      //resizeToAvoidBottomInset: false,
      body:   SingleChildScrollView(
        child: Center(
          child: Container(
            height: size.height,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: size.height*0.15,
                  width: size.width*0.7,
                  child: Image.asset('assets/images/logo.jpeg', fit: BoxFit.cover,
                    height: size.height*0.15,
                    width: size.width*0.7,
                  ),
                ),

                SizedBox(
                  height: size.height*0.025,
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
                        height: size.height*0.025,
                      ),


                      Container(
                        height: size.height*0.1,
                        width: size.width*0.9,
                        child: Stack(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: size.height*0.05,),
                              child: Center(
                                  child: Text('Thanks for joining', style: TextStyle(color: textColor, fontSize: 16,fontWeight: FontWeight.bold),)
                              ),
                            ),

                            Positioned(
                              top: size.height*0.05,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: SizedBox(
                                        height: 40,
                                        width: 80,
                                        child: Image.asset('assets/images/flowers.png', fit: BoxFit.scaleDown,
                                          height: 40,
                                          width: 80,
                                        ),
                                      ),
                                    ),
                                    // Center(
                                    //     child: Text('Welcome Back', style: TextStyle(color: Colors.transparent, fontSize: 16,fontWeight: FontWeight.bold),)
                                    // ),
                                    Padding(
                                      padding:  EdgeInsets.only(left: size.width*0.295),
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
                        height: size.height*0.25,
                        width: size.width*0.95,
                        child: Image.asset('assets/images/greeting1.jpeg', fit: BoxFit.scaleDown,
                          height: size.height*0.25,
                          width: size.width*0.95,
                        ),
                      ),








                      //


                      GestureDetector(
                        onTap: () {

                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (c, a1, a2) => HomeScreen(),
                              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                              transitionDuration: Duration(milliseconds: 100),
                            ),
                          );

                        },
                        child: SizedBox(
                          height: size.height*0.2,
                          width: size.width*0.7,
                          child: Image.asset('assets/images/greeting2.jpeg', fit: BoxFit.scaleDown,
                            height: size.height*0.2,
                            width: size.width*0.7,
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
