import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/home_screen.dart';
import 'package:flutter_afshar_app/Cart.dart';


void main()=>runApp(homePage());


class homePage extends StatelessWidget
{



  @override
  Widget build(BuildContext context)
  {

    return MaterialApp(
      theme:ThemeData(fontFamily:'Sans',primaryColor:Colors.green[600]),
      title: "فروشگاه من",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner:false,
      supportedLocales: [
        const Locale('fa',)
      ],
      home: Material(
          color:Colors.white,
          child:homepage()
      ),

    );
  }

}



