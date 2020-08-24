import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../AppData.dart';
import '../Model/Product.dart';

class Comments extends StatefulWidget {
  Product product_instanse;
  List<dynamic> comment_list;
  Comments(this.product_instanse, this.comment_list);

  @override
  _CommentsView createState() => _CommentsView(product_instanse, comment_list);
}

class _CommentsView extends State<Comments> {

  int page =1;
  int more_data=1;

  ScrollController _scrollController = new ScrollController();
  void initState(){
    _scrollController.addListener(() {
       if (_scrollController.position.pixels==_scrollController.position.maxScrollExtent){
         _loadData(widget.product_instanse);
       }
    });
  }

  _CommentsView(product_instanse, List<dynamic> comment_list) {
    if (comment_list.length == 0) {
      _loadData(product_instanse);
    }
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = more_data==1?widget.comment_list.length+1:widget.comment_list.length;
    return widget.comment_list.length>0 ?
        Stack(children: [ListView.builder(
          controller: _scrollController,
          itemBuilder: (BuildContext contex, index) {
            return comment_row(index);
          },
          itemCount: itemCount,
        ),Positioned(bottom: 25,right: 25,child:
        FloatingActionButton(onPressed: (){},child: Icon(Icons.add),backgroundColor: Colors.red,),)],)
        :Container(child: Center(child: CircularProgressIndicator(),),);
  }

  Widget comment_row(int index) {
    double w = MediaQuery.of(context).size.width-30;
    if (index==widget.comment_list.length){
      return Container(height: 100,width: w, child: Center(child: CircularProgressIndicator(),),);
    }
    else{
      return Container( decoration: BoxDecoration(border:Border.all(color: Colors.grey[400],width: 1), ),
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(padding: EdgeInsets.all(10),
              child: Row(children: [
                Expanded(child: Text(" ارسالی از :"+widget.comment_list[index]['name']),
                )
                ,Expanded(child: Text("تاریخ ثبت : 1399/06/01",textAlign: TextAlign.right,))
              ],),
              width: w,color: Colors.grey[200],)
            ,Container(width: w,padding: EdgeInsets.all(10), child: Text(widget.comment_list[index]['content']),color: Colors.white,)
          ],
        ),

      );
    }
  }

  void _loadData(Product product_instanse){
    http
        .get(AppData.App_URL + 'comment/' + product_instanse.id+'&'+page.toString(),
        headers: AppData.userHeader)
        .then((response) => {
      if (response.statusCode == 200)
        {
          setState(() {
            if (response.body=="[]")
              {
                more_data = 0;
              }
            else {
              widget.comment_list =
                  widget.comment_list + convert.jsonDecode(response.body);
            }
          })
          ,
          page=page+1

        }
    });
  }
}
