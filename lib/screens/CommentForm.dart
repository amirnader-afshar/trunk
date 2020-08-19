import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../AppData.dart';
import '../Model/Product.dart';

class CommentForm extends StatefulWidget {
  Product product_instanse;
  CommentForm(this.product_instanse);

  int send = 0;
  String _name = "";
  String _email = "";
  String _content = "";
  final _formkey = GlobalKey<FormState>();

  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {

  int send = 0;
  String _name = "";
  String _email = "";
  String _content = "";
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        SingleChildScrollView(
            child: Container(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onSaved: (String value) {
                                _name = value;
                              },
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'لطفا نام و نام خانوادگی خود را واردکنید ';
                                }
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.red,
                                  ),
                                  labelText: "نام و نام خانوادگی",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onSaved: (String value) {
                                _email = value;
                              },
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'لطفا ایمیل خود را واردکنید ';
                                }
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.red,
                                  ),
                                  labelText: "e-mail",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              onSaved: (String value) {
                                _content = value;
                              },
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'لطفا نظر خود را واردکنید ';
                                }
                              },
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              minLines: 5,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.comment,
                                    color: Colors.red,
                                  ),
                                  labelText: "نظر",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5)))),
                            ),
                          ),
                          ButtonTheme(
                            height: 50,
                            minWidth: MediaQuery.of(context).size.width,
                            child: RaisedButton(
                              onPressed: () {
                                if (_formkey.currentState.validate()) {
                                  _send_comment_data();
                                }
                              },
                              child: Text(
                                "ثبت",
                                style: TextStyle(color: Colors.white70),
                              ),
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    )))),
        send == 1
            ? Opacity(
          opacity: 0.6,
          child: Container(
            color: Colors.white70,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        )
            : Text("")
      ],
    );
  }

  void _send_comment_data() {

    _formkey.currentState.save();
    setState(() {
      send = 1;
    });

    http
        .post(AppData.App_URL + 'comment',
        headers: AppData.userHeader,
        body: convert.jsonEncode({
          "id": widget.product_instanse.id,
          "name": _name,
          "email": _email,
          "content": _content
        }))
        .then(
            (value) => {
          print(value.body),
          setState(() {
            send = 0;
            _formkey.currentState.reset();
          })
        }
    );

    print("name:${_name}");
  }

}
