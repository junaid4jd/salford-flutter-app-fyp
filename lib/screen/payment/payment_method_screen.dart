
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salford_spa_flutter_app/constants.dart';

import 'package:flutter/material.dart';
import 'package:salford_spa_flutter_app/screen/greeting/shop_greeting_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
enum PaymentMethod { visa, paypal, cash }
class PaymentMethodScreen extends StatefulWidget {
  final String serviceSelected;
  final String time;
  final String name;
  final String location;
  final String services;
  final List<String> servicesList;
  final String image;
  const PaymentMethodScreen({Key? key,
    required this.serviceSelected,
    required this.time,
    required this.services,
    required this.location,
    required this.name,
    required this.image,
    required this.servicesList,
  }) : super(key: key);

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {

  PaymentMethod _paymentMethod = PaymentMethod.visa;
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _cardHolderNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardCVCController = TextEditingController();
  final TextEditingController _cardEdateController = TextEditingController();


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
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: buttonColor,
        title: Text(
          'Payment Method',
          style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => DashBoardScreen(index:1, title: '',)));
              // Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Image.asset(
                'assets/images/arrow_back.png',
                height: 20,
                width: 20,
                fit: BoxFit.scaleDown,
              ),
            )),
      ),

      body: SingleChildScrollView(
        child: Column(children: [

          SizedBox(
            height: size.height*0.015,
          ),
          ListTile(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => AddCardScreen()));
            },
            title:  Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset('assets/images/credit.png', fit: BoxFit.scaleDown,
                    height: 30,
                    width: 50,
                  ),
                ),
                Text('Debit/ Credit Card'),
              ],
            ),
            leading: Radio(
              value: PaymentMethod.visa,
              groupValue: _paymentMethod,
              activeColor: buttonColor,
              onChanged: (PaymentMethod? value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
            ),
          ),

          _paymentMethod == PaymentMethod.visa ?

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                SizedBox(
                  height: size.height*0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                  child: TextFormField(
                    controller: _cardHolderNameController,
                    keyboardType: TextInputType.name,
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
                      focusColor: Colors.white,

                      //add prefix icon

                      // errorText: "Error",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Image.asset('assets/images/credit.png', fit: BoxFit.scaleDown,
                          height: 30,
                          width: 50,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: darkGreyTextColor1, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: Colors.white,
                      hintText: "Card Holder Name",

                      //make hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),

                      //create lable
                      labelText: 'Card Holder Name',
                      //lable style
                      labelStyle: TextStyle(
                        color: buttonColor,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height*0.02,
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                  child: TextFormField(
                    controller: _cardNumberController,
                    keyboardType: TextInputType.number,
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
                      focusColor: Colors.white,
                      //add prefix icon

                      // errorText: "Error",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: darkGreyTextColor1, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: Colors.white,
                      hintText: "Card Number",

                      //make hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),

                      //create lable
                      labelText: 'Card Number',
                      //lable style
                      labelStyle: TextStyle(
                        color: buttonColor,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height*0.02,
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),
                  child: TextFormField(
                    controller: _cardCVCController,
                    keyboardType: TextInputType.number,
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
                      focusColor: Colors.white,
                      //add prefix icon

                      // errorText: "Error",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: darkGreyTextColor1, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: Colors.white,
                      hintText: "CVC",

                      //make hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),

                      //create lable
                      labelText: 'CVC',
                      //lable style
                      labelStyle: TextStyle(
                        color: buttonColor,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height*0.02,
                ),

                Container(
                  margin: EdgeInsets.only(left: 16,right: 16,bottom: 0),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: _cardEdateController,
                    keyboardType: TextInputType.datetime,
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
                      focusColor: Colors.white,
                      //add prefix icon

                      // errorText: "Error",

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: darkGreyTextColor1, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: Colors.white,
                      hintText: "DD/MM/YY",

                      //make hint text
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),

                      //create lable
                      labelText: 'Card Expiry Date',
                      //lable style
                      labelStyle: TextStyle(
                        color: buttonColor,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height*0.02,
                ),

            ],),
              )

              ,),
          ) : Container(),

          ListTile(
            title:  Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset('assets/images/paypal.png', fit: BoxFit.scaleDown,
                    height: 25,
                    width: 50,
                  ),
                ),
                Text('PayPal'),
              ],
            ),
            leading: Radio(
              value: PaymentMethod.paypal,
              groupValue: _paymentMethod,
              activeColor: buttonColor,
              onChanged: (PaymentMethod? value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
            ),
          ),
          ListTile(
            title:  Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset('assets/images/cash.png', fit: BoxFit.scaleDown,
                    height: 20,
                    width: 50,
                  ),
                ),
                Text('Cash on delivery'),
              ],
            ),
            leading: Radio(
              value: PaymentMethod.cash,
              groupValue: _paymentMethod,
              activeColor: buttonColor,
              onChanged: (PaymentMethod? value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
            ),
          ),


          SizedBox(
            height: size.height*0.025,
          ),

          isLoading ? CircularProgressIndicator(
            color: primaryColor,
            strokeWidth: 2,
          ) :
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16),
            child: Container(

              decoration: BoxDecoration(
               color: buttonColor,
                borderRadius: BorderRadius.circular(10),
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
                    MaterialStateProperty.all(buttonColor),
                    // elevation: MaterialStateProperty.all(3),
                    shadowColor:
                    MaterialStateProperty.all(Colors.transparent),
                  ),

                  onPressed: () async {


                    if(_paymentMethod == PaymentMethod.visa) {

                      if(_cardHolderNameController.text.isEmpty) {

                        var snackBar = SnackBar(content: Text('Card holder name is required'
                          ,style: TextStyle(color: Colors.white),),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      } else if(_cardNumberController.text.isEmpty) {

                        var snackBar = SnackBar(content: Text('Card number is required'
                          ,style: TextStyle(color: Colors.white),),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);


                      } else if(_cardCVCController.text.isEmpty) {

                        var snackBar = SnackBar(content: Text('Card cvc is required'
                          ,style: TextStyle(color: Colors.white),),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      } else if(_cardEdateController.text.isEmpty) {
                        var snackBar = SnackBar(content: Text('Card expire date is required'
                          ,style: TextStyle(color: Colors.white),),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        setState(() {
                          isLoading = true;
                        });

                        FirebaseFirestore.instance.collection('Appointments').doc().set({
                          'name': name,
                          'uid': _auth.currentUser!.uid.toString(),
                          'email': email,
                          'salonName': widget.name,
                          'salonLocation': widget.location,
                          'salonImage': widget.image,
                          'time': widget.time,
                          'service': widget.serviceSelected,
                          'status': 'Pending',
                        }).then((value)
                        {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ShopGreetingScreen(

                              name: widget.name,
                              servicesList: widget.servicesList,
                              services: widget.services,
                              location: widget.location,
                              image: widget.image,
                              serviceSelected: widget.serviceSelected,
                              time: widget.time,

                            )),
                          );
                        });


                      }

                    } else {

                      setState(() {
                        isLoading = true;
                      });

                      FirebaseFirestore.instance.collection('Appointments').doc().set({
                        'name': name,
                        'uid': _auth.currentUser!.uid.toString(),
                        'email': email,
                        'salonName': widget.name,
                        'salonLocation': widget.location,
                        'salonImage': widget.image,
                        'time': widget.time,
                        'service': widget.serviceSelected,
                        'status': 'Pending',
                      }).then((value)
                      {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ShopGreetingScreen(

                            name: widget.name,
                            servicesList: widget.servicesList,
                            services: widget.services,
                            location: widget.location,
                            image: widget.image,
                            serviceSelected: widget.serviceSelected,
                            time: widget.time,

                          )),
                        );
                      });

                    }

                  }, child: Text('Submit', style: buttonStyle)),
            ),
          ),
          SizedBox(
            height: size.height*0.1,
          ),



        ],),
      ),

    );
  }
}
