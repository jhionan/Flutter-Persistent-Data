import 'package:flutter/material.dart';
import 'package:sql_flutter/models/user.dart';
import 'package:sql_flutter/utils/database_helper.dart';

List _users;
main()async {
  var db = new DatabaseHelper();
_users = await db.getAllUsers();
 int conter = await db.getCount();
  int savedUser = await db.addUser(new User("Jhionan $conter","Rian"));
  db.updateUser(new User("updated", "updated"),2);
  
  var updatedUser = await db.updateUserFromMap(new User.fromMap({"username":"updated2",
  'password':'updatedpassword','id':3}));
  print("$updatedUser");
  print("$savedUser users saved");

  //db.clearDb();
  for(var i in _users){
    User user = User.map(i);
    print("User ${user.username} ${user.password}, ${user.id}");
  }


  runApp(MaterialApp(
  title: "SQFLITE",
  home: new Home(),
));

}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SQFLITE test"),
      backgroundColor: Colors.black54,),
body: new ListView.builder(
  itemCount: _users.length,
  itemBuilder:(BuildContext context,int position){ //or itemBuilder:(_,int position)
    return new Card(
      color: Colors.white70,
      elevation: 2.0,
      child: new ListTile(
        title: new Center(
          child: Text("User: ${User.fromMap(_users[position]).username}"),
        ),
        subtitle: Center(
          child: Text("Password ${User.map(_users[position]).password} id: ${User.map(_users[position]).id}"),
        ),
      ),
    );
  },
  )
    );
  }
}
