import 'package:e_commerce_app/categories/basic.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class basicHome extends StatefulWidget {
  const basicHome({super.key,});

  @override
  State<basicHome> createState() => _HomeState();
}

class _HomeState extends State<basicHome> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          appBar: AppBar(
        
            backgroundColor: kPrimaryColor,
            elevation: 0,
            title: Text("متجر إلكتروني"),
            centerTitle: true,
        
          ),
        
          drawer:  Drawer(
            backgroundColor: kBackgroundColor,
            child: Column(
              children: [
        
        
                //drawer logo
        
                DrawerHeader(
                    child: Center(
                      child: Icon(
                        Icons.shopping_bag,
                        size: 72,
                        color: kPrimaryColor,
        
        
                      ),
                    )
                ),
        
        
                //profile page
                ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: kPrimaryColor ,
                  ),
                  title: Text("الملف الشخصي"),
                  onTap: (){
                    Navigator.of(context).pushNamed("profile");
        
                  },
                ),
        
        
                //setting page
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: kPrimaryColor ,
                  ),
                  title: Text("الاعدادت"),
                  onTap: (){
                    Navigator.of(context).pushNamed("settings");
        
                  },
                ),
        
        
                //about us page
                ListTile(
                  leading: Icon(
                    Icons.contact_support_outlined,
                    color: kPrimaryColor ,
                  ),
                  title: Text("حول التطبيق"),
                  onTap: (){
                    Navigator.of(context).pushNamed("about_us");
        
                  },
                ),
        
              ],
        
        
        
            ),
        
        
          ),
        
        
        
          body:Basic(),
        
        
        
        
        
        
        
        
        
        ),
      ),










    );


  }
}