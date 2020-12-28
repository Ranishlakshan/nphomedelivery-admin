import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nphomedelivery/zoomimage.dart';



class ItemView extends StatefulWidget {
  final String docID123;

  const ItemView({ this.docID123}) ;

  @override
  _ItemViewState createState() => _ItemViewState();
}
String name123;
var cars;
var cars_img;

String title = '';
String price = '';
String phone = '';
String discription;
String quantity;

//final String number = "123456789";
//final String email = "dancamdev@example.com";
String numb;
String desc;

class _ItemViewState extends State<ItemView> {
  //@override
  //String docuID = Widget.documentid;
  
  List<String> _listOfImages = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    cars = Firestore.instance
        .collection('ads')
        .document('${widget.docID123}')
        .snapshots();
        
    super.initState();

    cars_img = Firestore.instance
        .collection('ads')
        .document('${widget.docID123}')
        .snapshots();
        //title = cars_img.data['value1'];
        //StreamBuilder(
        //  stream: cars_img,
        //  builder: (context, snapshot) {
        //    if(!snapshot.hasData){
        //      title = snapshot.data['value1'];
        //    }            
        //  },
        //);
        //getphone();
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    //final  Map<String, Object>rcvdData = ModalRoute.of(context).settings.arguments;
    //docID = ${rcvdData['docuID'];}
    //String name123  = rcvdData[0];
    return Scaffold(
      //bottomNavigationBar: BottomNvBar(),
      
      appBar: AppBar(
        title: Text('Item Data',style: TextStyle(letterSpacing: 2),),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: <Widget>[
          StreamBuilder(
                stream: cars_img,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    //title = snapshot.data['value1'];
                    //setState(() { title = snapshot.data['value1']; });
                    _listOfImages = [];
                    for (int i = 0; i < snapshot.data['urls'].length; i++) {
                      _listOfImages.add(snapshot.data['urls'][i]);
                    }
                  }
                  return CarouselSlider(
                      items: _listOfImages.map((e){
                        return ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            child: Container(
                              height: 200.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: GestureDetector(
                                  //image appear in correct width and height
                                  //child: Image.network(e, fit: BoxFit.fill),
                                  child: Image.network(e),
                                  onTap: () {
                                    Navigator.push<Widget>(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ZoomImage(zoomlistOfImages: _listOfImages),
                                      ),
                                    );
                                  }),
                            ));
                      }).toList(),
                      options: CarouselOptions(
                        height: 300,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ));
                }),
          //Text(' -------------- '),
          //Text(title),
          getTitle(),
          //getMain(),
          Text(''),
          
          getItems(),
          SizedBox(height:55),
          //Text('              ___________________________________________   '),
          //Text('Nimasha'),
          //  DESCRIPTION EKA MADA PENA EKA GETROW();
          //getRow(),
          SizedBox(height:50),


          RaisedButton(
            child: Text("Update"),
            onPressed: (){
              showDialog(
                    context: context,
                    builder: (context) {
                      int urnum = 1;
                      //double subtotal = double.parse(ad.value2);
                      String contentText = "Content of Dialog";
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            //title: Text("Select Quantity"),
                            content: Column(
                              children: <Widget>[
                                //SizedBox(height: 15,),
                                
                                //Text('Quantity'),
                                //Text("Title is : "+title),
                                TextFormField(
                                  initialValue: title,
                                  onChanged:  (value) {
                                    //print(widget.cat1+","+widget.cat2);
                                       title=value;         
                                              },
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Unit Name';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black)
                                    ),
                                    //hintText: 'Enter Unit Name',
                                    labelText: 'Unit Name',
                                    prefixIcon: Icon(Icons.add_circle) 
                                  ),
                                ),
                                SizedBox(height: 5,),
                                //PRICE
                                TextFormField(
                                  initialValue: price,
                                  onChanged:  (value) {
                                    //print(widget.cat1+","+widget.cat2);
                                       price=value;         
                                              },
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Unit Price';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black)
                                    ),
                                    //hintText: 'Enter Unit Name',
                                    labelText: 'Unit Price',
                                    prefixIcon: Icon(Icons.add_circle) 
                                  ),
                                ),
                                SizedBox(height: 5,),
                                //Description
                                TextFormField(
                                  initialValue: discription,
                                  onChanged:  (value) {
                                    //print(widget.cat1+","+widget.cat2);
                                       discription=value;         
                                              },
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Description';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black)
                                    ),
                                    //hintText: 'Enter Unit Name',
                                    labelText: 'Description',
                                    prefixIcon: Icon(Icons.add_circle) 
                                  ),
                                ),
                                SizedBox(height: 5,),
                                TextFormField(
                                  initialValue: quantity,
                                  onChanged:  (value) {
                                    //print(widget.cat1+","+widget.cat2);
                                       quantity=value;         
                                              },
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please enter Quantity';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black)
                                    ),
                                    //hintText: 'Enter Unit Name',
                                    labelText: 'Quantity',
                                    prefixIcon: Icon(Icons.add_circle) 
                                  ),
                                ),
                                //Text(urnum.toString() +" units", style: TextStyle(fontSize: 26),),
                                //Text(ad.value1),
                                //SizedBox(height: 20,),
                                ////Row Start
                                //
                                //SizedBox(height: 15,),
                                //Text("____________"),
                                //SizedBox(height: 15,),

                                RaisedButton(
                                  child: Text("Update"),
                                  onPressed: (){
                                    Firestore.instance.collection('ads').document('${widget.docID123}').updateData({
                                      'Description':discription,
                                      'value2':price,
                                      'value1':title,
                                      'value4':quantity
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                //Row end
                                //SizedBox(height: 30,),
                                //Text("Item : "+ad.value1),
                                //SizedBox(height: 10,),
                                //Text("Unit Price : "+ad.value2),
                                
                                //Text("Total Price for this Product"),
                                //SizedBox(height: 15,),
                                ////Text('Rs '+subtotal.toString()+' /=', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),),
//
                                //SizedBox(height: 15,),
                                //Text("____________"),
                                //SizedBox(height: 15,),


                                //2 nd row start
                                
                                //2 nd row END 


                                
                                
                              ],
                            ),
                            //actions: <Widget>[
                            //  FlatButton(
                            //    onPressed: () => Navigator.pop(context),
                            //    child: Text("Cancel"),
                            //  ),
                            //  FlatButton(
                            //    onPressed: () {
                            //      setState(() {
                            //        contentText = "Changed Content of Dialog";
                            //        urnum++;
                            //      });
                            //    },
                            //    child: Text("Change"),
                            //  ),
                            //],
                          );
                        },
                      );
                    },
                  );
            },
          ),

          SizedBox(height: 15,),
          RaisedButton(
            child: Text('Delete'),
            onPressed: (){
              setState(() {
                Firestore.instance.collection('ads').document('${widget.docID123}').delete();
              
                              Navigator.pop(context);
                              
                            });
            },
          ),
          //Text(' --- END --- '),
          
          
        ],
      )
    );
  }
}

