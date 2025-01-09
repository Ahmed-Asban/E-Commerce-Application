import 'dart:convert';
import 'package:e_commerce_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Cart extends StatefulWidget {
 
  const Cart({super.key });

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  late int productId = 0;
  List cartItems=[];
  double totalPrice = 0.0;
  // late List<Map<String, dynamic>> cartItems = [];
Future<void> removeCart( productId) async {
    final url = Uri.parse("http://192.168.8.139/api_e_commerce/removeFromCart.php"); // رابط الـ API الخاص بالحذف
    final res = await http.post(url, body: {'id': productId});

    print("Deleting product with ID: $productId"); // طباعة للتأكد من قيمة الـ ID

    if (res.statusCode == 200) {
      print("Product removed from cart");
      // إعادة جلب البيانات بعد الحذف
        await fetchCartItems();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("تمت إزالة المنتج من السلة!")),
      );
    } else {
      print("Failed to remove product from cart: ${res.statusCode}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("فشل في إزالة المنتج من السلة!")),
      );
    }
  }// تعريف السلة هنا

//.................................................................
    Future<void> fetchCartItems() async {
    final url = Uri.parse('http://192.168.8.139/api_e_commerce/readCart.php?id=$productId'); // رابط API

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // تحويل البيانات المستلمة من JSON إلى قائمة
        final data = jsonDecode(response.body);
       setState(() {
          cartItems = data;
          totalPrice = 0.0;  // إعادة تعيين المجموع عند تحميل البيانات

          // حساب المجموع الكلي
          for (var product in cartItems) {

          totalPrice += product["total_price"];
        }
        });

      } else {
        print('Error fetching cart items: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching cart items: $e");
    }
  }

 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // استلام cartItems من الصفحات السابقة
    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg != null && arg is int) {
      setState(() {
        productId = arg;
      });
      fetchCartItems();  // استدعاء الدالة بعد تعيين productId
    }
  }
  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }


   Future<void> removeAllFromCart() async {
    final url = Uri.parse("http://192.168.8.139/api_e_commerce/removeAllFromCart.php"); // API endpoint for removing all items
    final res = await http.post(url); // No need to pass user_id

    if (res.statusCode == 200) {
      print("All products removed from cart");
      setState(() {
        cartItems.clear(); // Clear local cart items
        totalPrice = 0.0;  // Reset total price
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تمت إزالة جميع المنتجات من السلة!")),
      );
      //Navigator.pushReplacementNamed(context, "end_screen"); // Navigate to the end screen
    } else {
      print("Failed to remove all products from cart: ${res.statusCode}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("فشل في إزالة جميع المنتجات من السلة!")),
      );
    }
}




  //................................................................
  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("سلة المشتريات"),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                height: 100,
                child: cartItems.isNotEmpty
                    ? ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (ctx, i) {
                          final product = cartItems[i];
                          return  Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0, 7),
                                          blurRadius: 20,
                                          color: Colors.black26,
                                        ),
                                      ],
                                    ),
                                    child: Image.asset(
                                      product["image_path"], // عرض صورة المنتج
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                  title: Text(product["title"]),
                                  subtitle: Row(
                                    children: [
                                      Text("\$${product["price"]}", style: TextStyle(color: kPupColor)),
                                      SizedBox(width: 10),
                                      Text("الكمية: ${product["quantity"]}"), // عرض الكمية
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () async {
                                      await removeCart(product["id"]); // استدعاء وظيفة الحذف
                                    },
                                  ),
                                ),
                                // هنا قمنا بإضافة Row بعد Card لعرض المجموع وزر الدفع
                                ],
                          );
                        },
                      )
                      
                    : Center(child: Text("لا توجد منتجات في السلة")),
              ),
            ),
                    Expanded(
                      child: Container(
                                      alignment: Alignment.bottomLeft,
                                      
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child:  Text(
                "المجموع الكلي: \$${totalPrice.toStringAsFixed(2)}", // عرض المجموع الكلي
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.green,
                ),
              ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 40,bottom: 20),
                        color: kBackgroundColor,
                        height: 60,
                        width: 150,
                        child: FloatingActionButton(onPressed: () async {
                          // Show a dialog message
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("نجاح"),
                                content: Text("تمت عملية الدفع بنجاح"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Dismiss the dialog
                                      removeAllFromCart(); // Call the method to remove all items
                                    },
                                    child: Text("موافق"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                          backgroundColor: kPupColor,
                          child: Text("ادفع",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: kBackgroundColor),),),
                      ),
                                        ],
                                      ),
                      
                                    ),
                    ),
            
          ],
        ),
      ),
    );
  }
}

