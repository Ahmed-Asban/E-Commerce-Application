
import 'package:e_commerce_app/about_us.dart';
import 'package:e_commerce_app/cart/cart.dart';
import 'package:e_commerce_app/categories/basic.dart';
import 'package:e_commerce_app/categories/details_home.dart';
import 'package:e_commerce_app/create_account.dart';
import 'package:e_commerce_app/end_screen.dart';
import 'package:e_commerce_app/home.dart';
import 'package:e_commerce_app/login.dart';
import 'package:e_commerce_app/profile.dart';
import 'package:e_commerce_app/settings.dart';
import 'package:e_commerce_app/splash.dart';
import 'package:e_commerce_app/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
   runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes:{
        // 'body_screen': (context) => ProductDetailsPage(productId: 1),
        //'cart': (context) => Cart(),
        //'basic': (context) => Basic(),
        'details_home': (context) => basicHome(),
        'settings': (context) => Settings(),
        'create_account': (context) => Create_Account(),
        'about_us': (context) => AboutUs(),
        'profile': (context) => ProFile(),
        //'body_screen': (context) => BodyDetails(),
        'cart': (context) => Cart(),
        //'end_screen': (context) => End(),
        'home': (context) => Home(),
        //'profile': (context) => ProFile(),
        //'about_us': (context) => AboutUs(),
        'setting': (context) => Settings(),
        //'basic': (context) => Basic(),
        //'details_home': (context) => basicHome(),
        //'create_account': (context) => Create_Account(),
        //'settings': (context) => Settings(),
              
        'end_screen': (context) => End(),
        // 'home': (context) => Home(cat),
        // 'profile': (context) => ProFile(),
        // 'about_us': (context) => AboutUs(),
        // 'setting': (context) => Settings(),
      },

      title: 'Flutter Demo',
      theme: ThemeData.light(), // Light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: themeProvider.themeMode, // Set theme mode
      home: splash(),
    );
  }
}



