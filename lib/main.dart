import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/home_screen.dart';

void main(){
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'byekan'),

      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fa', ''),//farsi
      ],
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(child: Container(
          child: Column(children: <Widget>[
            ListTile(title: Text("ورود"),onTap: (){
              print("login");
            },)
            ,ListTile(title: Text("ثبت نام"),onTap: (){
              print("signup");
            },)

          ],),
        ),),
        appBar: AppBar(backgroundColor: Colors.red,
        title: Text("فروشگاه من"),
        actions: <Widget>[IconButton(icon:Icon( Icons.search),onPressed: (){})
        ,IconButton(icon:Icon( Icons.shopping_cart),onPressed: (){}),
      ]),
      body: homepage(),
      ),
    )
  );
}