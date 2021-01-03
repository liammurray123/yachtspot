import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yachtspot/constants.dart';
import 'package:yachtspot/widgets/boatcard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage firebase_storage = FirebaseStorage.instance;

class BoatDetailPage extends StatefulWidget {
  BoatDetailPage(
      {this.name,
      this.image,
      this.manufacturer,
      this.model,
      this.owner,
      this.location,
      this.email,
      this.price});
  final String name;
  final String image;
  final String manufacturer;
  final String model;
  final String owner;
  final String location;
  final String email;
  final String price;

  @override
  _BoatDetailPageState createState() => _BoatDetailPageState();
}

class _BoatDetailPageState extends State<BoatDetailPage> {
  final List<Widget> boatFieldsArrayComplete = [];

  void createFieldCards() {
    List<String> boatFieldsName = [
      'Name',
      'Manufacturer',
      'Model',
      'Price',
      'Location',
      'Owner',
      'Email'
    ];

    List<String> boatFieldsArray = [
      widget.name,
      widget.manufacturer,
      widget.model,
      '\$${widget.price.toString()}',
      widget.location,
      widget.owner,
      widget.email
    ];
    for (var i = 0; i < boatFieldsArray.length; i++) {
      var newWidget = Card(
        margin: EdgeInsets.all(10),
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                boatFieldsName[i].toString(),
                style: kBoatCardNameStyle.copyWith(color: kBlueColor),
              ),
              Text(
                boatFieldsArray[i].toString(),
                style: kBoatCardModelStyle.copyWith(color: kBlueColor),
              ),
            ],
          ),
        ),
      );
      if (boatFieldsName[i] == 'Email') {
        var newGestureWidget = GestureDetector(
          child: newWidget,
          onTap: () {
            launch('mailto:${widget.email}');
          },
        );
        boatFieldsArrayComplete.add(newGestureWidget);
      } else {
        boatFieldsArrayComplete.add(newWidget);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    createFieldCards();
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              widget.name,
              style: kBoatCardNameStyle.copyWith(fontSize: 25),
            ),
            backgroundColor: kBlueColor,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.image.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(boatFieldsArrayComplete),
          ),
        ],
      ),
    );
  }
}
