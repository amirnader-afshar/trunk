import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../AppData.dart';
import '../Model/Product.dart';

class Comments extends StatefulWidget {
  Product product_instanse;
  Comments(this.product_instanse);

  @override
  _CommentsView createState() => _CommentsView(product_instanse);
}

class _CommentsView extends State<Comments> {

  List<dynamic> comment_list=[];
  _CommentsView(product_instanse) {
    http
        .get(AppData.App_URL + 'comment/' + product_instanse.id,
            headers: AppData.userHeader)
        .then((response) => {
          if (response.statusCode==200){
            comment_list=convert.jsonDecode(response.body),
            print(comment_list)
          }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("comments"));
  }
}
