import 'package:flutter/material.dart';

class OrderManage extends StatefulWidget {
  @override
  _OrderManageState createState() => _OrderManageState();
}

class _OrderManageState extends State<OrderManage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Management"),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 30,),
          RaisedButton(
            child: Text("New Orders"),
            onPressed: (){
              Navigator.pushNamed(context, '/neworders');
            },
          ),
          SizedBox(height: 30,),
          RaisedButton(
            child: Text("Accept orders"),
            onPressed: (){
              Navigator.pushNamed(context, '/');
            },
          ),
          SizedBox(height: 30,),
          RaisedButton(
            child: Text("Deliverd orders"),
            onPressed: (){
              Navigator.pushNamed(context, '/');
            },
          ),
          SizedBox(height: 30,),
          

        ],
      ),
    );
  }
}