import 'dart:convert';
import 'package:e_commerce_app/details_procuct/productDetails.dart';
import 'package:e_commerce_app/productsCart/homebody.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class productCard extends StatefulWidget {
  final int categoryId;
  const productCard({
    super.key ,required this.categoryId,
  });

  @override
  State<productCard> createState() => _productCardState();
}

class _productCardState extends State<productCard> {

List productList = [];

  Future fetchProducts() async {
    var url = "http://192.168.8.139/api_e_commerce/readProducts.php"; // Adjust URL to your actual API endpoint
    
    final res = await http.post(Uri.parse(url), body: {
      'category_id': widget.categoryId.toString(),
    });
    try {
          

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() {
        productList = data;
      });

        print(data); // Prints the fetched data to console
      } else {
        print("Error: ${res.statusCode}");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }



  void navigateToProducts(int productId){
    // التوجيه إلى صفحة المنتجات بناءً على الاسم أو الـ ID
    if (productId == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsPage(productId: productId),
        ),
      );
    } else if (productId == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsPage(productId: productId),
        ),
      );
    }
    // أضف المزيد من التصنيفات هنا حسب الحاجة
  }

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Call fetchProducts when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
         appBar: AppBar(
          title: const Text(
            "قائمة المنتجات",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // رجوع إلى الصفحة السابقة
            },
          ),
        ),
        body: ListView.builder(
          itemCount:productList.length,
          itemBuilder:(ctx,i)
        {
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              productId:productList[i]["id"],
            ),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
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
            height: 160,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 160,
              width: 200,
              child: Image.asset(productList[i]["image_path"]),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 136,
              width: size.width - 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text(
                      productList[i]["title"],
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text(
                      productList[i]["description"],
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5,
                        vertical: kDefaultPadding / 5,
                      ),
                      decoration: BoxDecoration(
                        color: kSecondColor,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Text("السعر : \$${productList[i]["price"]}"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
        ),
      );
      
        }),
      ),
    );
  }
}

