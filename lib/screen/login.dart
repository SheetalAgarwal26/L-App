import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task3/animation/fadeanimation.dart';
import 'package:task3/screen/command.dart';
import 'package:task3/screen/registration.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var authc = FirebaseAuth.instance;
  String email;
  String password;
  bool ssloader = false;
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
      body: ModalProgressHUD(
        inAsyncCall: ssloader,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/l.jpg'),fit: BoxFit.cover),
             color: Colors.black),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 100),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(
                        1.1,
                        Text("",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                      ),
                      FadeAnimation(
                          1.3,
                          Text("",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18))),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(35),
                          topLeft: Radius.circular(35))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      color: Colors.white,
                      child: Column(children: [
                        SizedBox(height: 30),
                        FadeAnimation(
                            1.6,
                            Container(
                              color: Colors.white,
                              child: TextField(
                                onChanged: (value) {
                                  email = value;
                                },
                                decoration: InputDecoration(
                                    icon: Icon(Icons.mail,size: 40),
                                  labelText: "Enter Email",
                                  hintText: "email",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                        
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: 20),
                        FadeAnimation(
                            1.9,
                            Container(
                              color: Colors.white,
                              child: TextField(
                                obscureText: true,
                                onChanged: (value) {
                                  password = value;
                                },
                                decoration: InputDecoration(
                                    icon: Icon(Icons.lock_outline,size: 40),
                                  labelText: "Enter Password",
                                  hintText: "password",
                          hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(height: 30),
                        FadeAnimation(
                            2.5,
                            Container(
                              //color: Colors.blue,
                              //height:60,

                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                                 elevation: 0.8,
                            height: 50,

                                  color: Colors.pink[900],
                                  onPressed: () async {
                                    setState(() {
                                      ssloader = true;
                                    });
                                    try {
                                      var user = await authc
                                          .signInWithEmailAndPassword(
                                              email: email, password: password);
                                      if (user != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Command()),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Register()),
                                        );
                                      }
                                      print(user);
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: Text(
                                    "Login",
                                     style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            )),
                      ]),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}