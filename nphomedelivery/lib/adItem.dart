import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'forms/carform.dart';




class AdAdvertisement extends StatefulWidget {
  final GlobalKey<ScaffoldState> globalKey;
  const AdAdvertisement({Key key, this.globalKey}) : super(key: key);
  @override
  _AdAdvertisementState createState() => _AdAdvertisementState();
}

class _AdAdvertisementState extends State<AdAdvertisement> {
  var selectedCurrency,selectedSub;
  var  selectedCurrency2, selectedType;
  var value;
  final databaseReference = Firestore.instance;
  String now = new DateTime.now().toString();
  List<Asset> images = List<Asset>();
  //List<NetworkImage> _listOfImages = <NetworkImage>[];
  List<String> imageUrls = <String>[];
  //List<String> imageLocalLink = <String>[];
  String _error = 'No Error Dectected';
  bool isUploading = false;
  bool carosal = false;


  final _formKeyCar = GlobalKey<FormState>();
  final _formKeyVan = GlobalKey<FormState>();

  var catagory_names = Firestore.instance.collection("category").snapshots();

  void createRecord() async {
    await databaseReference.collection("Advertisements")
        .document(now)
        .setData({
          'title': 'Mastering Flutter',
          'description': 'Programming Guide for Dart'
        });

    
  }

  Widget _widgetForm() {
    switch (selectedCurrency2) {
      //vehicles---------------------------------
      case "Araliya":
        return electronicsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      case "Nipuna":
        return electronicsForm(cat1:selectedCurrency,cat2:selectedCurrency2);
        break;
      //default
      default:
        return Text(' ');
        break;
    }
  }
  //
  
  //

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Upload Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      print(resultList.length);
      print((await resultList[0].getThumbByteData(122, 100)));
      print((await resultList[0].getByteData()));
      print((await resultList[0].metadata));

    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;
    setState(() {
      images = resultList;
      carosal = true;
      print('<<<<<<<<<<<<<<<<<<<');
      print(images);
      
      
      //_listOfImages = imageUrls.cast<NetworkImage>();
      _error = error;
    });
  }
  Widget _imageShow(){
    if(carosal==true){
      return CarouselSlider(
        items: images
        .map((e) => AssetThumb(asset:e, width: 300, height: 300,))
        .toList(),
        options: CarouselOptions(
          height: 400,
          aspectRatio: 16 /9 ,
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

        ),  
      );
    }
    else{
      return Text('not yet selected');
    }
  }

  void uploadImages(){
  
    for ( var imageFile in images) {
      postImage(imageFile).then((downloadUrl) {
        imageUrls.add(downloadUrl.toString());
        if(imageUrls.length==images.length){
          String documnetID = DateTime.now().millisecondsSinceEpoch.toString();
          Firestore.instance.collection('images').document(documnetID).setData({
            'urls':imageUrls
          }).then((_){
            SnackBar snackbar = SnackBar(content: Text('Uploaded Successfully'));
            //widget.globalKey.currentState.showSnackBar(snackbar);
            setState(() {
              images = [];
              imageUrls = [];
              carosal =false;
            });
          });
        }
      }).catchError((err) {
        print(err);
      });
    }

  }

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  List<DropdownMenuItem> currencyItems2 = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: BottomNvBar(),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Post Advertisement',style: TextStyle(letterSpacing: 2),),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                
                //Navigator.pushNamed(context, '/login');
                //addDialog(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.apps),
              onPressed: () {},
            ),
          ],
        ),
        //drawer: MyDrawer(),
        body: ListView(
          children: <Widget>[
            
            SizedBox(height: 10.0),
            StreamBuilder<QuerySnapshot>(
              stream: catagory_names,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Text("Loading.....");
                else {
                  List<DropdownMenuItem> currencyItems = [];
                  for (int i = 0; i < snapshot.data.documents.length; i++) {
                    DocumentSnapshot snap = snapshot.data.documents[i];
                    currencyItems.add(
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
                      //SizedBox(width: 20.0),
                      DropdownButton(
                        items: currencyItems,
                        onChanged: (currencyValue) {
                          setState(() {
                            selectedCurrency = currencyValue;
                            //disabledropdown = true;
                          });
                          for (int i = 0;i < snapshot.data.documents.length;i++) {
                            DocumentSnapshot snap = snapshot.data.documents[i];
                            if (snap.documentID == selectedCurrency) {
                              currencyItems2 = [];
                              for (int j = 0; j < snap.data.length; j++) {
                                currencyItems2.add(
                                  DropdownMenuItem(
                                    child: Text(
                                      snap.data['${j + 1}'].toString(),
                                      style:
                                          TextStyle(color: Color(0xff11b719)),
                                    ),
                                    value: snap.data['${j + 1}'].toString(),
                                  ),
                                );
                              }
                            }
                          }
                          final snackBar = SnackBar(
                            content: Text(
                              'Selected Category is $currencyValue',
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        },
                        value: selectedCurrency,
                        isExpanded: false,
                        hint: new Text(
                          "Choose Category for Ad",
                          style: TextStyle(color: Color(0xff11b719),letterSpacing: 2),
                        ),
                      ),
                      DropdownButton(
                        items: currencyItems2,
                        onChanged: (currencyValue) {
                          final snackBar = SnackBar(
                            content: Text(
                              'Selected  Sub Category is $currencyValue',
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                          setState(() {
                            selectedCurrency2 = currencyValue;
                            currencyItems2 = [];
                            currencyItems = [];
                          });
                        },
                        hint: new Text(
                          "Choose Sub Category for Ad",
                          style: TextStyle(color: Color(0xff11b719),letterSpacing: 1),
                        ),
                      ),
                    ],
                  );
                }
              }),
          _widgetForm(),
          
                  
              //_widgetForm(),
            
              
          ],
        ),
    );
  }
}