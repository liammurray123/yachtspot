import 'package:flutter/material.dart';
import 'package:yachtspot/constants.dart';

// Widget Imports
import 'package:yachtspot/widgets/boatcard.dart';

// Firebase Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchString;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4.0,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchString = value.toLowerCase();
                });
              },
              style: TextStyle(color: kBlueColor, fontSize: 20),
              decoration: kTextFieldStyle.copyWith(
                hintText: 'Search Here',
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: (searchString == null || searchString.trim() == "")
                  ? firestore.collection('boats').snapshots()
                  : firestore
                      .collection('boats')
                      .where('keywords', arrayContains: searchString)
                      .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child:
                        Text('Could not find anything matching $searchString'),
                  );
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    return ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return BoatCard(
                          name: document.data()['name'],
                          image: document.data()['image'],
                          manufacturer: document.data()['manufacturer'],
                          model: document.data()['model'],
                          price: document.data()['price'],
                          location: document.data()['location'],
                          owner: document.data()['owner'],
                          email: document.data()['email'],
                        );
                      }).toList(),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// void addToDatabase(String name, String manufacturer, String model, String owner,
//     String location) {
//   List<String> splitList = name.split(r"*b");
//   List<String> keywordsList = [];

//   for (int i = 0; i < splitList.length; i++) {
//     keywordsList.add(splitList[i].toLowerCase());
//     for (int y = 1; y < splitList[i].length + 1; y++) {
//       keywordsList.add(splitList[i].substring(0, y).toLowerCase());
//     }
//   }

//   print(keywordsList.toString());
//   firestore.collection('boats').doc().set({
//     'name': name,
//     'manufacturer': manufacturer,
//     'model': model,
//     'price': price,
//     'owner': owner,
//     'location': location,
//     'keywords': keywordsList
//   });
//}
