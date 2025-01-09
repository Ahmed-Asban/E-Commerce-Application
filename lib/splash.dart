import 'dart:async';
import 'package:e_commerce_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:e_commerce_app/details_screen.dart';
import 'package:e_commerce_app/login.dart';

class splash extends StatefulWidget {
  const splash({super.key});
  @override
  State<splash> createState() => _CallState();
}
class _CallState extends State<splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),(){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=>Login()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CircularProgressIndicator(),
            Image.asset("images/—Pngtree—e-letter logo ecommerce shop store_7265997.png"),
            SizedBox(height: 15,),
            Text("مرحبا بكم في متجرنا",style: TextStyle(fontSize: 30,color: kPrimaryColor,fontWeight: FontWeight.bold),)
          ],
        )
      ),
    );
  }
}
