import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/icons.dart';

class ProFile extends StatefulWidget {
  const ProFile({super.key});

  @override
  State<ProFile> createState() => _ProFileState();
}

class _ProFileState extends State<ProFile> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(Home());
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(
            'الحساب الشخصي',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 190.0, top: 40.0),
            ),
            CircleAvatar(
              radius: 60.0,
              //backgroundImage: AssetImage('images/IMG_1814.jpg'),
              child: Container(
                margin: EdgeInsets.only(top: 80.0, left: 70.0),
                // child: CircleAvatar(

                //   radius: 30.0,
                //   backgroundColor: Colors.grey[200],
                //   child:
                //   IconButton(onPressed: (){}, icon: const Icon(Icons.camera_alt_outlined)),
                // ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'عبدالله',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'bingazya@gmail.com',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 50, 136, 158),
                    shape:
                        StadiumBorder(side: BorderSide(color: Colors.black12))),
                child: const Text(
                  'تعديل',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        )),
      ),
    );
  }
}
