import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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

  String title = "";
  String img_url = "";
  String content = "";
  int tab_index = 0;


  _ProductPageState(product_instanse) {
    http
        .get(AppData.App_URL + 'product/' + product_instanse.id,
            headers: AppData.userHeader)
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
    String titel = "";
    titel = widget.product_instanse.title;
    titel = titel.length > 30 ? titel.substring(0, 30) + ' .... ' : titel;
    return !titel.isEmpty
        ? SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image(
                  image: NetworkImage(img_url),
                ),
                Text(title),
                Text(content)
              ],
            ),
          )
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget _comment_Screen() {
   // return CommentForm(widget.product_instanse);
    return Comments(widget.product_instanse);
  }

  Widget _gallery_Screen() {
    return Container(
      child: Center(
        child: Text("gallery"),
      ),
    );
  }


}
