import 'dart:ffi';
import 'package:e_commerce_app/categories/basic.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/create_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('يرجى إدخال بريدك الإلكتروني')));
      return;
    }

    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('يرجى إدخال كلمة المرور')));
      return;
    }

    final response = await http.post(
      Uri.parse('http://192.168.8.139/api_e_commerce/login.php'),
      body: {
        'email': _emailController.text,
        'password': _passwordController.text,
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
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Text("تسجيل الدخول",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_rounded),
          )
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Text(
                  "مرحباً بعودتك",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "سجل دخولك باستخدام البريد الالكتروني وكلمة المرور",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  textAlign: TextAlign.right,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                    ),
                    hintText: "ادخل بريدك الالكتروني",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    labelText: "البريد الالكتروني",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.right,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                    ),
                    hintText: "ادخل كلمة المرور",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    labelText: "كلمة المرور",

                    //floatingLabelAlignment: FloatingLabelAlignment.start
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    //padding: EdgeInsets.only(right: 120,left: 120,),

                    backgroundColor: kPrimaryColor,
                    shape: StadiumBorder(),
                  ),
                  onPressed: login,
                  child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      //
                    ),
                    child: const Center(
                      child: Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 120,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "create_account");
                        },
                        child: Text(
                          "انشاء حساب",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "ليس لديك حساب؟",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
