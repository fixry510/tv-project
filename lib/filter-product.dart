import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tv_project3/filter-product-controller.dart';

class FilterProduct extends StatelessWidget {
  const FilterProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FilterProductController>(
      init: FilterProductController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 2,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Get.back();
              },
              child: Center(
                  child: Image.asset(
                "assets/images/cancel.png",
                width: 15,
              )),
            ),
            title: Text(
              'ตัวกรอง',
              style: GoogleFonts.kanit(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            actions: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    controller.clearFilter();
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      "ล้างค่า",
                      style: GoogleFonts.kanit(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding:
                EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 70),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'ยี่ห้อ',
                          style: GoogleFonts.kanit(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        width: double.infinity,
                        // color: Colors.red,
                        child: GridView.count(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 1 / 0.25,
                          children: [
                            ...controller.brand.map((prod) {
                              return GestureDetector(
                                onTap: () {
                                  prod['check'] = !prod['check'];
                                  controller.update();
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 25,
                                        height: 25,
                                        child: Checkbox(
                                          value: prod['check'],
                                          checkColor: Colors.white,
                                          activeColor: Color(0xff45C060),
                                          onChanged: (val) {
                                            prod['check'] = val;
                                            controller.update();
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: AutoSizeText(
                                          prod['brand'],
                                          presetFontSizes: [
                                            14,
                                          ],
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.kanit(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList()
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'ขนาดหน้าจอ',
                          style: GoogleFonts.kanit(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        width: double.infinity,
                        // color: Colors.red,
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 1 / 0.25,
                          children: [
                            ...controller.screenSize.map((size) {
                              return GestureDetector(
                                onTap: () {
                                  size['check'] = !size['check'];
                                  controller.update();
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 25,
                                        height: 25,
                                        child: Checkbox(
                                          value: size['check'],
                                          checkColor: Colors.white,
                                          activeColor: Color(0xff45C060),
                                          onChanged: (val) {
                                            size['check'] = val;
                                            controller.update();
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: AutoSizeText(
                                          "${size['begin']} - ${size['end']} นิ้ว",
                                          presetFontSizes: [
                                            14,
                                          ],
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.kanit(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList()
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'ความละเอียด',
                          style: GoogleFonts.kanit(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        width: double.infinity,
                        // color: Colors.red,
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          crossAxisCount: 4,
                          childAspectRatio: 1 / 0.25,
                          children: [
                            ...controller.screenResolution.map((scr) {
                              return GestureDetector(
                                onTap: () {
                                  scr['check'] = !scr['check'];
                                  controller.update();
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 25,
                                        height: 25,
                                        child: Checkbox(
                                          value: scr['check'],
                                          checkColor: Colors.white,
                                          activeColor: Color(0xff45C060),
                                          onChanged: (val) {
                                            scr['check'] = val;
                                            controller.update();
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: AutoSizeText(
                                          "  ${scr['name']}",
                                          presetFontSizes: [
                                            14,
                                          ],
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.kanit(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList()
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'ระบบปปฏิบัติการ',
                          style: GoogleFonts.kanit(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        width: double.infinity,
                        // color: Colors.red,
                        child: GridView.count(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 1 / 0.25,
                          children: [
                            ...controller.os.map((os) {
                              return GestureDetector(
                                onTap: () {
                                  os['check'] = !os['check'];
                                  controller.update();
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 25,
                                        height: 25,
                                        child: Checkbox(
                                          value: os['check'],
                                          checkColor: Colors.white,
                                          activeColor: Color(0xff45C060),
                                          onChanged: (val) {
                                            os['check'] = val;
                                            controller.update();
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: AutoSizeText(
                                          "  ${os['name']}",
                                          presetFontSizes: [
                                            14,
                                          ],
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.kanit(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList()
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'ชนิดสินค้า',
                          style: GoogleFonts.kanit(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        width: double.infinity,
                        // color: Colors.red,
                        child: GridView.count(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          childAspectRatio: 1 / 0.25,
                          children: [
                            ...controller.productType.map((prodType) {
                              return GestureDetector(
                                onTap: () {
                                  prodType['check'] = !prodType['check'];
                                  controller.update();
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 25,
                                        height: 25,
                                        child: Checkbox(
                                          value: prodType['check'],
                                          checkColor: Colors.white,
                                          activeColor: Color(0xff45C060),
                                          onChanged: (val) {
                                            prodType['check'] = val;
                                            controller.update();
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: AutoSizeText(
                                          "  ${prodType['name']}",
                                          presetFontSizes: [
                                            14,
                                          ],
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.kanit(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }).toList()
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'ราคา',
                      style: GoogleFonts.kanit(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 35,
                                child: TextField(
                                  controller: controller.beginPrice,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.kanit(),
                                  keyboardType: TextInputType.number,
                                  onSubmitted: (value) {
                                    double textVal = double.parse(
                                        value.replaceAll(",", ""));
                                    if (textVal >=
                                        controller.rangePrice.end) {
                                      controller.beginPrice.text = "0";
                                      controller.rangePrice = RangeValues(
                                        0,
                                        double.parse(
                                          controller.endPrice.text
                                              .replaceAll(",", ""),
                                        ),
                                      );
                                      controller.update();
                                    } else {
                                      controller.rangePrice = RangeValues(
                                        double.parse(value),
                                        double.parse(controller.endPrice.text
                                            .replaceAll(",", "")),
                                      );
                                      controller.beginPrice.text =
                                          NumberFormat.simpleCurrency(
                                        locale: "th",
                                        decimalDigits: 0,
                                        name: "",
                                      ).format(
                                        double.parse(value),
                                      );
                                      controller.update();
                                    }
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  decoration: InputDecoration(
                                    suffix: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Text('บาท'),
                                    ),
                                    contentPadding:
                                        EdgeInsets.only(top: (35 / 2) - 5),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "ถึง",
                                style: GoogleFonts.kanit(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 35,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.kanit(),
                                  controller: controller.endPrice,
                                  keyboardType: TextInputType.number,
                                  onSubmitted: (value) {
                                    double textVal = double.parse(
                                        value.replaceAll(",", ""));
                                    if (textVal <
                                        controller.rangePrice.start) {
                                      controller.endPrice.text = "999,999";
                                      controller.rangePrice = RangeValues(
                                          double.parse(
                                              controller.beginPrice.text),
                                          999999);
                                      controller.update();
                                    } else {
                                      controller.rangePrice = RangeValues(
                                        double.parse(controller
                                            .beginPrice.text
                                            .replaceAll(",", "")),
                                        double.parse(value),
                                      );
                                      controller.endPrice.text =
                                          (NumberFormat.simpleCurrency(
                                        locale: "th",
                                        decimalDigits: 0,
                                        name: "",
                                      ).format(
                                        double.parse(value),
                                      ));
                                      controller.update();
                                    }
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  decoration: InputDecoration(
                                    suffix: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Text('บาท'),
                                    ),
                                    contentPadding:
                                        EdgeInsets.only(top: (35 / 2) - 5),
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                    border: OutlineInputBorder(
                                      // borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        RangeSlider(
                          values: controller.rangePrice,
                          max: 999999,
                          min: 0,
                          inactiveColor: Color(0xff45C060).withOpacity(0.2),
                          activeColor: Color(0xff45C060),
                          labels: RangeLabels(
                            controller.rangePrice.start.round().toString(),
                            controller.rangePrice.end.round().toString(),
                          ),
                          onChanged: (RangeValues values) {
                            final numFormat = NumberFormat.simpleCurrency(
                                locale: "th", decimalDigits: 0, name: "");
                            controller.rangePrice = values;
                            controller.beginPrice.text = numFormat
                                .format(values.start.round())
                                .toString();
                            controller.endPrice.text = numFormat
                                .format(values.end.round())
                                .toString();
                            controller.update();
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Container(
                      width: 250,
                      child: TextButton(
                        onPressed: () {
                          controller.onSubmit();
                        },
                        style: OutlinedButton.styleFrom(
                            // backgroundColor: Color(0xff45C060),
                            side: BorderSide(color: Color(0xff45C060))),
                        child: Text(
                          'แสดงผลลัพท์',
                          style: GoogleFonts.kanit(
                            fontSize: 16,
                            color: Color(0xff45C060),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
