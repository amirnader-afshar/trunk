import 'dart:convert';
import 'package:flutter_afshar_app/Model/Product.dart';
import 'sharedPref.dart';

class Cart{
  String pid;
  int price;
  String title;
  int count ;

  Cart({this.pid,this.price,this.title,this.count});

  Cart.fromJson(Map<String, dynamic> json) {
    pid= json['pid'];
    price= json['price'];
    title= json['title'];
    count =json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['price'] = this.price;
    data['title'] = this.title;
    data['count'] = this.count;
    return data;
  }
  static Future<bool> add_product_cart(Product product) async{

   try
   {
      var loadeModels = await Return_Product_list();
      var i =  loadeModels.indexWhere((Cart) => Cart.pid.contains(product.id));
      if (i < 0){
        Cart _Cart = new Cart();
        _Cart.pid= product.id;
        _Cart.title = product.title;
        _Cart.price = product.price;
        _Cart.count = 1;
        loadeModels.add(_Cart);
      }
      else
        {
          loadeModels[i].count+=1;
        }

      Save_Product_list(loadeModels);

    } catch (Excepetion) {
        print(Excepetion.toString());
    }

  }
  static Future<bool> Remove_product_cart(Product product) async {
    try {
      var loadeModels = await Return_Product_list();
      var i = loadeModels.indexWhere((Cart) => Cart.pid.contains(product.id));
      if (i > 0) {
        loadeModels[i].count-=1;
        if (loadeModels[i].count==0) {
          loadeModels.removeAt(i);
        }
        Save_Product_list(loadeModels);
        }
    } catch (Excepetion) {
      print(Excepetion.toString());
      }
  }
  static Future<List<Cart>> Return_Product_list() async{
    SharedPref sharedPref = SharedPref();
    try {

      var jstr = await sharedPref.read("card");

      if (jstr == null) {

      }  else{
        return  (json.decode(jstr) as List).map((i) =>
            Cart.fromJson(i)).toList();
      }
    } catch (Excepetion) {
      print(Excepetion.toString());
    }
}
  static Future<bool> Save_Product_list(List<Cart> list) async
  {
    SharedPref sharedPref = SharedPref();
    try
        {
          var js = jsonEncode(list.map((e) => e.toJson()).toList());
          sharedPref.save("card", js);
          print(await sharedPref.read("card"));
        }
      catch(Excepetion)
    {
      print(Excepetion.toString());
    }
  }
  static Future<bool> Empaty_Cart() async
  {
    SharedPref sharedPref = SharedPref();
    try {
       await sharedPref.remove("card");

    } catch (Excepetion) {
      print(Excepetion.toString());
    }
  }
}