import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';

class HomePage extends StatefulWidget {
  HomePage({
    this.auth,
    this.onSignedOut,
  });
  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  void _logOutUser() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e.toString());
    }
  }

  
 


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 30,),
          RaisedButton(
            child: Text("Manage Orders"),
            onPressed: (){
              Navigator.pushNamed(context, '/ordermanage');
            },
          ),
          //Text("Ranish"),
          SizedBox(height: 20,),
          RaisedButton(
            child: Text("add Item"),
            onPressed: (){
              Navigator.pushNamed(context, '/aditem');
            },
          ),
          SizedBox(height: 20,),
          //categories
          RaisedButton(
            child: Text("All Items"),
            onPressed: (){
              Navigator.pushNamed(context, '/categories');
            },
          ),
          SizedBox(height: 20,),
          RaisedButton(
            child: Text("Add Special Offer Images"),
            onPressed: (){
              Navigator.pushNamed(context, '/carosaladd');
            },
          ),
          SizedBox(height: 20,),
          //maincarosal
          RaisedButton(
            child: Text("Special Offers Image View"),
            onPressed: (){
              Navigator.pushNamed(context, '/maincarosal');
            },
          ),
          
          //Text(Auth.getCurrentUser()),
        ],
      ),
      // body: Container(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                iconSize: 50.0,
                color: Colors.white,
                onPressed: _logOutUser,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
