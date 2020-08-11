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

  final _formkey=GlobalKey<FormState>();
  String title = "";
  String img_url = "";
  String content = "";
  int  tab_index=0;

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


    return MaterialApp(
      home:  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(title),
        ),
        body:
          (
              _children(tab_index)
          ),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.title),title: Text("توضیحات")),
          BottomNavigationBarItem(icon: Icon(Icons.comment),title: Text("نظرات")),
          BottomNavigationBarItem(icon: Icon(Icons.image),title: Text("تصاویر")),


        ],onTap: (index){
          setState(() {
            tab_index=index;
          });
        }
        ,currentIndex: tab_index,backgroundColor: Colors.deepOrangeAccent,fixedColor: Colors.white70,
        unselectedItemColor: Colors.black,),
      ),
    );
  }

  Widget _children(int tab_index) {

    List<Widget> page_screen=[];

    page_screen.add(_tozihat_screen());
    page_screen.add(_comment_Screen());
    page_screen.add(_gallery_Screen());

    return page_screen[tab_index];

  }

  Widget _tozihat_screen(){
    String titel = "";
    titel = widget.product_instanse.title;
    titel = titel.length > 30 ? titel.substring(0, 30) + ' .... ' : titel;
    return     !titel.isEmpty?SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image(image: NetworkImage(img_url),)
          ,Text(title)
          ,Text(content)
        ],
      ),
    )
        :Container(child: Center(child: CircularProgressIndicator(),),);
  }


 Widget _comment_Screen(){

    return SingleChildScrollView(child: Container(child:  Padding(
      padding: const EdgeInsets.all(20),
      child: Form(key:, child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.person,color: Colors.red,),labelText: "نام و نام خانوادگی",
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))
          )
            ,),
        ),      Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.email,color: Colors.red,),labelText: "e-mail",
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))
          )
            ,),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(keyboardType: TextInputType.multiline,maxLines: null,minLines: 5,decoration: InputDecoration(prefixIcon: Icon(Icons.comment,color: Colors.red,),labelText: "نظر",
              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)))
          )
            ,),
        ),
        ButtonTheme(height: 50,minWidth: MediaQuery.of(context).size.width,child:RaisedButton(onPressed: (){},child: Text("ثبت",style: TextStyle(color: Colors.white70),),color: Colors.red,)
          ,)
      ],),)
    )));
 }
 Widget _gallery_Screen(){

    return Container(child: Center(child: Text("gallery"),),);
 }
}
