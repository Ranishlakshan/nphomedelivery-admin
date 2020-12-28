import 'package:flutter/material.dart';
import 'package:nphomedelivery/uploadpg.dart';
import 'package:nphomedelivery/view_carosal.dart';
import 'Authentication.dart';
import 'Mapping.dart';
import 'acceptedorders.dart';
import 'adItem.dart';
import 'add_carosalimages.dart';
import 'categories.dart';
import 'deliverdorders.dart';
import 'neworders.dart';
import 'ordermanage.dart';

void main() {
  runApp(QuizThursday());
}

class QuizThursday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Quiz Thursday',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MappingPage(
        auth: Auth(),
      ),
      routes: {
        '/aditem': (context) => AdAdvertisement(),
        //Uploadpg
        '/uploadwait': (context) => Uploadpg(),
        //Catagories
        '/categories': (context) => Catagories(),
        //CarosalImages
        '/carosaladd': (context) => CarosalImages(),
        //MainCarosalView
        '/maincarosal': (context) => MainCarosalView(),
        //ordermanage
        '/ordermanage': (context) => OrderManage(),
        //NewOrders
        '/neworders': (context) => NewOrders(),
        //AcceptedOrders
        '/acceptedorders': (context) => AcceptedOrders(),
        //DeliveredOrders
        '/deliveredorders': (context) => DeliveredOrders(),

      },
    );
  }
}
