import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:salford_spa_flutter_app/screen/admin/adminHomeScreen/admin_home_screen.dart';
import 'package:salford_spa_flutter_app/screen/home/home_screen.dart';
import 'package:salford_spa_flutter_app/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.length == 0) {


    if (Platform.isIOS) {
      // await Firebase.initializeApp(
      //     options: FirebaseOptions(apiKey: 'AIzaSyAFFk4hXMpio9X_Gz0wVCQvk4a5QAzllXM',
      //         appId: '1:97089701565:android:02972d723ec132a52119d4',
      //         messagingSenderId: '97089701565',
      //         storageBucket:  "agriculture-store-flutter.appspot.com",
      //         projectId: 'agriculture-store-flutter')
      // );
    }
    else {
      await Firebase.initializeApp(
          options: FirebaseOptions(apiKey: 'AIzaSyCboHIGPmuxuTwBohN0Q196dZJWbqwuLGE',
            appId: '1:177944454961:android:5b0878802c48ec8198b210',
            messagingSenderId: '177944454961',
            projectId: 'salford-spa-flutter',
            storageBucket:  "salford-spa-flutter.appspot.com",
          )
      );
    }

  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  String userType = '',email = '', uid = '';



  getData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Starting usertype ' + prefs.getString('userType').toString());
    if(prefs.getString('userType') != null) {
      setState(() {
        userType = prefs.getString('userType')!;
        email = prefs.getString('userEmail')!;
        // uid = prefs.getString('userId')!;
      });
      print(userType.toString() + ' This is user type');
    } else {
      print('Starting usertype');
    }


  }
  @override
  void initState() {
    print('Starting usertype');

    // TODO: implement initState
    // setState(() {
    //   userType = '';
    //   email = '';
    //   uid = '';
    // });

    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:
      userType == 'Users' ? HomeScreen() :
      userType == 'Admin' ? AdminHomeScreen() :
      SplashScreen(),
    );
  }
}


