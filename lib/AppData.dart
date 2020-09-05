import 'package:flutter/material.dart';


class AppData {
 // static String App_URL = "http://192.168.1.15:3000/api/";
  static String App_URL = "http://192.168.2.131:3000/api/";
  static String Token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZjI2OWVhMjlmYTVjNjQ1NTRmNGY5YjMiLCJhY2Nlc3MiOiJhdXRoIiwiaWF0IjoxNTk2NjE2MTAxfQ.nwb0AYA85192qnOh2dQg1M1qO7L4i969QYt5wBNrTCg";
  static final Map<String, String> userHeader = {
    "Content-type": "application/json",
    "x-auth": AppData.Token
  };


  static GoNewScreen(BuildContext context,Widget screen,double x,double y){
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (BuildContext context,
                Animation<double> Animation,
                Animation<double> SecondAnimation) {
              return screen;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> Animation,
                Animation<double> SecondAnimation,
                Widget child) {
              return SlideTransition(position: new Tween<Offset>(
                  begin: Offset(x,y),end: Offset.zero
              ).animate(Animation)
                ,child:child ,);
            },
            transitionDuration: Duration(milliseconds: 1000)));

  }
}