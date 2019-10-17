import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aksc/login.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 6),()=>Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Login())));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    //Color(0x29667B),
                     Colors.blue.shade900,
                     Colors.blue.shade500
                  ]
              ),
              //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
            ),
            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height:80),
                            Image.asset("assets/acmlogonew.png",width: MediaQuery.of(context).size.width/0.5,height:300,),
                            //Loader(),
                            SizedBox(height:40),
                            FAProgressBar(
                              animatedDuration: Duration(milliseconds: 5212),
                              displayText: "%",
                              currentValue: 100,
                              maxValue: 100,
                              backgroundColor: Colors.blue.shade500,
                              changeProgressColor: Colors.blue.shade600,
                              progressColor: Colors.green,
                              borderRadius: 30,
                              changeColorValue: 2,
                            ),
                          ],
                        ),
          ),
      ),
    );
  }
}
