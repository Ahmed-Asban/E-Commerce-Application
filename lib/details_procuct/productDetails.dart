import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_app/constants.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productId;

  const ProductDetailsPage({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  List productDetails = [];
  Future<void> fetchProductDetails() async {
  final url = Uri.parse("http://192.168.8.139/api_e_commerce/detailsProducts.php"); // Replace with your API URL
  final res = await http.post(url, body: {'product_id': widget.productId.toString()});

  try {
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);

      if (data is Map<String, dynamic>) {
        // Wrap the object in a list if the response is a single product object
        setState(() {
          productDetails = [data];
        });
      } else if (data is List) {
        // Assign directly if the response is already a list
        setState(() {
          productDetails = data;
        });
      } else {
        print("Unexpected response format");
      }

      print(data); // Debug fetched data
    } else {
      print("Error: ${res.statusCode}");
    }
  } catch (e) {
    print("Error fetching products: $e");
  }
}
//................................................................

Future<void> addToCart(int productId) async {
  final url = Uri.parse("http://192.168.8.139/api_e_commerce/addToCart.php"); // رابط الـ API الخاص بالإضافة
  final res = await http.post(url, body: {'product_id': productId.toString()});

  if (res.statusCode == 200) {
    print("Product added to cart");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("تمت إضافة المنتج إلى السلة!")),
    );

    // الانتقال إلى صفحة السلة
    
  } else {
    print("Failed to add product to cart: ${res.statusCode}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("فشل في إضافة المنتج إلى السلة!")),
    );
  }
}

//..................button ..................

bouttn(int productId){
  return ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(
            context,
            'cart',
            arguments: productId, // تمرير بيانات السلة إلى الصفحة
    );
          },
          icon: const Icon(Icons.shopping_cart, size: 24), // أيقونة السلة
          label: const Text(
            "عرض السلة",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple, // لون الخلفية
            foregroundColor: Colors.white, // لون النص والأيقونة
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // زوايا مستديرة
            ),
            elevation: 5, // الظل
          ));
}
@override
  void initState() {
    super.initState();
    fetchProductDetails();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("تفاصيل المنتج", textDirection: TextDirection.ltr,),
        ),
        body: SafeArea(
        child: productDetails.isNotEmpty
        ? ListView.builder(
            itemCount: productDetails.length,
            itemBuilder: (ctx, i) {
              final product = productDetails[i];
              return Column(
                children: [
                  // Product Image
                  Container(
                    margin: const EdgeInsets.only(top: kDefaultPadding),
                    height: size.width * 0.8,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Expanded(
                          child: Container(
                            height: size.width * 0.8,
                            width: size.width * 0.8,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child:   Image.asset(
                            product["image_path"], // Ensure this is a valid URL
                            height: size.width * 0.75,
                            width: size.width * 0.75,
                            //fit: BoxFit.cover,
                          ),
                          ),
                        ),
                      
                      ],
                    ),
                  ),
                  // Product Details
                  Container(
                    margin: const EdgeInsets.only(top: kDefaultPadding),
                    padding: const EdgeInsets.all(kDefaultPadding),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          product["title"] ?? "No Title",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          product["description"] ?? "No Description",
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "السعر : \$${product["price"]}"?? "No price",
                          style: const TextStyle(fontSize: 18 ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
      
                            bouttn(product["id"]),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () async {
                                await addToCart(widget.productId); // استدعاء وظيفة الإضافة
                              },
                              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple, // لون الخلفية
              foregroundColor: Colors.white, // لون النص والأيقونة
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "إضافة إلى سلة التسوق",
                                style: TextStyle(
                                  fontSize: 17,
                                  
                                  fontWeight: FontWeight.bold,
                                  color: kBackgroundColor,
                                ),
                              ),
                            ),
                          ],
                        ),
      ],
                    ),
                  ),
                ],
              );
            },
          )
        : const Center(child: CircularProgressIndicator()),
      ),
      ),
    );
  }
}
