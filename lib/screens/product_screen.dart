import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/Product.dart';
import '../AppDate.dart';

class ProductPage extends StatefulWidget {
  Product product_instanse;

  ProductPage(Product pi){
    product_instanse = pi;
  }

  @override
  _ProductPageState createState() => _ProductPageState(product_instanse);
}

class _ProductPageState extends State<ProductPage> {
  _ProductPageState(product_instanse){

    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "x-auth":AppDate.Token
    };

    http.get(AppDate.App_URL+'product/'+product_instanse.id, headers: userHeader).then((response){

      if (response.statusCode==200){
        dynamic jsonresponse=convert.jsonDecode(response.body);
        print(jsonresponse[0]['name']);
      }

    });
  }



  @override
  Widget build(BuildContext context) {
    print (widget.product_instanse.id);
    String titel="";
    titel = widget.product_instanse.title;
    titel = titel.length>30?titel.substring(0,30)+' .... ' : titel;
    return MaterialApp(home: Scaffold(
      appBar: AppBar(backgroundColor: Colors.red,
          title: Text(titel),
          ),
      body: SingleChildScrollView(child: Column(children: <Widget>[],),),
    ),);
  }
}
