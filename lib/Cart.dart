import 'package:flutter_afshar_app/Model/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart{

  static Future<bool> add_product_cart(Product product) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Card', product.toString());
  }

}