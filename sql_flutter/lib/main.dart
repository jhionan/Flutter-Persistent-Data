import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


main()=>runApp(MaterialApp(
  title: "SQFLITE",
  home: new Home(),
));

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SQFLITE test"),
      backgroundColor: Colors.black54,),

    );
  }
}