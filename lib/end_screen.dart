import 'dart:async';
import 'package:e_commerce_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:e_commerce_app/categories/details_home.dart';
//import 'details_screen.dart';
import 'login.dart';

class End extends StatefulWidget {
  const End({super.key});
  @override
  State<End> createState() => _CallState();
}
class _CallState extends State<End> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context)=>basicHome()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor,

                ),
                child: Center(child: Text("تمت عملية الدفع بنجاح",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),)),
              ),
              SizedBox(height: 150,),

              Container(
                margin: EdgeInsets.only(bottom: 50),
                height: 60,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),

              ),
            ],
          )
      ),
    );
  }
}

