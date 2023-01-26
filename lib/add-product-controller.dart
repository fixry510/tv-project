import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

// {
//   "productId": Random().nextInt(9999).toString(),
// "brand": "Samsung",
// "price": 5490,
// "screenSize": 32,
// "screenResolution": "HD",
// "os": "Non-Smart",
// "productType": "LED TV"
// },

class AddProductController extends GetxController {
  final brandCtr = TextEditingController();
  final screenSizeCtr = TextEditingController();
  final priceCtr = TextEditingController();
  File? image;
  List os = ["Smart", "Non-Smart", "Google", "Android"];
  List productType = ["LED TV", "OLED TV", "QLED TV", "NANO-CELL"];
  List screenResolution = ["8K", "4K", "FullHD", "HD"];

  String selectOs = "Smart";
  String selectScreenResolution = "8K";
  String selectProductType = "LED TV";

  Future<void> addProductToFirebase() async {
    await Get.showOverlay(
      loadingWidget: Center(
        child: CircularProgressIndicator(),
      ),
      asyncFunction: () async {
        final doc = FirebaseFirestore.instance.collection("products_tv").doc();
        final ref = FirebaseStorage.instance.ref("products_tv/${doc.id}");
        final imageUrl = await (await ref.putFile(image!)).ref.getDownloadURL();
        await doc.set({
          "productId": doc.id,
          "brand": brandCtr.text.trim(),
          "price": int.parse(priceCtr.text),
          "screenSize": int.parse(screenSizeCtr.text),
          "screenResolution": selectScreenResolution,
          "os": selectOs,
          "productType": selectProductType,
          "image": imageUrl,
        });
      },
    );
    Get.back();
  }

  Future<void> selectImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      image = File(img.path);
      update();
    }
  }
}
