import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tv_project3/add-product.dart';
import 'package:tv_project3/home-page-controller.dart';
import 'package:tv_project3/product-item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
      init: HomePageController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff45C060),
          elevation: 0,
          title: Text(
            "TV SHOP",
            style: GoogleFonts.kanit(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(AddProduct(), fullscreenDialog: true);
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        controller.filterProduct();
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Color(0xff45C060),
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/img.png", width: 15),
                            SizedBox(width: 8),
                            Text(
                              "ตัวกรอง",
                              style: GoogleFonts.kanit(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "ค้นพบ ${controller.product.length} รายการ",
                      style: GoogleFonts.kanit(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: controller.product.isEmpty
                    ? Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 50),
                        child: Text(
                          "ไม่พบรายการค้นหา",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.kanit(
                            fontSize: 16,
                            color: Colors.grey
                          ),
                        ),
                      )
                    : GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1 / 2,
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 20),
                        children: [
                          ...controller.product.map((productData) {
                            return ProductItem(
                              productData: productData,
                            );
                          }).toList()
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
