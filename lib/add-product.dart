import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tv_project3/add-product-controller.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProductController>(
      init: AddProductController(),
      builder: (controller) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
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
                'เพิ่มสินค้า',
                style: GoogleFonts.kanit(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 70),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getInput(
                      controller: controller.brandCtr,
                      text: "ยี่ห้อ",
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: getInput(
                            controller: controller.screenSizeCtr,
                            text: "ขนาดนิ้ว",
                            numberOnly: true,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: getInput(
                            controller: controller.priceCtr,
                            text: "ราคา",
                            numberOnly: true,
                            isPrice: true
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: getDropdown(
                            text: "ความละเอียด",
                            items: controller.screenResolution,
                            value: controller.selectScreenResolution,
                            onChange: (val) {
                              controller.selectScreenResolution = val!;
                              controller.update();
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: getDropdown(
                            text: "ระบบปฏิบัติการ",
                            items: controller.os,
                            value: controller.selectOs,
                            onChange: (val) {
                              controller.selectOs = val!;
                              controller.update();
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    getDropdown(
                      text: "ประเภทสินค้า",
                      items: controller.productType,
                      value: controller.selectProductType,
                      onChange: (val) {
                        controller.selectProductType = val!;
                        controller.update();
                      },
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        "รูปภาพ",
                        style: GoogleFonts.kanit(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        controller.selectImage();
                      },
                      child: Center(
                        child: Container(
                          width: Get.width * 0.8,
                          height: 250,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey[400]!,
                            ),
                          ),
                          child: controller.image == null
                              ? Center(
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.grey[400],
                                    size: 50,
                                  ),
                                )
                              : Image.file(
                                  controller.image!,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Container(
                        width: 250,
                        child: TextButton(
                          onPressed: () {
                            controller.addProductToFirebase();
                          },
                          style: OutlinedButton.styleFrom(
                              // backgroundColor: Color(0xff45C060),
                              side: BorderSide(color: Color(0xff45C060))),
                          child: Text(
                            'ยืนยัน',
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
          ),
        );
      },
    );
  }
}

Column getDropdown({text, value, onChange, items}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          "$text",
          style: GoogleFonts.kanit(
            fontSize: 18,
            color: Colors.grey[600],
          ),
        ),
      ),
      SizedBox(height: 3),
      Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            width: 1,
            color: Colors.grey[400]!,
          ),
        ),
        padding: EdgeInsets.only(left: 15, right: 15),
        child: DropdownButton<String>(
          value: value,
          dropdownColor: Colors.white,
          underline: Container(),
          isExpanded: true,
          items: (items as List).map<DropdownMenuItem<String>>((scr) {
            return DropdownMenuItem(
              child: Text('$scr'),
              value: scr,
            );
          }).toList(),
          onChanged: onChange,
        ),
      ),
    ],
  );
}

Column getInput({controller, text, numberOnly = false, isPrice = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          text,
          style: GoogleFonts.kanit(
            fontSize: 18,
            color: Colors.grey[600],
          ),
        ),
      ),
      SizedBox(height: 3),
      Container(
        height: 40,
        child: TextField(
          controller: controller,
          keyboardType: numberOnly ? TextInputType.number : null,
          cursorColor: Color(0xff45C060),
          inputFormatters: [
            if (isPrice) LengthLimitingTextInputFormatter(6),
          ],
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.only(top: 40 / 2, left: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: Colors.grey[400]!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Color(0xff45C060),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
