import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_afshar_app/Model/Product.dart';
import 'package:flutter_afshar_app/sliderView.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Model/Product.dart';
import '../screens/product_screen.dart';
import '../AppData.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<Product> new_products = [];
  List<Product> order_products = [];

  void getProductList(String action, List<Product> list) {
    if (list.length == 0) {
      var url = AppData.App_URL + action;
      Map<String, String> userHeader = {
        "Content-type": "application/json",
        "x-auth": AppData.Token
      };
      http.get(url, headers: userHeader).then((response) {
        print(response.statusCode);
        if (response.statusCode == 200) {
          List jsonResponse = convert.jsonDecode(response.body);
          for (int i = 0; i < jsonResponse.length; i++) {
            setState(() {
              list.add(new Product(
                  title: jsonResponse[i]['name'],
                  price: jsonResponse[i]['price'],
                  img_url: jsonResponse[i]['img_url'],
                  id: jsonResponse[i]['_id']));
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getProductList('product', new_products);
    getProductList('product', order_products);
    print(new_products);

    return Scaffold(
        drawer: Drawer(
            child: Container(
                child: Column(
          children: <Widget>[
            Container(
              height: 120,
              color: Colors.red,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ))),
        appBar: AppBar(
            title: Text("فروشگاه من"),
            backgroundColor: Colors.red,
            elevation: 0,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
            ]),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HomeSlider(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text("جدیدترین محصولات")),
                    Expanded(
                        child: Text(
                      " نمایش همه > ",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.blue),
                    ))
                  ],
                ),
              ),
              new_products.length > 0
                  ? Container(
                      height: 220,
                      child: ListView.builder(
                        itemBuilder: newProductsList,
                        itemCount: new_products.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  : Container(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text("پرفروش ترین محصولات")),
                    Expanded(
                        child: Text(
                      " نمایش همه > ",
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.blue),
                    ))
                  ],
                ),
              ),
              order_products.length > 0
                  ? Container(
                      height: 220,
                      child: ListView.builder(
                        itemBuilder: orderProductList,
                        itemCount: order_products.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    )
                  : Container(
                      height: 200,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
            ],
          ),
        ));
  }

  Widget newProductsList(BuildContext context, int index) {
    return indexProductView(index, new_products);
  }

  Widget orderProductList(BuildContext context, int index) {
    return indexProductView(index, order_products);
  }

  Widget indexProductView(int index, List<Product> list) {
    String price = "";
    String toman = " تومان ";
    var formater = new NumberFormat('###,###');
    price = formater.format(list[index].price) + toman;

    String title = list[index].title.length > 25
        ? list[index].title.substring(0, 25) + ' ...'
        : list[index].title;

    return Container(
      width: 210,
      margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white70),
      child: Column(
        children: <Widget>[
          Container(
              child: Image(
            image: NetworkImage(list[index].img_url),
            height: 150,
          )),
          GestureDetector(
            child: Text(title),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProductPage(list[index])));
            },
          ),
          Divider(
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(
              price,
              textAlign: TextAlign.left,
            ),
            width: 210,
          )
        ],
      ),
    );
  }
}
