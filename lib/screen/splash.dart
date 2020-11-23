import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';
import 'package:task3/screen/registration.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu,
                       color: Colors.white,
                       size: 36.0,),
                       actions: [
            IconButton(icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 36.0,
                        ),
                        onPressed:
                         null),],
        title: Text("Linux App",style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 23),),
                          
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Container(
          color: Colors.yellow[200],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: <Widget>[
              Image.asset('assets/linux.png'),
              SizedBox(height: 5),
              Material(
                borderRadius: BorderRadius.circular(100
                ),
                color: Colors.indigo,
                child: MaterialButton(
                  minWidth: 280,
                  height: 50,
                  child: Text("Welcome",style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 23)),
                  
                  onPressed: () {
                    Navigator.pushNamed(context, "register");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Register();
  }
}