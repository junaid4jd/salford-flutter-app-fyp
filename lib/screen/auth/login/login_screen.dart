import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salford_spa_flutter_app/constants.dart';
import 'package:salford_spa_flutter_app/model/firebase_auth.dart';
import 'package:salford_spa_flutter_app/model/input_validator.dart';
import 'package:salford_spa_flutter_app/screen/admin/adminHomeScreen/admin_home_screen.dart';
import 'package:salford_spa_flutter_app/screen/auth/signUp/sign_up_screen.dart';
import 'package:salford_spa_flutter_app/screen/greeting/greeting_screen.dart';
import 'package:salford_spa_flutter_app/screen/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final String userType;
  const LoginScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isVisible = false;
  MethodsHandler _methodsHandler = MethodsHandler();
  InputValidator _inputValidator = InputValidator();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String isCreated = '';
  String isCreatedStudent = '';

  @override
  void initState() {
    print('Admin ${widget.userType}');
    // TODO: implement initState
    // if( widget.userType == 'Admin') {
    //
    //   setState(() {
    //     _emailControoler.text = 'admin@gmail.com';
    //     _passwordControoler.text = '12345678';
    //   });
    //
    // }
    // else {
    //   setState(() {
    //     _emailControoler.text = 'alirahman@gmail.com';
    //     _passwordControoler.text = '12345678';
    //   });
    // }
    setState(() {



      isCreated = '';
      isCreatedStudent = '';
      _isVisible = false;
      _isLoading = false;
    });
    print('userType');
    print(widget.userType.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
                  height: size.height*0.025,
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
                  width: size.width*0.85,
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
                                  child: Text('Welcome Back', style: TextStyle(color: textColor, fontSize: 16,fontWeight: FontWeight.bold),)
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
                                    padding:  EdgeInsets.only(left: size.width*0.25),
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
                          controller: _emailAddressController,
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
                            hintText: "Email",

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
                        height: size.height*0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(60.0),
                            color: Colors.white

                        ),
                        margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
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
                            hintText: "Password",

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
                        height: size.height*0.02,
                      ),
                      // widget.userType.toString() != 'Admin' ?
                      // Padding(
                      //     padding: const EdgeInsets.only(left: 16,right: 16),
                      //     child: GestureDetector(
                      //       onTap: () {
                      //         // Navigator.push(
                      //         //   context,
                      //         //   MaterialPageRoute(builder: (context) => ForgetPasswordScreen()),
                      //         // );
                      //       },
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.end,
                      //         children: [
                      //           Text('Forget Password?', style: TextStyle(color: textColor, fontSize: 13,fontWeight: FontWeight.w500),),
                      //         ],),
                      //     )
                      // ) : Container(),
                      SizedBox(
                        height: size.height*0.03,
                      ),

                      _isLoading
                          ? CircularProgressIndicator(
                        color: primaryColor,
                        strokeWidth: 2,
                      )
                          :

                      Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16),
                        child: Container(
                          height: size.height*0.06,
                       //   width: size.width*0.7,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
                            ],
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 1.0],
                              colors: [
                                textColor,
                                buttonColor,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all(Size(size.width, 50)),
                                backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                                // elevation: MaterialStateProperty.all(3),
                                shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                              ),

                              onPressed: () async {

                                if (_inputValidator
                                    .validateEmail(_emailAddressController.text) !=
                                    'success' &&
                                    _emailAddressController.text.isNotEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const  SnackBar(
                                          content:  Text('Wrong email, please use a correct email')
                                      )
                                  );
                                }

                                else {
                                  if (_emailAddressController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const  SnackBar(
                                            content:  Text('Enter Email Address')
                                        )
                                    );
                                  } else if (_passwordController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const  SnackBar(
                                            content:  Text('Enter Password')
                                        )
                                    );
                                  }
                                  else {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                    try {
                                      if (widget.userType == 'Users') {
                                        final snapshot = await FirebaseFirestore.instance.collection('Users').get();
                                        snapshot.docs.forEach((element) {
                                          print('user data');
                                          if(element['email'] == _emailAddressController.text.toString().trim()) {
                                            print('user age in if of current user ');
                                            //   print(element['age']);
                                            setState(() {
                                              isCreated = 'yes';
                                            });
                                          }
                                        });

                                        if(isCreated == 'yes') {
                                          final result =
                                          await _auth.signInWithEmailAndPassword(
                                              email: _emailAddressController.text
                                                  .trim()
                                                  .toString(),
                                              password: _passwordController.text);
                                          final user = result.user;

                                          prefs.setString(
                                              'userEmail', _emailAddressController.text);
                                          prefs.setString(
                                              'userPassword', _passwordController.text);
                                          prefs.setString('userId', user!.uid);
                                          prefs.setString('userType', widget.userType.toString());
                                          print('Account creation successful');
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          Navigator.pushReplacement(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (c, a1, a2) =>
                                                  HomeScreen(),
                                              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                              transitionDuration: Duration(milliseconds: 100),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              const  SnackBar(
                                                  content:  Text('Successfully Login')
                                              )
                                          );
                                        }
                                        else {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          _methodsHandler.showAlertDialog(
                                              context, 'Sorry', 'User Not Found');
                                        }
                                      }
                                      else {
                                        if (widget.userType == 'Admin' && _emailAddressController.text == 'admin@gmail.com' && _passwordController.text == '12345678') {

                                          prefs.setString(
                                              'userEmail', _emailAddressController.text);
                                          prefs.setString(
                                              'userPassword', _passwordController.text);
                                          print(widget.userType.toString());
                                          prefs.setString('userType', widget.userType.toString());
                                          Navigator.pushReplacement(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (c, a1, a2) => AdminHomeScreen(),
                                              transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                              transitionDuration: Duration(milliseconds: 100),
                                            ),
                                          );
                                        } else {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          _methodsHandler.showAlertDialog(
                                              context, 'Sorry', 'User Not Found');
                                        }


                                      }


                                    }
                                    on FirebaseAuthException catch (e)
                                    {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      print(e.code);
                                      switch (e.code) {
                                        case 'invalid-email':
                                          _methodsHandler.showAlertDialog(context,
                                              'Sorry', 'Invalid Email Address');

                                          setState(() {
                                            _isLoading = false;
                                          });
                                          break;
                                        case 'wrong-password':
                                          _methodsHandler.showAlertDialog(
                                              context, 'Sorry', 'Wrong Password');
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          break;
                                        case 'user-not-found':
                                          _methodsHandler.showAlertDialog(
                                              context, 'Sorry', 'User Not Found');
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          break;
                                        case 'user-disabled':
                                          _methodsHandler.showAlertDialog(
                                              context, 'Sorry', 'User Disabled');
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          break;
                                      }
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }

                                  }
                                }


                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => GreetingScreen()),
                                // );

                              }, child: Text('Login', style: buttonStyle)),
                        ),
                      ),
                      SizedBox(
                        height: size.height*0.03,
                      ),

                      Container(
                        width: size.width*0.7,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [

                            Container(
                              color: textColor,
                              height: 1,
                              width: size.width*0.6,
                            ),

                            Container(

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(60),
                              ),
                              height: size.height*0.04,
                              width: size.width*0.15,
                              child: Center(child: Text('OR', style: TextStyle(color: textColor,fontWeight: FontWeight.bold,fontSize: 15),)),
                            ),

                          ],
                        ),
                      ),


                      SizedBox(
                        height: size.height*0.03,
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 26,right: 26),
                        child: Container(
                          height: size.height*0.06,
                          //  width: size.width*0.35,
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all(Size(size.width, 50)),
                                backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                                // elevation: MaterialStateProperty.all(3),
                                shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                              ),

                              onPressed: (){
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => HomeScreen()),
                                // );

                              }, child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset('assets/images/facebook.png', fit: BoxFit.scaleDown,
                                  height: 30,
                                  width: 30,
                                ),
                              ),

                              SizedBox(
                                //height: 30,
                                width: 30,
                              ),
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset('assets/images/google.png', fit: BoxFit.scaleDown,
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ],
                          )

                          ),
                        ),
                      ),

                      SizedBox(
                        height: size.height*0.05,
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
