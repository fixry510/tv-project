import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItem extends StatelessWidget {
  Map productData;
   ProductItem({Key? key,required this.productData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.grey[50],
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          LayoutBuilder(
            builder: (context, constrained) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: constrained.maxHeight * 0.5,
                      child: Image.network(
                        productData['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: constrained.maxHeight * 0.45,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "brand : ${productData['brand']}",
                              style: GoogleFonts.kanit(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "ขนาดหน้าจอ : ${productData['screenSize']} นิ้ว",
                              style: GoogleFonts.kanit(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "ความละเอียด : ${productData['screenResolution']}",
                              style: GoogleFonts.kanit(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "ระบบ : ${productData['os']}",
                              style: GoogleFonts.kanit(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "ประเภท : ${productData['productType']}",
                              style: GoogleFonts.kanit(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "ราคา ${productData['price']}฿",
                              style: GoogleFonts.kanit(
                                fontSize: 18,
                                color: Color(0xFFD00107),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          // Positioned(
          //   right: 5,
          //   top: 5,
          //   child: Container(
          //     width: 100,
          //     height: 25,
          //     decoration: BoxDecoration(
          //       color: Colors.red,
          //       borderRadius: BorderRadius.circular(999),
          //     ),
          //     child: Center(
          //       child: Text(
          //         '35000 บาท',
          //         style: GoogleFonts.kanit(
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