Widget getMain(){
  return StreamBuilder(
    stream: cars_img,
    builder: (context, snapshot1) {
      if (!snapshot1.hasData) {
          //snapshot.data.toString();
          return new Text("Loading");
        }
        DocumentSnapshot title1 = snapshot1.data;

        String tijsonString = title1.data.toString();
        return Text(tijsonString);
      },
  );
}

Widget getRow(){
  return StreamBuilder(
    stream: cars,
    builder: (context, snapshot) {
         if (!snapshot.hasData) {
          //snapshot.data.toString();
          return new Text("Loading");
        }
        DocumentSnapshot title2 = snapshot.data;

        String phonetijsonString = title2.data.toString();
        String tistart = "[";
        String tiend = "]";
        final phonetistartIndex = phonetijsonString.indexOf(tistart);
        final phonetiendIndex = phonetijsonString.indexOf(tiend, phonetistartIndex + tistart.length);
        String phonetinext = phonetijsonString.substring(phonetistartIndex + tistart.length, phonetiendIndex);
        String phonetiimagelinkRemoved = phonetijsonString.replaceAll(phonetinext, "");
        String phonetiurlremoved = phonetiimagelinkRemoved.replaceAll("urls: [], ", "").replaceAll("{", "").replaceAll("}", "");
        List<String> phonetiviewList =[]; 
        List<String> phonetispec_list = phonetiurlremoved.split(", ");
        
        for(int j=0;j<phonetispec_list.length;j++){
          if( phonetispec_list[j].contains('phone') ){
              String phoneremovevalue1 = phonetispec_list[j].replaceAll("phone:", "");
              //title = phoneremovevalue1;
              numb = phoneremovevalue1;

              //tiviewList.add(tispec_list[j]);
              //print(title);
          }
          else if(phonetispec_list[j].contains('Description')){
             desc = phonetispec_list[j].replaceAll("Description:", "");

          }
        }
        //return Text(title + price);
        //return Text(numb);
        return Column(
          children: <Widget>[
            Text(desc,style: TextStyle(fontSize: 18),),
            SizedBox(height: 20,),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            //  RaisedButton(
            //  color: Colors.blueAccent,
            //  highlightColor: Colors.lightBlue,
            //  child: Text(
            //    //"call $numb",
            //    "Make a Call",
            //  ),
            //  onPressed: () {
            //    launch("tel:$numb");
            //  }
            //),
            SizedBox(width: 20.0,),
            //RaisedButton(
            //  color: Colors.blueAccent,
            //  highlightColor: Colors.lightBlue,
            //  child: Text(
            //    //"message $numb",
            //    "Make a SMS",
            //  ),
            //  onPressed: () {
            //    launch("sms:$numb");
            //  },
            //),
            SizedBox(width: 20.0,),
            RaisedButton(
              color: Colors.green,
              child: Text("WhatsApp"),
              onPressed: () async {
                print(numb.length);
                String whatsapp;
                if(numb[0]=="+" ){
                  //+947118869 5 0
                  //01234567891011
                  whatsapp=numb;

                }
                else if(numb.length==11){
                  var sub = numb.substring(numb.length - 9);
                  print("---------------");
                  whatsapp = "+94"+sub;
                  print(sub);
                  print("final : "+whatsapp);
                }


              //var whatsappUrl ="whatsapp://send?phone=$whatsapp";
              //await canLaunch(whatsappUrl)? launch(whatsappUrl):print("open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
              },
            ),


            ],
          )
          ],
        );

        
        
        
      },
    
  );
}

