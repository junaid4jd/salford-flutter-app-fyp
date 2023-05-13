import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salford_spa_flutter_app/constants.dart';
import 'package:salford_spa_flutter_app/model/firebase_auth.dart';
import 'package:salford_spa_flutter_app/model/input_validator.dart';
import 'package:salford_spa_flutter_app/screen/auth/login/login_screen.dart';
import 'package:salford_spa_flutter_app/screen/greeting/greeting_screen.dart';
import 'package:salford_spa_flutter_app/screen/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  final String userType;
  const SignUpScreen({Key? key, required this.userType}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailControoler = TextEditingController();
  final TextEditingController _phoneControoler = TextEditingController();
  final TextEditingController _passwordControoler = TextEditingController();
  final TextEditingController _confirmPasswordControoler = TextEditingController();
  final TextEditingController _firstNameControoler = TextEditingController();

  MethodsHandler _methodsHandler = MethodsHandler();
  InputValidator _inputValidator = InputValidator();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool _isVisible = false;
  bool _isVisibleC = false;



  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _isVisible = false;
      _isVisibleC = false;
      _isLoading = false;
    });
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
                                  child: Text('Create an account', style: TextStyle(color: textColor, fontSize: 16,fontWeight: FontWeight.bold),)
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
                          controller: _firstNameControoler,
                          keyboardType: TextInputType.text,
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
                            hintText: "User Name",

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
                        height: size.height*0.01,
                      ),

                      Container(
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(60.0),
                            color: Colors.white

                        ),
                        margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                        child: TextFormField(
                          controller: _emailControoler,
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
                        height: size.height*0.01,
                      ),

                      Container(
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(60.0),
                            color: Colors.white

                        ),
                        margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                        child: TextFormField(
                          controller: _phoneControoler,
                          keyboardType: TextInputType.phone,
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
                            hintText: "Phone Number",

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
                        height: size.height*0.01,
                      ),
                      Container(
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(60.0),
                            color: Colors.white

                        ),
                        margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                        child: TextFormField(
                          controller: _passwordControoler,
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
                        height: size.height*0.01,
                      ),
                      Container(
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(60.0),
                            color: Colors.white

                        ),
                        margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                        child: TextFormField(
                          controller: _confirmPasswordControoler,
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
                            hintText: "Confirm Password",

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
                        height: size.height*0.03,
                      ),
                      _isLoading ? CircularProgressIndicator(
                        color: primaryColor,
                        strokeWidth: 2
                        ,
                      ) :
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Container(
                          height: size.height*0.06,
                            width: size.width*0.8,
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

                                if (_inputValidator.validateName(
                                    _firstNameControoler.text) !=
                                    'success' &&
                                    _firstNameControoler.text.isNotEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Invalid User Name",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }
                                else if (_inputValidator.validateEmail(
                                    _emailControoler.text) !=
                                    'success' &&
                                    _emailControoler.text.isNotEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Wrong email address",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }

                                else if (_inputValidator.validateMobile(
                                    _phoneControoler.text) !=
                                    'success' &&
                                    _phoneControoler.text.isNotEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Phone Number Starts with + followed by code then number (Hint +923346567876)",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }

                                else if ((_passwordControoler.text.length <
                                    7 &&
                                    _passwordControoler
                                        .text.isNotEmpty) &&
                                    (_confirmPasswordControoler.text.length < 7 &&
                                        _confirmPasswordControoler
                                            .text.isNotEmpty)) {
                                  Fluttertoast.showToast(
                                      msg: "Password and Confirm Password must be same",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );

                                }
                                else if (_passwordControoler.text !=
                                    _confirmPasswordControoler.text) {
                                  Fluttertoast.showToast(
                                      msg: "Password and Confirm Password must be same",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }
                                else {
                                  if(_firstNameControoler.text.isEmpty)
                                  {
                                    Fluttertoast.showToast(
                                        msg: "User Name is required",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }
                                  else if(_emailControoler.text.isEmpty)
                                  {
                                    Fluttertoast.showToast(
                                        msg: "Email Address is required",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }

                                  else if(_phoneControoler.text.isEmpty)
                                  {
                                    Fluttertoast.showToast(
                                        msg: "Phone number is required",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }

                                  else if(_passwordControoler.text.isEmpty)
                                  {
                                    Fluttertoast.showToast(
                                        msg: "Password is required",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }
                                  else if(_confirmPasswordControoler.text.isEmpty)
                                  {
                                    Fluttertoast.showToast(
                                        msg: "Confirm Password is required",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                  }
                                  else {
                                    setState(() {
                                      _isLoading = true;
                                      print('We are in loading');
                                      //  state = ButtonState.loading;
                                    });

                                    print(_firstNameControoler.text.toString());
                                    print( _emailControoler.text.toString());
                                    print( _passwordControoler.text.toString());
                                    print( _phoneControoler.text.toString());
                                    //createAccount();
                                    //_methodsHandler.createAccount(name: _controllerClinic.text, email: _controller.text, password: _controllerPass.text, context: context);
                                    SharedPreferences prefs = await SharedPreferences.getInstance();

                                    FirebaseFirestore.instance
                                        .collection(widget.userType.toString()).where(
                                        "email",isEqualTo: _emailControoler.text.trim()).get().then((value) async {


                                      if(value.docs.isNotEmpty) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        Fluttertoast.showToast(
                                          msg: "Sorry email account already exists",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 4,
                                        );
                                      } else {

                                        try {

                                          User? result = (await _auth
                                              .createUserWithEmailAndPassword(
                                              email:
                                              _emailControoler.text.trim(),
                                              password: _passwordControoler.text
                                                  .trim()))
                                              .user;

                                          if(result != null) {

                                            var user = result;

                                            FirebaseFirestore.instance
                                                .collection(widget.userType.toString())
                                                .doc()
                                                .set({
                                              "email": _emailControoler.text.trim(),
                                              "password": _passwordControoler.text.trim(),
                                              "uid": user.uid,
                                              "name": _firstNameControoler.text,
                                              "userType": widget.userType.toString(),

                                            }).then((value) => print('success'));




                                            prefs.setString('userType',
                                                'Users');
                                            prefs.setString('userEmail',
                                                _emailControoler.text.trim());
                                            prefs.setString('userPassword',
                                                _passwordControoler.text.trim());
                                            prefs.setString('name',
                                                _firstNameControoler.text.trim());
                                            prefs.setString('userId', user.uid);
                                            print('Account creation successful');
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            Navigator.pushReplacement(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (c, a1, a2) => GreetingScreen(),
                                                transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                                transitionDuration: Duration(milliseconds: 100),
                                              ),
                                            );
                                            Fluttertoast.showToast(
                                              msg: "Account created successfully",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 4,
                                            );


                                          }
                                          else {
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            print('error');
                                          }

                                        }
                                        on FirebaseAuthException catch (e) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          if(e.code == 'email-already-in-use') {

                                            showAlertDialog(context, 'Sorry', 'The email address is already in use by another account.');
                                          }
                                          print(e.message);
                                          print(e.code);
                                        }

                                        await Future.delayed(Duration(seconds: 1));

                                      }

                                    });



                                  }
                                }

                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => GreetingScreen()),
                                // );

                              }, child: Text('Sign up', style: buttonStyle)),
                        ),
                      ),

                      SizedBox(
                        height: size.height*0.025,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen(userType: widget.userType,)),
                          );
                        },
                        child: Container(
                          // height: size.height*0.06,
                          // width: size.width*0.7,
                          child:  Center(
                            child: Text('Already have account', style: TextStyle(
                              fontSize: 14,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            )),
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

  showAlertDialog(BuildContext context, String title, String content) {
    // set up the button

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text("$title"),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("$content"),
      ),
      actions: [
        // CupertinoDialogAction(
        //     child: Text("YES"),
        //     onPressed: ()
        //     {
        //       Navigator.of(context).pop();
        //     }
        // ),
        CupertinoDialogAction(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            })
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}