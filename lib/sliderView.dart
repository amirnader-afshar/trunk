import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'Model/AppSlider.dart';

class HomeSlider extends StatefulWidget {
  @override
  _HomeSliderState createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  List<Appslider> sliderList = [];

  int slider_position = 0;

  void getSlider() {
    if (sliderList.length == 0) {
      var url = "http://192.168.2.131:3000/api/slides";
      Map<String, String> userHeader = {
        "Content-type": "application/json",
        "x-auth":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZjI2OWVhMjlmYTVjNjQ1NTRmNGY5YjMiLCJhY2Nlc3MiOiJhdXRoIiwiaWF0IjoxNTk2NjE2MTAxfQ.nwb0AYA85192qnOh2dQg1M1qO7L4i969QYt5wBNrTCg"
      };
      http.get(url, headers: userHeader).then((response) {
        print(response.statusCode);
        if (response.statusCode == 200) {
          List jsonResponse = convert.jsonDecode(response.body);
          for (int i = 0; i < jsonResponse.length; i++) {
            setState(() {
              sliderList.add(new Appslider(
                code: jsonResponse[i]['code'],
                titel: jsonResponse[i]['titel'],
                img_url: jsonResponse[i]['img_url'],
                text: jsonResponse[i]['text'],
                action: jsonResponse[i]['action'],
              ));
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getSlider();
    print(sliderList);

    return

      Container(
        child: sliderList.length > 0
            ? Stack(
          children: <Widget>[
            PageView.builder(
              itemBuilder: (context, position) {
                return sliderView(position);
              },
              itemCount: sliderList.length,
              onPageChanged: (position) {
                setState(() {
                  slider_position = position;
                });
              },
            ),
            Container(
              child: Center(child: slider_footer()),
              margin: EdgeInsets.only(top: 170),
            )
          ],
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
        height: 200,
      );


  }
  Widget sliderView(int position) {
    return Image(
      image: NetworkImage(sliderList[position].img_url),
      fit: BoxFit.fitWidth,
    );
  }

  Widget slider_footer() {
    List<Widget> slider_footer_item = [];
    for (int i = 0; i < sliderList.length; i++) {
      i == slider_position
          ? slider_footer_item.add(_Active())
          : slider_footer_item.add(_inActive());
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: slider_footer_item,
    );
  }

  Widget _Active() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: 10,
      height: 10,
    );
  }

  Widget _inActive() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: 10,
      height: 10,
    );
  }
}