Widget getTitle(){
    return StreamBuilder(
      stream: cars,
      builder: (context, snapshot) {
         if (!snapshot.hasData) {
          //snapshot.data.toString();
          return new Text("Loading");
        }
        DocumentSnapshot title1 = snapshot.data;

        String tijsonString = title1.data.toString();
        String tistart = "[";
        String tiend = "]";
        final tistartIndex = tijsonString.indexOf(tistart);
        final tiendIndex = tijsonString.indexOf(tiend, tistartIndex + tistart.length);
        String tinext = tijsonString.substring(tistartIndex + tistart.length, tiendIndex);
        String tiimagelinkRemoved = tijsonString.replaceAll(tinext, "");
        String tiurlremoved = tiimagelinkRemoved.replaceAll("urls: [], ", "").replaceAll("{", "").replaceAll("}", "");
        List<String> tiviewList =[]; 
        List<String> tispec_list = tiurlremoved.split(", ");
        
        for(int j=0;j<tispec_list.length;j++){
          if( tispec_list[j].contains('value1') ){
              String removevalue1 = tispec_list[j].replaceAll("value1:", "");
              title = removevalue1;
              //tiviewList.add(tispec_list[j]);
              //print(title);
          }
          else if( tispec_list[j].contains('value2') ){
              String removevalue2 = tispec_list[j].replaceAll("value2:", "");
              price = removevalue2;
              //tiviewList.add(tispec_list[j]);
              //print(price);
          }
          //else if( tispec_list[j].contains('phone') ){
          //    String removevalue3 = tispec_list[j].replaceAll("phone:", "");
          //    phone = removevalue3;
          //    //tiviewList.add(tispec_list[j]);
          //    //print(price);
          //}

        }
        //return Text(title + price);
        return Column(
          children: <Widget>[
            Text(title.toUpperCase(),
              style: new TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )
              ),
            Text("Rs ${price}",
              style: new  TextStyle(fontSize: 26,background: Paint()
                    ..strokeWidth = 6.0
                    ..color = Colors.yellow
                    ..style = PaintingStyle.fill
                    ..strokeJoin = StrokeJoin.round
                    )
            ),
          ],
        );
        int tiviewlistlen = tiviewList.length;
        
        /////
        //return ListView.builder(
        //        shrinkWrap: true,
        //        primary: false,
        //        itemCount: tiviewlistlen,
        //        itemBuilder: (context,index){
        //          return Card(
        //            //child: Text(spec_list[index])
        //            child: Column(
        //              children: <Widget>[
        //                Text(tiviewList[index]),
        //                
        //              ],
        //            ),
        //            );
        //        },            
        //);
        /////
      },
    );
}

