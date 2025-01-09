
import 'package:e_commerce_app/productsCart/productcart.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
class HomeBody extends StatelessWidget {
  final int categoryId;
  const HomeBody({super.key , required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(
              height: kDefaultPadding,
            ),
            Expanded(
                child: Stack(
                  children:
                  [
                    Container(
                      decoration: const BoxDecoration(
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
                      child:productCard(categoryId: categoryId)
                    )
                  ],
                ))
          ],
        )
    );
  }
}

