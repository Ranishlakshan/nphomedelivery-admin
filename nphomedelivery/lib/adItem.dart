import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'forms/countform.dart';

var catagory_names = Firestore.instance.collection("category").snapshots();
String itemcategory;

class AdItem extends StatefulWidget {
  @override
  _AdItemState createState() => _AdItemState();
}

class _AdItemState extends State<AdItem> {
  
    
  Widget _widgetForm(){
      switch (itemcategory) {
      //vehicles---------------------------------
      case "baby Items":
        return Column(
          children: <Widget>[
            Text('Baby Item'),
            CountForm(cat1:itemcategory),
          ],
        );
        break;
      default:
        return Column(
          children: <Widget>[
            Text(' '),
            Text('No selection')
          ],
        );
        break;
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),

      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 30,),
          StreamBuilder<QuerySnapshot>(
            stream: catagory_names,
            builder: (context, snapshot) {
              if(!snapshot.hasData){
                return Text("Loading.....");
              }
              else{
                List<DropdownMenuItem> categoryitems = [];
                for (int i = 0; i < snapshot.data.documents.length; i++){
                  DocumentSnapshot snap = snapshot.data.documents[i];
                  categoryitems.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.documentID,
                          style: TextStyle(color: Color(0xff11b719)),
                        ),
                        value: "${snap.documentID}",
                      ),
                    );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButton(
                      items: categoryitems,
                      onChanged: (value) {
                        setState(() {
                          itemcategory=value;                          
                        });
                      },
                      value: itemcategory,
                        isExpanded: false,
                        hint: new Text(
                          "Choose Category for Item",
                          style: TextStyle(color: Color(0xff11b719),letterSpacing: 2),
                        ),
                    ),
                  ],
                );
              }              
            },
          ),
          _widgetForm(),
        ],
      ),
    );
  }
}