Widget getItems(){
    return StreamBuilder(
      //1597917013710
      //stream: Firestore.instance.collection('ads').document('1597917013710').snapshots(),
      stream: cars,
      builder: (context, snapshot){
        if (!snapshot.hasData) {
          //snapshot.data.toString();
          return new Text("Loading");
        }
        DocumentSnapshot dd = snapshot.data; 

        //
      
        //
        var userDocument = snapshot.data;
        //String myname = dd.data.toString();
        int len = dd.data.length;
        
        String jsonString = dd.data.toString();
        //print("STRING ::::"+jsonString);
        String start = "[";
        String end = "]";
        final startIndex = jsonString.indexOf(start);
        final endIndex = jsonString.indexOf(end, startIndex + start.length);
        String next = jsonString.substring(startIndex + start.length, endIndex);
        String imagelinkRemoved = jsonString.replaceAll(next, "");
        String urlremoved = imagelinkRemoved.replaceAll("urls: [], ", "").replaceAll("{", "").replaceAll("}", "");
        List<String> viewList =[]; 
        List<String> spec_list = urlremoved.split(", ");
        
        

        for(int j=0;j<spec_list.length;j++){

          if(!(spec_list[j].contains('value') || spec_list[j].contains('searchkey')  || spec_list[j].contains('reviewstatus') || spec_list[j].contains('description')) ){
            viewList.add(spec_list[j]);
          }
          if( spec_list[j].contains('Description') ){
            discription = spec_list[j];
            //print("DESCRIPTION IS :::::::"+discription);
            discription = discription.replaceAll("Description:", "");
            print("DESCRIPTION IS :::::::"+discription);
          }
          if( spec_list[j].contains('value4') ){
            //discription = spec_list[j];
            //print("DESCRIPTION IS :::::::"+discription);
            //discription = discription.replaceAll("Description:", "");
            //print("DESCRIPTION IS :::::::"+discription);
            String quanti = spec_list[j].replaceAll('value4', 'Quantity');
            viewList.add(quanti);
            quantity = quanti.replaceAll('Quantity:', '');
          }
          
        }
        
        int speclistlen = spec_list.length;
        int viewlistlen = viewList.length;
        print("LENGTH OF LIST ::::::::::::::::::"+viewlistlen.toString());
        //
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
                    Text("     " + viewList[index],style: TextStyle(color: Colors.brown,fontSize: 18,),)
                    
                  );
                },
              
        );

        //int i=0;
        //if(i<speclistlen){
        //  return Text (spec_list[i]);
        //} 
        //return Text(speclistlen.toString());
        //for(int i;i<5;i++){
        //  return Text(spec_list[i]);
        //}
        //List<String> items = ;
        //return new Text(list[9]);
        //return new Text(spec_list[9]);
        //return ListView(
        //  
        //  children: <Widget>[
        //    
        //  ],
        //);
      }
    );
}


Future getCatagory() async {
      var firestone = Firestore.instance;

      QuerySnapshot alldata = await firestone.collection("catagory_names/Vehicles").getDocuments();
      for(int i=0;i<alldata.documents.length;i++){
                        DocumentSnapshot snap = alldata.documents[i];
                        
                      }

      return  Text('12345');

    }