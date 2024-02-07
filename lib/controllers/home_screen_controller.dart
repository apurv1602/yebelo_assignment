import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeController extends ChangeNotifier {
  int selectedCategoryIndex = 0;
  int total_cost = 0;
  Set<String> category = {};
  List<String> categories = ["All"];
  var productsList = [];
  var productsListCopy = [];
  int cart_items = 0;

  filterProducts(String cat) {
    if (cat == "All") {
      productsList = productsListCopy;
      notifyListeners();
      return;
    }

    productsList = [];

    for (var product in productsListCopy) {
      if (product['p_category'] == cat) {
        productsList.add(product);
      }
    }

    notifyListeners();
  }

  set selectCategory(value) {
    selectedCategoryIndex = value;
    notifyListeners();
  }

  HomeController() {
    readDataFromJson();
  }

  updateQty(fun) {
    fun();
    notifyListeners();
  }

  readDataFromJson() async {
    var data = await rootBundle.loadString('lib/services/data.json');
    productsList = jsonDecode(data);
    productsListCopy = productsList;
    for (var product in productsList) {
      category.add(product['p_category']);
    }
    categories.addAll(category.toList());
    notifyListeners();
  }
}
