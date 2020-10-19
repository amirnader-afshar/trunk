import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  CartView createState() => CartView();
}

class CartView extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(child: Scaffold(

      appBar: AppBar(title: Text("سبد خرید"),
        actions: [
          IconButton(icon: Icon(Icons.delete),onPressed: (){}
          ,)

        ],
      ),


    ),);
  }
}
