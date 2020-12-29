import 'package:flutter/material.dart';
import 'package:yachtspot/constants.dart';

// Location Plugins
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// Firebase Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Screen and Widget Imports
import 'package:yachtspot/screens/sub/searchscreen.dart';
import 'package:yachtspot/widgets/boatcard.dart';
import 'package:yachtspot/widgets/welcomebutton.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore storage = FirebaseFirestore.instance;
User loggedInUser;
bool showSpinner = false;

// Required fields
String name;
String manufacturer;
String model;
String owner;
int price;

const kNewTextFieldStyle = InputDecoration(
  hintText: 'Enter Value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kBlueColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: kRedColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

class NewBoatScreen extends StatefulWidget {
  @override
  _NewBoatScreenState createState() => _NewBoatScreenState();
}

class _NewBoatScreenState extends State<NewBoatScreen> {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add a boat',
            style: kBoatCardNameStyle.copyWith(fontSize: 25),
          ),
          backgroundColor: kBlueColor,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextField(
                onChanged: (value) {
                  name = value;
                },
                style: TextStyle(color: kBlueColor),
                decoration: kNewTextFieldStyle.copyWith(hintText: 'Boat Name'),
              ),
              TextField(
                onChanged: (value) {
                  manufacturer = value;
                },
                style: TextStyle(color: kBlueColor),
                decoration:
                    kNewTextFieldStyle.copyWith(hintText: 'Boat Manufacturer'),
              ),
              TextField(
                onChanged: (value) {
                  model = value;
                },
                style: TextStyle(color: kBlueColor),
                decoration: kNewTextFieldStyle.copyWith(hintText: 'Boat Model'),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  price = value as int;
                  print(price);
                },
                style: TextStyle(color: kBlueColor),
                decoration: kNewTextFieldStyle.copyWith(hintText: 'Boat Price'),
              ),
              TextField(
                onChanged: (value) {
                  owner = value;
                },
                style: TextStyle(color: kBlueColor),
                decoration:
                    kNewTextFieldStyle.copyWith(hintText: 'Owner Full Name'),
              ),
              WelcomeButton(
                  label: 'Register',
                  color: kRedColor,
                  onPressed: () async {
                    try {
                      setState(() {
                        showSpinner = true;
                      });
                      addToDatabase(name, manufacturer, model, owner);
                      Navigator.pop(context);
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                        Navigator.pop(context);
                      });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

void addToDatabase(
  String name,
  String manufacturer,
  String model,
  String owner,
) async {
  List<String> splitList = name.split(r"*b");
  List<String> keywordsList = [];

  for (int i = 0; i < splitList.length; i++) {
    keywordsList.add(splitList[i].toLowerCase());
    for (int y = 1; y < splitList[i].length + 1; y++) {
      keywordsList.add(splitList[i].substring(0, y).toLowerCase());
    }
  }
//  Get Lat Long
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
// Get City
  List<Placemark> placemark =
      await placemarkFromCoordinates(position.latitude, position.longitude);

  storage.collection('boats').doc().set({
    'name': name,
    'manufacturer': manufacturer,
    'model': model,
    'price': price,
    'owner': owner,
    'email': auth.currentUser.email,
    'location':
        "${placemark[0].subAdministrativeArea.toString()}, ${placemark[0].administrativeArea}, ${placemark[0].country.toString()}",
    'keywords': keywordsList
  });
}