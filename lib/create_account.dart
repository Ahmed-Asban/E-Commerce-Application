import 'dart:ffi';
import 'package:e_commerce_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Create_Account extends StatefulWidget {
  const Create_Account({super.key});

  @override
  State<Create_Account> createState() => _Create_AccountState();
}

class _Create_AccountState extends State<Create_Account> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 

  Future<void> signUp() async {
  // Check for empty fields
  if (_usernameController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('يرجى إدخال اسم المستخدم')));
    return;
  }
  
  if (_emailController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('يرجى إدخال بريدك الإلكتروني')));
    return;
  }

  if (_passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('يرجى إدخال كلمة المرور')));
    return;
  }

  final response = await http.post(
    Uri.parse('http://192.168.8.139/api_e_commerce/sign.php'),
    body: {
      'Username': _usernameController.text,
      'Email': _emailController.text,
      'Password': _passwordController.text,
    },
  );

  final data = json.decode(response.body);
  if (data['status'] == 'success') {
    ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(data['message'])));
    Navigator.pushReplacementNamed(context, "details_home");
  } else {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(data['message'])));
  }
}









  @override
  Widget build(BuildContext context) {
    return  Directionality(
      
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(

               title: Text("انشاء حساب"),
        ),
      
        body: SafeArea(
      
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 35,),
                Text("انشاء حساب جديد",style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),),
                Text("من فضلك قم بملئ البيانات التالية",style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
      
                ),),
      
      
                SizedBox(height: 30,),
                TextField(
                  textAlign: TextAlign.right,
                  controller: _usernameController,
                  decoration: InputDecoration(
      
                    border: OutlineInputBorder(
      
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                    ),
                    hintText: "اسم المستخدم",
                    hintStyle: TextStyle(color:Colors.grey, fontSize: 14,),
                    labelText: "اسم المستخدم",
      
      
                  ),
                ),
      
                SizedBox(height: 20.0,),
                TextField(
                  textAlign: TextAlign.right,
                  controller: _emailController,
                  decoration: InputDecoration(
      
                    border: OutlineInputBorder(
      
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                    ),
                    hintText: "ادخل بريدك الالكتروني",
                    hintStyle: TextStyle(color:Colors.grey, fontSize: 14,),
                    labelText: "ادخل بريدك الالكتروني",
      
      
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  textAlign: TextAlign.right,
                  controller: _passwordController,
                  decoration: InputDecoration(
      
                    border: OutlineInputBorder(
      
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                    ),
                    hintText: "ادخل كلمة المرور",
                    hintStyle: TextStyle(color:Colors.grey, fontSize: 14,),
                    labelText: "ادخل كلمة المرور",
      
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //padding: EdgeInsets.only(right: 120,left: 120,),
      
                      backgroundColor: kPrimaryColor,
                      shape: StadiumBorder(),
                    ),
                    onPressed:signUp ,
      
                    child: Container(
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //
                      ),
                      child: const Center(child: Text("التالي",
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                      ),
                    ) ,
                  ),
                ),
      
                SizedBox(height: 120,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
      
                    Text("بالاستمرار انت توافق على سياسات التطبيق",
                      style: TextStyle(fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ],
                )
      
              ],
            ),
          ),
        ),
      
      ),
    );
  }
}
