import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



//teste

main()async{

  runApp(MaterialApp(
    home: new Home(),
  ));
}

class Home extends StatefulWidget{
  @override
  State createState() {
    return new _HomeState();
  }

}

class _HomeState extends State<Home> {
  var _textController = TextEditingController();
  String _user = "";




  
  Future addPreference(String value)async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("user", value);

  }

  Future deletePreference()async {
    final pref = await SharedPreferences.getInstance();
    pref.remove("user");
  }

  readPreference() async{
  final pref = await SharedPreferences.getInstance();

  setState(() {
    _user = pref.get("user");
  });

  }


  @override
  initState() {
    super .initState();
    readPreference();

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Shared Preferences"),),
      body: Column(
        children: <Widget>[
          Center(
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_user),
              )
          ),
          Center(
              child: new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                      labelText: "String to save"
                  ),
                ),
              )
          ),
          new Center(
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {

                  addPreference(_textController.text);
                  readPreference();
                },

                child: Text("save"),),
            ),
          )
        ],
      ),
    );
  }


}




