import 'package:flutter_afshar_app/Model/Product.dart';
import 'sharedPref.dart';
import 'package:flutter/material.dart';


class Cart{

  String pid;
  int price;
  String title;

  Cart({this.pid,this.price,this.title});

  Cart.fromJson(Map<String, dynamic> json) {
    pid= json['pid'];
    price= json['price'];
    title= json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['price'] = this.price;
    data['title'] = this.title;

    return data;
  }
  static Future<bool> add_product_cart(Product product) async{

//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    List<Cart> _Cartlist = List<Cart>();
//
//    Cart _Cart = new Cart();
//    _Cart.pid= product.id;
//
//    if (prefs.getString('Card')!=null) {
//      _Cartlist = jsonDecode(prefs.getString('Card'));
//    }
//    if (_Cartlist.indexOf(_Cart)>0) {
//      print('mojod');
//    }
//    else
//      {
//        _Cart.price =  product.price;
//        _Cart.title = product.title;
//        _Cartlist.add(_Cart);
//        prefs.setString('Card', jsonEncode(_Cartlist));
//      }
//
//    print( _Cartlist.toString());
    SharedPref sharedPref = SharedPref();
      try {
      Cart _Cart = new Cart();
      _Cart.pid= product.id;
      sharedPref.save("card", _Cart);
      Cart c = Cart.fromJson(await sharedPref.read("card"));
      print (c.toJson());
    } catch (Excepetion) {
        print(Excepetion.toString());
    }

  }

}