import 'dart:convert';
import 'package:e_commerce_app/productsCart/homebody.dart';
import 'package:e_commerce_app/productsCart/productcart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
class Basic extends StatefulWidget {
  const Basic({
    super.key,
  });

  @override
  State<Basic> createState() => _BasicState();
}

class _BasicState extends State<Basic> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(
              height: kDefaultPadding,
            ),
            Expanded(
                child: Stack(
                  children:
                  [
                    Container(
                      decoration: BoxDecoration(
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              topLeft: Radius.circular(40)
                          )
                      ),
                      margin: EdgeInsets.only(top: 70),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: basicwidget(),
                    )
                  ],
                ))
          ],
        )
    );
  }
}

class basicwidget extends StatefulWidget {
  const basicwidget({
    super.key,
  
  });

  @override
  State<basicwidget> createState() => _basicwidgetState();
}

class _basicwidgetState extends State<basicwidget> {

  List catogoryList = [];
  Future fetchCategories() async {
    var url = "http://192.168.8.139/api_e_commerce/readCatogories.php"; // Adjust URL to your actual API endpoint
    final res = await http.get(Uri.parse(url));

      try {
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
          setState(() {
        catogoryList = data.map((item) {
          return {
            "id": int.parse(item["id"]), // تحويل "id" إلى int
            "title": item["title"],
            "image_path": item["image_path"],
          };
        }).toList();
      });

        print(data); // Prints the fetched data to console
      } else {
        print("Error: ${res.statusCode}");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

void navigateToProducts(String categoryName, int categoryId) {
    // التوجيه إلى صفحة المنتجات بناءً على الاسم أو الـ ID
    if (categoryName == "جوالات") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeBody(categoryId: categoryId),
        ),
      );
    } else if (categoryName == "ملابس و أحذية") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeBody(categoryId: categoryId),
        ),
      );
    }
    else if (categoryName == "لابتوبات") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeBody(categoryId: categoryId),
        ),
      );
    }

    else if (categoryName == "أثاث و ديكورات") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeBody(categoryId: categoryId),
        ),
      );
    }

    else if (categoryName == "شاشات") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeBody(categoryId: categoryId),
        ),
      );
    }

    else if (categoryName == "كاميرات") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeBody(categoryId: categoryId),
        ),
      );
    }
    // أضف المزيد من التصنيفات هنا حسب الحاجة
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: ListView.builder(
  itemCount: catogoryList.length,
  itemBuilder: (ctx, i) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
      ),
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      height: 190,
      child: InkWell(
        onTap: () {
          // Navigate to the ProductsScreen with the selected category ID
                      navigateToProducts(catogoryList[i]["title"],catogoryList[i]["id"]);

        },
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: kBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 15),
                    blurRadius: 25,
                    color: Colors.black26,
                  ),
                ],
              ),
              height: 240,
            ),
            Positioned(
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                width: double.infinity,
                height: 150,
                child: Image.asset(catogoryList[i]["image_path"]),
              ),
            ),
            SizedBox(width: 30),
            Padding(
              padding: const EdgeInsets.only(left: 160),
              child: Positioned(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  width: double.infinity,
                  height: 150,
                  child: Text(catogoryList[i]["title"]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  },
),
  );
  }
}

