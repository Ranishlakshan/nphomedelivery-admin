import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Orderview extends StatefulWidget {
  final String docID123;

  const Orderview({ this.docID123}) ;

  
  @override
  _OrderviewState createState() => _OrderviewState();
}

class _OrderviewState extends State<Orderview> {
  
  var cars;


  @override
  void initState() {
    // TODO: implement initState
    cars = Firestore.instance
        .collection('orders')
        .document('${widget.docID123}')
        .snapshots();
        
    super.initState();

    
  }

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order details"),
      ),
      body: ListView(
        children: <Widget>[
          Text("ranish"),
          //Text(),
          StreamBuilder(
            stream: cars,
            builder: (context, snapshot){
              if(snapshot.hasData){

                String all_items;
                List<String> item_details =[];

                all_items = snapshot.data['value1'];
                List<String> item_list = all_items.split('~');

                for(int j=0;j<item_list.length;j++){
                   item_list[j].replaceAll('|', '  |  ');
                }



                int viewlistlen = item_list.length;
                //return Text("I have data"+item_list[0]);
                return ListView.builder(
                  shrinkWrap: true,
                primary: false,
                itemCount: viewlistlen,
                itemBuilder: (context,index){
                  //return Card(
                  //  //child: Text(spec_list[index])
                  //  child: Column(
                  //    children: <Widget>[
                  //      Text(viewList[index]),
                  //      
                  //    ],
                  //  ),
                  //  );
                  return ( 
                    Text("     " + item_list[index],style: TextStyle(color: Colors.brown,fontSize: 18,),)
                    
                  );
                },
                );
              }
              else{
                return Text("no data");
              }
            },
          ),
          SizedBox(height: 25,),
          //Text('____________________________'),
          //Text("CUstomer Details"),
          StreamBuilder(
            stream: cars,
            builder: (context, snapshot){
              if(snapshot.hasData){
                String name,address,id,phone,email,total,orderstate;

                name = snapshot.data['username'];
                address = snapshot.data['useraddress'];
                phone = snapshot.data['userphone'];
                id = snapshot.data['userid'];
                email = snapshot.data['value2'];
                total = snapshot.data['total'];
                orderstate = snapshot.data['orderstate'];

                return Column(
                  children: <Widget>[
                    Text("Total Bill : Rs."+total+" /=",style: TextStyle(fontSize:20,color: Colors.blue,),),
                    Text('______________________________________'),
                    SizedBox(height: 15,),
                    Text("Customer Details",style: TextStyle(fontSize:20,color: Colors.black,),),
                    SizedBox(height: 10,),
                    Text("Customer ID : "+id),
                    Text("Customer Name : "+name),
                    Text("Customer Address : "+address),
                    Text("Customer Phone : "+phone),
                  ],
                );

              }else{
                return Text('Connection Error');
              }
            },
          ),
          SizedBox(height: 30,),
          RaisedButton(
            child: Text("delete"),
            onPressed: (){
              Firestore.instance.collection('orders').document('${widget.docID123}').delete();
              //FirebaseStorage.instance.ref().child(images).delete();
              
              
              Navigator.popAndPushNamed(context, '/neworders');
            },
          ),
          SizedBox(height: 30,),
          RaisedButton(
            child: Text("accept"),
            onPressed: (){
              setState(() {
                              Firestore.instance.collection('orders').document('${widget.docID123}').updateData({'orderstate':"accepted"});
              //FirebaseStorage.instance.ref().child(images).delete();
              
              
              Navigator.pop(context);
                            });
            },
          ),
          SizedBox(height: 30,),
          RaisedButton(
            child: Text("delivered"),
            onPressed: (){
              setState(() {
                              Firestore.instance.collection('orders').document('${widget.docID123}').updateData({'orderstate':"delivered"});
              //FirebaseStorage.instance.ref().child(images).delete();
              
              
              Navigator.pop(context);
                            });
            },
          )
        ],
      ),
    );
  }
}