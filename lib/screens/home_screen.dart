import 'package:flutter/material.dart';
import 'package:flutter_afshar_app/Model/Product.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<Product> products = [];

  void getNewProduct() {
    var url = "http://192.168.2.131:3000/api/product";
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "x-auth":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZjI2OWVhMjlmYTVjNjQ1NTRmNGY5YjMiLCJhY2Nlc3MiOiJhdXRoIiwiaWF0IjoxNTk2MzY2NTcyfQ.A1bc4JZ4VSAnuBIFNWB8DRXXrIIKktN6tbsJoOB5_pE"
    };
    http.get(url, headers: userHeader).then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
        List jsonResponse = convert.jsonDecode(response.body);
        for (int i = 0; i < jsonResponse.length; i++) {
          setState(() {
            products.add(new Product(
                title: jsonResponse[i]['name'],
                price: jsonResponse[i]['price'],
                img_url: jsonResponse[i]['img_url']));
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (products.length == 0) {
      getNewProduct();
      print(products);
    }
    return Column(
      children: <Widget>[
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
        products.length > 0
            ? Container(
                height: 270,
                child: ListView.builder(
                  itemBuilder: listRow,
                  itemCount: products.length,
                  scrollDirection: Axis.horizontal,
                ),
              )
            : Container(
                height: 270,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
      ],
    );
  }

  Widget listRow(BuildContext context, int index) {
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
            image: NetworkImage(products[index].img_url),
          )),
          Text(products[index].title),
          Divider(
            color: Colors.grey,
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(
              products[index].price.toString(),
              textAlign: TextAlign.left,
            ),
            width: 210,
          )
        ],
      ),
    );
  }
}
