import 'package:flutter/material.dart';
import 'package:flutter_afshar_app/AppData.dart';
import 'package:flutter_afshar_app/Cart.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  @override
  CartView createState() => CartView();
}

class CartView extends State<CartScreen> {
  int cartPrice =0;
  String cartPriceText;
  List<Cart> model_list =  new List();
  CartView(){
    _getCartData();
  }

  @override
  Widget build(BuildContext context) {


    return Material(child: Scaffold(

      appBar: AppBar(backgroundColor: Colors.red,title: Text("سبد خرید"),
        actions: [
          model_list.length>0? IconButton(icon: Icon(Icons.delete),onPressed: (){
            AlertDialog ald = AlertDialog(content: Text("آیا اطمیان دارید؟"),
              actions: [
                RaisedButton(onPressed: (){
                  Cart.Empaty_Cart().then((value) => {
                    Navigator.pop(context),
                    if (value)
                      {
                        setState((){
                          model_list=[];
                        })
                      }
                  });


                },child: Text("بله"),)
                , RaisedButton(onPressed: (){Navigator.pop(context);},child: Text("خیر"),)
              ],);
            showDialog(context: context,builder:(context) => ald);
          }
          ,)
              :Text("")

        ],
      ),

      body: Container(child:
        model_list.length>0 ?
           Column(children: [
             Flexible(child: Container( child: ListView.builder(itemBuilder: (context,index)=>_cartRow(index),itemCount: model_list.length,),),)
            , Container(color: Colors.green[100],margin: EdgeInsets.all(15),padding: EdgeInsets.all(15), child: Row(children: [
               Expanded(child: Text("جمع کل")),
               Expanded(child: Text(cartPriceText),),
               RaisedButton(onPressed: (){},child: Text("نهایی کردن خرید "),)
             ],),)

           ],)
        : Center(child: Text("محصولی به سبد خرید اضافه نشده است "))
        ,),

    ),);
  }

  _getCartData(){
    var formatter = new NumberFormat("###,###");


    Cart.Return_Product_list().then((value) => {
      if (value!=null)
        {
          setState((){
            model_list=value;
            cartPrice=0;
            for (var i in model_list) {
              cartPrice += i.price * i.count;
            }
            cartPriceText=formatter.format(cartPrice);
          })
        }

    });
  }

  Widget _cartRow(int index){
    var formatter = new NumberFormat("###,###");
    String price=formatter.format(model_list[index].price);

    int totalprice =model_list[index].price*model_list[index].count;

    String price2 =formatter.format(totalprice).toString()+" تومان ";

    return Container(child: Column(children: [
      Row(children: [
        Expanded(child: Image(image: NetworkImage(model_list[index].imgUrl),),),
        Expanded(child: Text(model_list[index].title),),
          ],)

      ,Container(
          color: Colors.grey[300],
            padding: EdgeInsets.all(5),
            child: Row(children: [
                              Expanded(child: Text("قیمت واحد"))
                              ,Expanded(child: Text(price,style: TextStyle(color: Colors.green),))
                          ],
                     )
        ,)
      ,Divider(color: Colors.green[600],height: 2,)
      ,Container(
          color: Colors.grey[300],
            padding: EdgeInsets.all(5),
            child: Row(children: [
                              Expanded(child: Text("قیمت کل"))
                              ,Expanded(child: Text(price2,style: TextStyle(color: Colors.green),))
                          ],
                     )
        ,)
      ,Row (children: [
        Expanded(child: Row(children: [
          IconButton(icon: Icon(Icons.add),onPressed: () => {
            Cart.add_product_cart(Cart.toproduct(model_list[index])).then((value) => {
              setState((){
                _getCartData();
              })
            })
          },),
          Text(model_list[index].count.toString(),style: TextStyle(color: Colors.green)),
          IconButton(icon: Icon(Icons.remove),onPressed: () => {

          Cart.Reduce_product_cart(Cart.toproduct(model_list[index])).then((value) => {
          setState((){
          _getCartData();
          })
          })

          },),
        ],),),
        Expanded(child: GestureDetector(child:
        Container(color: Colors.red, child: Text("حذف",style: TextStyle(color: Colors.black),textAlign: TextAlign.center,),width: MediaQuery.of(context).size.width,)
          ,onTap: (){
            Cart.Remove_product_cart(Cart.toproduct(model_list[index])).then((value) => {
              setState((){
                _getCartData();
              })
            });
          },),)
      ],)
        ]


    )
      ,decoration: BoxDecoration(color: Colors.grey[50],border: Border.all(color: Colors.grey,width: 1)),
      margin: EdgeInsets.all(10),
    );
  }

}
