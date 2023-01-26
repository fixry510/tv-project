import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';
import 'package:tv_project3/home-page-controller.dart';

class FilterProductController extends GetxController {
  List brand = [];
  late RangeValues rangePrice;
  final beginPrice = TextEditingController(text: "0");
  final endPrice = TextEditingController(text: "999,999");

  List screenSize = [
    {"begin": 66, "end": 100, "check": false},
    {"begin": 56, "end": 65, "check": false},
    {"begin": 44, "end": 55, "check": false},
    {"begin": 32, "end": 43, "check": false},
    {"begin": 14, "end": 31, "check": false},
  ];
  List os = [
    {"name": "Smart", "check": false},
    {"name": "Non-smart", "check": false},
    {"name": "Google", "check": false},
    {"name": "Android", "check": false},
  ];
  List productType = [
    {"name": "LED TV", "check": false},
    {"name": "OLED TV", "check": false},
    {"name": "QLED TV", "check": false},
    {"name": "NANO-CELL", "check": false},
  ];
  List screenResolution = [
    {"name": "8K", "check": false},
    {"name": "4K", "check": false},
    {"name": "FullHD", "check": false},
    {"name": "HD", "check": false},
  ];

  @override
  void onInit() {
    super.onInit();
    final homeController = Get.find<HomePageController>();
    List products = homeController.allProduct;
    for (int i = 0; i < products.length; i++) {
      bool isDupicate = false;
      for (int j = 0; j < brand.length; j++) {
        if (brand[j]['brand'] == products[i]['brand']) {
          isDupicate = true;
        }
      }
      if (isDupicate == false) {
        Map brandAdd = {
          ...products[i],
          "check": false,
        };
        brand.add(brandAdd);
      }
    }
    homeController.filterData['brand'].forEach((brandName) {
      brand.forEach((brand) {
        if (brand['brand'] == brandName) {
          brand['check'] = true;
        }
      });
    });
    homeController.filterData['screenSize'].forEach((s) {
      screenSize.forEach((size) {
        if (size['begin'] == s['begin'] && size['end'] == s['end']) {
          size['check'] = true;
        }
      });
    });
    homeController.filterData['os'].forEach((osName) {
      os.forEach((os) {
        if (os['name'] == osName) {
          os['check'] = true;
        }
      });
    });
    homeController.filterData['productType'].forEach((productTypeName) {
      productType.forEach((productType) {
        if (productType['name'] == productTypeName) {
          productType['check'] = true;
        }
      });
    });
    homeController.filterData['screenResolution']
        .forEach((screenResolutionName) {
      screenResolution.forEach((screenResolution) {
        if (screenResolution['name'] == screenResolutionName) {
          screenResolution['check'] = true;
        }
      });
    });

    rangePrice = RangeValues(
      homeController.filterData['price']['begin'].toDouble(),
      homeController.filterData['price']['end'].toDouble(),
    );
    beginPrice.text = NumberFormat.simpleCurrency(
      locale: "th",
      decimalDigits: 0,
      name: "",
    ).format(rangePrice.start);
    endPrice.text = NumberFormat.simpleCurrency(
      locale: "th",
      decimalDigits: 0,
      name: "",
    ).format(rangePrice.end);
  }

  void onSubmit() {
    Get.find<HomePageController>().onFilterProduct({
      "brand": brand.where((b) => b['check']).map((b) => b['brand']).toList(),
      "screenSize": screenSize.where((sc) => sc['check']).toList(),
      "screenResolution": screenResolution.where((scr) => scr['check']).map((scr) => scr['name']).toList(),
      "os": os.where((os) => os['check']).map((os) => os['name']).toList(),
      "productType": productType.where((prod) => prod['check']).map((prod) => prod['name']).toList(),
      "price": {
        "begin": double.parse(beginPrice.text.replaceAll(",", "")),
        "end": double.parse(endPrice.text.replaceAll(",", "")),
      }
    });
    Get.back();
  }

  void clearFilter() {
    rangePrice = RangeValues(0, 999999);
    beginPrice.text = "0";
    endPrice.text = "999,999";
    screenSize.forEach((size) {
      size['check'] = false;
    });
    os.forEach((os) {
      os['check'] = false;
    });
    productType.forEach((prod) {
      prod['check'] = false;
    });
    screenResolution.forEach((scr) {
      scr['check'] = false;
    });
    brand.forEach((b) {
      b['check'] = false;
    });
    Get.find<HomePageController>().onFilterProduct({
      "brand": [],
      "screenSize": [],
      "screenResolution": [],
      "os": [],
      "productType": [],
      "price": {"begin": 0, "end": 999999}
    });
    update();
  }
}
