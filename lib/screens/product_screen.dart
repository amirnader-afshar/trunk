import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../Model/Product.dart';
import '../AppData.dart';

class ProductPage extends StatefulWidget {
  Product product_instanse;

  ProductPage(Product pi) {
    product_instanse = pi;
  }

  @override
  _ProductPageState createState() => _ProductPageState(product_instanse);
}

class _ProductPageState extends State<ProductPage> {
  String title = "";
  String img_url = "";
  String content = "";

  _ProductPageState(product_instanse) {
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "x-auth": AppData.Token
    };

    http.get(AppData.App_URL + 'product/' + product_instanse.id,
            headers: userHeader)
        .then((response) {
      if (response.statusCode == 200) {
        dynamic jsonresponse = convert.jsonDecode(response.body);
        setState(() {
          title = jsonresponse[0]['name'];
          img_url = jsonresponse[0]['img_url'];
          content = jsonresponse[0]['content'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String titel = "";
    titel = widget.product_instanse.title;
    titel = titel.length > 30 ? titel.substring(0, 30) + ' .... ' : titel;
    return MaterialApp(
      home: DefaultTabController(length: 3,child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
              tabs: <Widget>[
            Tab(text: "توضیحات محصول",icon: Icon(Icons.title),)
           , Tab(text: "نظرات ",icon: Icon(Icons.comment),)
            ,Tab(text: "گالری",icon: Icon(Icons.image),)


          ]),
          backgroundColor: Colors.red,
          title: Text(titel),
        ),
        body: TabBarView(children: <Widget>[
          (
              !titel.isEmpty?SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Image(image: NetworkImage(img_url),)
                    ,Text(title)
                    ,Text(content)
                  ],
                ),
              )
                  :Container(child: Center(child: CircularProgressIndicator(),),)
          ),
          Container(child: Center(child: Text("comment"),),)
          ,Container(child: Center(child: Text("galery"),),)

        ],),
      ),)
    );
  }
}
