import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tv_project3/filter-product.dart';


class HomePageController extends GetxController {
  List allProduct = [];
  List product = [];

  Map filterData = {
    "brand": [],
    "screenSize": [],
    "screenResolution": [],
    "os": [],
    "productType": [],
    "price": {"begin": 0, "end": 999999},
  };

  Future<void> filterProduct() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    Get.to(
      FilterProduct(),
      fullscreenDialog: true,
    );
  }

  void onFilterProduct(Map filter) {
    filterData = filter;
    product = allProduct.where((prod) {
      bool isMathBrand = true;
      bool isMathScreenSize = true;
      bool isMathScreenResolution = true;
      bool isMathOs = true;
      bool isMathProductType = true;
      bool isMathPrice = true;
      for (int i = 0; i < filterData['brand'].length; i++) {
        if (prod['brand'] == filterData['brand'][i]) {
          isMathBrand = true;
          break;
        } else {
          isMathBrand = false;
        }
      }
      for (int i = 0; i < filterData['screenSize'].length; i++) {
        if (prod['screenSize'] >= filterData['screenSize'][i]["begin"] &&
            prod['screenSize'] <= filterData['screenSize'][i]["end"]) {
          isMathScreenSize = true;
          break;
        } else {
          isMathScreenSize = false;
        }
      }
      for (int i = 0; i < filterData['screenResolution'].length; i++) {
        if (prod['screenResolution'] == filterData['screenResolution'][i]) {
          isMathScreenResolution = true;
          break;
        } else {
          isMathScreenResolution = false;
        }
      }
      for (int i = 0; i < filterData['os'].length; i++) {
        if (prod['os'] == filterData['os'][i]) {
          isMathOs = true;
          break;
        } else {
          isMathOs = false;
        }
      }
      for (int i = 0; i < filterData['productType'].length; i++) {
        if (prod['productType'] == filterData['productType'][i]) {
          isMathProductType = true;
          break;
        } else {
          print("NotMath productType ${prod['productType']}");
          isMathProductType = false;
        }
      }
      if (prod['price'] >= filterData['price']['begin'] &&
          prod['price'] <= filterData['price']['end']) {
        isMathPrice = true;
      } else {
        isMathPrice = false;
      }
      return isMathBrand &&
          isMathScreenSize &&
          isMathScreenResolution &&
          isMathOs &&
          isMathProductType &&
          isMathPrice;
    }).toList();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    FirebaseFirestore.instance.collection("products_tv").snapshots().listen(
      (event) {
        allProduct = [];
        event.docs.forEach((element) {
          allProduct.add(element.data());
        });
        onFilterProduct(filterData);
      },
    );
  }
}
