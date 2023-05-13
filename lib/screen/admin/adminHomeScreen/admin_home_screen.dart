
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salford_spa_flutter_app/constants.dart';
import 'package:salford_spa_flutter_app/model/firebase_auth.dart';
import 'package:salford_spa_flutter_app/screen/admin/adminAppointments/admin_appointments_screen.dart';
import 'package:salford_spa_flutter_app/screen/admin/adminUsersScreen/admin_users_screen.dart';
import 'package:salford_spa_flutter_app/screen/auth/userType/usertype_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AdminHomeScreen extends StatefulWidget {

  const AdminHomeScreen({Key? key,}) : super(key: key);

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List<String> categories = [];

  int y=0;
  String name = '' , email = '',
      uid = '',
      users = '',
      orders = '',
      products = '',
      category = '';
  String text = '';
 // final FirebaseAuth _auth = FirebaseAuth.instance;
  String subject = '';
 // MethodsHandler _methodsHandler = MethodsHandler();
  bool isloading = true;

  List<Product> _categories = [

    Product(
        title: 'Appointments',
        sale: 'Sale',
        isNew: '',
        quantity: '330g',
        ruppes: 'AED3.81',
        addToCart: 0,
        id: '',
        favorite: false,
        image: 'assets/images/appointment.png'),
    Product(
      title: 'Users',
      addToCart: 0,
      sale: 'Sale',
      isNew: '',
      id: '',
      quantity: '330g',
      ruppes: 'AED3.81',
      image: 'assets/images/user.png',
      favorite: false,
    ),
    Product(
      title: 'Logout',
      addToCart: 0,
      sale: 'Sale',
      isNew: '',
      id: '',
      quantity: '330g',
      ruppes: 'AED3.81',
      image: 'assets/images/shutdown.png',
      favorite: false,
    ),
  ];



  getData() {

    setState(() {
      y=1;
    });
    FirebaseFirestore.instance.collection('Users').get().then((value) {

      if(value.docs.isNotEmpty) {
        setState(() {
          users = value.docs.length.toString();
        });

      }
    });

    FirebaseFirestore.instance.collection('Appointments').get().then((value) {

      if(value.docs.isNotEmpty) {
        setState(() {
          orders = value.docs.length.toString();
        });

      }
    });

  }




  @override
  void initState() {
    setState(() {

      isloading = false;
      y=0;
      users = '0';
      orders = '0';
      products = '0';
      category = '0';
    });
    // TODO: implement initState
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(y==0) {
      getData();
    }
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: showExitPopup,

      child: Scaffold(
          backgroundColor: buttonColor,
          resizeToAvoidBottomInset: false,


          body:
          SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: size.height*0.06,
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  //  height: size.height * 0.1,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: buttonColor,

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: textColor,
                          backgroundImage: AssetImage('assets/images/logo.jpeg')
                        ),


                      ],)
                ),
              ),
              SizedBox(
                  height: 10,),
              Text('Welcome Admin', style: TextStyle(color: primaryColor,fontSize: 20, fontWeight: FontWeight.w700),),

              SizedBox(
                height: size.height*0.02,
              ),

              isloading ? Center(child: CircularProgressIndicator(color: primaryColor,)) :
              Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
                    child: Column(
                      children: [
                        Container(
                          // decoration: BoxDecoration(
                          //     color: primaryColor,
                          //     borderRadius: BorderRadius.circular(50)
                          //
                          // ),
                         // height: size.height * 0.5,
                          child: GridView.builder(
                              padding: EdgeInsets.only(top: 10),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 1,
                                  mainAxisExtent: 170,
                                  mainAxisSpacing: 10),
                              itemCount: _categories
                                  .length, //snapshot.data!.docs.length,//myProducts.length,
                              itemBuilder: (BuildContext ctx, index1) {
                                return GestureDetector(
                                  onTap: () async {
                                    print(index1.toString());
                                    if(index1 == 0) {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (c, a1, a2) => AdminAppointmentScreen(),
                                          transitionsBuilder: (c, anim, a2, child) =>
                                              FadeTransition(
                                                  opacity: anim, child: child),
                                          transitionDuration: Duration(
                                              milliseconds: 100),
                                        ),
                                      ).then((value) {
                                        getData();
                                        setState(() {

                                        });

                                      });
                                    }
                                    else if(index1 == 1) {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (c, a1, a2) => AdminUserScreen(),
                                          transitionsBuilder: (c, anim, a2, child) =>
                                              FadeTransition(
                                                  opacity: anim, child: child),
                                          transitionDuration: Duration(
                                              milliseconds: 100),
                                        ),
                                      ).then((value) {
                                        getData();
                                        setState(() {

                                        });

                                      });
                                    }
                                    else if(index1 == 2) {
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      try {
                                        prefs.remove('userEmail');
                                        prefs.remove('userType');
                                        prefs.remove('userPassword');
                                        prefs.remove('userId');
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserType()));
                                      } catch (e) {
                                        return null;
                                      }
                                    }

                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      //width: size.width * 0.3,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        //shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(color: Colors.white),
                                        color: Colors.white,
                                        gradient:  LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors:
                                          index1 == 0 ? <Color>[primaryColor, buttonColor,] :
                                          index1 == 1 ? <Color>[primaryColor, buttonColor,] :
                                          index1 == 2 ? <Color>[primaryColor, buttonColor,] :
                                          <Color>[oneColor1, oneColor],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: primaryColor
                                                .withOpacity(0.4),
                                            spreadRadius: 1.2,
                                            blurRadius: 0.8,
                                            offset: Offset(0,
                                                0), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Center(
                                              child: Container(

                                                child: Image.asset(
                                                  _categories[index1].image.toString(),
                                                  // _categories[index]
                                                  //     .image
                                                  //     .toString(),
                                                  fit: BoxFit.scaleDown,
                                                  height: 50,
                                                  width: 50,
                                                ),
                                              )),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          index1 == 2 ? Container() :
                                          Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: whiteColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: primaryColor1
                                                        .withOpacity(0.4),
                                                    spreadRadius: 1.2,
                                                    blurRadius: 0.8,
                                                    offset: Offset(0,
                                                        0), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  index1 == 0 ? orders.toString() :
                                                  index1 == 1 ? users.toString() :

                                                  category.toString(),
                                                  style: TextStyle(fontSize: 15,color:
                                                  index1 == 0 ? fourColor  :
                                                  index1 == 1 ? threeColor  :
                                                  index1 == 2 ? twoColor  :
                                                  oneColor,fontWeight: FontWeight.bold,),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),

                                          Center(
                                            child: Text(
                                              _categories[index1].title.toString(),
                                              style: TextStyle(fontSize: 15,color: whiteColor,fontWeight: FontWeight.bold,),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                ],
              ),



            ],),
          )





      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await
    showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Do you want to exit the App?'),
        actions:[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: primaryColor,
                textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.of(context).pop(false),
            //return false when click on "NO"
            child:Text('No'),
          ),

          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            //return true when click on "Yes"
            style: ElevatedButton.styleFrom(
                primary: redColor,
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


class Product {
  final String image;
  final String id;
  final String sale;
  final String isNew;
  final String title;
  final String quantity;
  final String ruppes;
  bool favorite;
  int addToCart;

  Product(
      {required this.title,
        required this.id,
        required this.sale,
        required this.isNew,
        required this.quantity,
        required this.ruppes,
        required this.image,
        required this.favorite,
        required this.addToCart});
}
