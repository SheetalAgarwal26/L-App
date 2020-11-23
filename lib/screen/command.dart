import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task3/animation/fadeanimation.dart';
import 'package:http/http.dart' as http;
import 'package:task3/screen/registration.dart';
import 'package:task3/screen/splash.dart';

class Command extends StatefulWidget {
  @override
  _CommandState createState() => _CommandState();
}

class _CommandState extends State<Command> {
  var tfcontroller= TextEditingController();
  var id;
  var output = " ";
  String command;
  var fs = FirebaseFirestore.instance;
  linuxCommand(command) async {
    var url = 'http://192.168.43.218/cgi-bin/web.py?x=$command';
    var response = await http.get(url);
    var val;

    setState(() {
      val = response.body;
    });
    output = val;
    await fs.collection("users").add({
      "command": command,
      "value": val,
    }).then((value) {
      id = value.id;
    });
    //print(db);

    print(id);
    //print(response.body);
    await fs.collection("users").doc(id).get().then((value) {
      print(value.data()['value']);

      setState(() {
        output = value.data()['value'];
      }); //print(data);
    });

    //print(output.runtimeType);
    //print(id);
    //print(data.data().runtimeType);
    /*if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }*/
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

   Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Linux Terminal',
          style: TextStyle(fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 25), 
          textAlign: TextAlign.center,),
          leading: Image.asset('assets/a.png'),
          actions: [
            IconButton(icon: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 36.0,
                        ),
                        onPressed:
                         ()  {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Splash()),
                                            );
                                          },),
                         IconButton(icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 36.0,
                        ),
                        onPressed:
                         null),
          ],
         /* flexibleSpace: Image.asset(
            'assets/d.jpg',
            fit: BoxFit.fill,
          ),*/
          backgroundColor: Colors.indigo,
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bc.jpg'), fit: BoxFit.fill)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Container(
                    margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,

                      )
                    ),
                    child: Card(
                      color: Colors.black,
                      child: TextField(
                        controller: tfcontroller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            hintText: '  Enter Your Linux Command',
                            hintStyle: TextStyle(color: Colors.red),
                            fillColor: Colors.white,
                           // prefixText: '[root@localhost ~]#',
                           prefixIcon: Icon(Icons.tablet_android,color: Colors.indigo,),
                            prefixStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                            focusColor: Colors.blue,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black45))),
                        onChanged: (value) {
                          command = value;
                        },
                        autocorrect: true,
                        showCursor: true,
                      ),
                    ),
                  )),
                  Container(
                      margin: EdgeInsets.only(top: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black),
                      child: Material(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10),
                        elevation: 10,
                        child: MaterialButton(
                          splashColor: Colors.blue,
                        
                          minWidth: 200,
                          height: 40,
                          onPressed: () {
                              linuxCommand(command);
                            tfcontroller.clear();
                          },
                          child: Text('Run Command',
                          style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20), 
                          textAlign: TextAlign.center),
                          textColor: Colors.black,
                          ),
                      )),
                  Container(
                    height: 400,
                    width: 390,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amber),
                    child: Card(
                      color: Colors.black,
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Text(
                            output ?? "  ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Material(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10),
                          elevation: 10,
                          child: MaterialButton(
                            minWidth: 200,
                            height: 30,
                            child: Text('Go Firebase'),
                            onPressed: () {
                                linuxCommand(command)();
                            },
                          )))
                ],
              ),
            ),
          ),
        ));
  }
}
