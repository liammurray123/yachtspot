import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yachtspot/constants.dart';
import 'package:yachtspot/widgets/boatcard.dart';
import 'package:url_launcher/url_launcher.dart';
class BoatDetailPage extends StatelessWidget {
  BoatDetailPage(
      {this.name,
      this.manufacturer,
      this.model,
      this.owner,
      this.location,
      this.email, this.price});
  final String name;
  final String manufacturer;
  final String model;
  final String owner;
  final String location;
  final String email;
  final int price;

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
      name,
      manufacturer,
      model,
      '\$${price.toString()}',
      location,
      owner,
      email
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
            launch('mailto:$email');
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
              name,
              style: kBoatCardNameStyle.copyWith(fontSize: 25),
            ),
            backgroundColor: kBlueColor,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                  'assets/images/welcome-background-image.png',
                  fit: BoxFit.cover),
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
