import 'package:flutter/material.dart';
import 'package:flutter_afshar_app/Model/Product.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../Model/Product.dart';
import '../Model/AppSlider.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<Product> new_products = [];
  List<Product> order_products = [];
  List<Appslider>  sliderList =[];


  void getProductList(String action,List<Product> list) {
    if (list.length == 0) {
      var url = "http://192.168.2.131:3000/api/" + action;
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
              list.add(new Product(
                  title: jsonResponse[i]['name'],
                  price: jsonResponse[i]['price'],
                  img_url: jsonResponse[i]['img_url']));
            });
          }
        }
      });
    }
  }


  void getSlider() {
    if (sliderList.length == 0) {
      var url = "http://192.168.2.131:3000/api/slides" + ;
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
              sliderList.add(new Appslider(
                  titel: jsonResponse[i]['titel'],
                  code:  jsonResponse[i]['code'],
                  img_url: jsonResponse[i]['img_url']));
            });
          }
        }
      });
    }



    List<Widget> sliders = [];
  @override
  Widget build(BuildContext context) {

    sliders.add(Center(child: Text("Slide1"),));
    sliders.add(Center(child: Text("Slide2"),));
    sliders.add(Center(child: Text("Slide3"),));

      getProductList('product',new_products);
      getProductList('product',order_products);
      print(new_products);

    return SingleChildScrollView(child: Column(
      children: <Widget>[
        Container(child: PageView.builder(itemBuilder: (context,position){
          return sliders[position];
        },itemCount: sliders.length,)
          ,height: 200,),
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
          height: 270,
          child: ListView.builder(
            itemBuilder: newProductsList,
            itemCount: new_products.length,
            scrollDirection: Axis.horizontal,
          ),
        )
            : Container(
          height: 270,
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
          height: 270,
          child: ListView.builder(
            itemBuilder: orderProductList,
            itemCount: order_products.length,
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
    ),);
  }

  Widget newProductsList(BuildContext context, int index) {
    return indexProductView(index, new_products);
  }
  Widget orderProductList(BuildContext context, int index) {
    return indexProductView(index, order_products);
  }


Widget indexProductView(int index,List<Product> list){
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
            )),
        Text(list[index].title),
        Divider(
          color: Colors.grey,
        ),
        Container(
          margin: EdgeInsets.only(left: 15),
          child: Text(
            list[index].price.toString(),
            textAlign: TextAlign.left,
          ),
          width: 210,
        )
      ],
    ),
  );
}
}
