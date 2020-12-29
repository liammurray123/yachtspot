import 'package:flutter/material.dart';

import 'package:yachtspot/constants.dart';

// Widget Imports
import 'package:yachtspot/widgets/boatcard.dart';

// Firebase Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
User loggedInUser;
List<BoatCard> boatCardList = [];

class DiscoverScreen extends StatefulWidget {
  @override
  DiscoverScreenState createState() => DiscoverScreenState();
}

class DiscoverScreenState extends State<DiscoverScreen> {
  getCurrentUser() async {
    final user = auth.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  void dispose() {
    super.dispose();
    boatCardList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Y.',
                style: kLogoStyle.copyWith(
                  color: kBlueColor,
                  fontSize: 40,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ahoy',
                      style: ktopWelcomeTextStyle.copyWith(fontSize: 20)),
                  Text(loggedInUser.email.toString(),
                      style: kbottomWelcomeTextStyle.copyWith(fontSize: 20)),
                ],
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Text(
              'Discover',
              style: kbottomWelcomeTextStyle.copyWith(fontSize: 25),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('boats').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error, could not connect to server'),
                  );
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return BoatCard(
                          name: document.data()['name'],
                          manufacturer: document.data()['manufacturer'],
                          model: document.data()['model'],
                          price: document.data()['price'],
                          owner: document.data()['owner'],
                          location: document.data()['location'],
                          email: document.data()['email'],
                        );
                      }).toList(),
                    );
                }
              },
            ),
          ),

          // OLD ONE
          // StreamBuilder<QuerySnapshot>(
          //   stream: storage.collection('boats').snapshots(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     final documents = snapshot.data.docs.reversed;
          //     for (var document in documents) {
          //       final name = document.data()['name'];
          //       final manufacturer = document.data()['manufacturer'];
          //       final model = document.data()['model'];
          //       final owner = document.data()['owner'];
          //       final location = document.data()['location'];
          //       final boatCard = BoatCard(
          //         name: name,
          //         manufacturer: manufacturer,
          //         model: model,
          //         owner: owner,
          //         location: location,
          //       );
          //       boatCardList.add(boatCard);
          //     }
          //     return Container(
          //       height: 380,
          //       child: ListView(
          //         scrollDirection: Axis.horizontal,
          //         children: boatCardList,
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
