import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:intl/intl.dart';

import '../Model/Product.dart';
import '../AppData.dart';
import 'CommentForm.dart';
import 'Comments.dart';

class ProductPage extends StatefulWidget {
  Product product_instanse;

  ProductPage(Product pi) {
    product_instanse = pi;
  }

  @override
  _ProductPageState createState() => _ProductPageState(product_instanse);
}

class _ProductPageState extends State<ProductPage> {
  List<dynamic> comment_list = [];
  String title = "";
  String img_url = "";
  String price = '0';
  String content = "";
  int tab_index = 0;

  _ProductPageState(product_instanse) {
    _getProduct(product_instanse);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(title),
        ),
        body: (_children(tab_index)),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.title), title: Text("توضیحات")),
            BottomNavigationBarItem(
                icon: Icon(Icons.comment), title: Text("نظرات")),
            BottomNavigationBarItem(
                icon: Icon(Icons.image), title: Text("تصاویر")),
          ],
          onTap: (index) {
            setState(() {
              tab_index = index;
            });
          },
          currentIndex: tab_index,
          backgroundColor: Colors.deepOrangeAccent,
          fixedColor: Colors.white70,
          unselectedItemColor: Colors.black,
        ),
      ),
    );
  }

  Widget _children(int tab_index) {
    List<Widget> page_screen = [];

    page_screen.add(_tozihat_screen());
    page_screen.add(_comment_Screen());
    page_screen.add(_gallery_Screen());

    return page_screen[tab_index];
  }

  Widget _tozihat_screen() {
    //double content_height=MediaQuery.of(context.size.height)-50;
    String titel = "";
    titel = widget.product_instanse.title;
    titel = titel.length > 30 ? titel.substring(0, 30) + ' .... ' : titel;
    return !titel.isEmpty
        ? Column(children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image(
                    image: NetworkImage(img_url),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      titel,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20),
                    ),
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                      child: Text(
                    content,
                    textAlign: TextAlign.right,
                  )),
                ],
              ),
            )),
            Container(
              color: Colors.green,
              height: 50,
              child: Center(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        price,
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                    Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ])
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget _comment_Screen() {
    // return CommentForm(widget.product_instanse);
    return Comments(widget.product_instanse, comment_list);
  }

  Widget _gallery_Screen() {
    return Container(
      child: Center(
        child: Text("gallery"),
      ),
    );
  }

  _getProduct(Product product) async
  {
    await http.get(AppData.App_URL + 'product/' + product.id,
        headers: AppData.userHeader)
        .then((response) {
      if (response.statusCode == 200) {
        dynamic jsonresponse = convert.jsonDecode(response.body);
        setState(() {
          title = jsonresponse[0]['name'];
          img_url = jsonresponse[0]['img_url'];
          content = jsonresponse[0]['content'];
          var formatter = new NumberFormat('###,###');
          price = formatter.format(jsonresponse[0]['price']) + " تومان ";
        });
      }
    });
  }
}
