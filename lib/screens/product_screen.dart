import 'package:flutter/material.dart';

import '../Model/Product.dart';

class ProductPage extends StatefulWidget {
  Product product_instanse;

  ProductPage(Product pi){
    product_instanse = pi;
  }

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
