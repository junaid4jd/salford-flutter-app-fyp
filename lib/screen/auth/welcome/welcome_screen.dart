

import 'package:salford_spa_flutter_app/constants.dart';
import 'package:salford_spa_flutter_app/screen/auth/login/login_screen.dart';
import 'package:salford_spa_flutter_app/screen/auth/signUp/sign_up_screen.dart';
import 'package:flutter/material.dart';
class WelcomeScreen extends StatefulWidget {
  final String userType;
  const WelcomeScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      body:     Center(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                colors: [
                  darkRedColor,
                  lightRedColor,

                ],
              ),

            ),
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  height: size.height*0.3,
                  width: size.width*0.95,
                  child: Image.asset('assets/images/welcome.jpeg', fit: BoxFit.scaleDown,
                    height: size.height*0.3,
                    width: size.width*0.95,
                  ),
                ),

                Container(
                  // width: size.width,
                  // height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

                      Container(
                        height: size.height*0.06,
                        width: size.width*0.7,

                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all(Size(size.width*0.8, 50)),
                              backgroundColor:
                              MaterialStateProperty.all(buttonColor),
                              // elevation: MaterialStateProperty.all(3),
                              shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                            ),

                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen(userType: widget.userType,)),
                              );
                            }, child: Row(
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 100,
                                  child: Image.asset('assets/images/flowers.png', fit: BoxFit.scaleDown,
                                    height: 40,
                                    width: 100,
                                  ),
                                ),
                                Text('Sign in', style: buttonStyle),
                              ],
                            )),
                      ),

                      SizedBox(
                        height: size.height*0.025,
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpScreen(userType: widget.userType,)),
                          );
                        },
                        child: Container(
                          // height: size.height*0.06,
                          // width: size.width*0.7,
                          child:  Center(
                            child: Text('Don\'t have account?', style: TextStyle(
                              fontSize: 14,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            )),
                          ),
                        ),
                      ),



                      SizedBox(
                        height: size.height*0.025,
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
