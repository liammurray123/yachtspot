import 'package:flutter/material.dart';
import 'package:yachtspot/constants.dart';

// Firebase Imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Screen and Widget Imports
import 'package:yachtspot/screens/sub/newboatscreen.dart';
import 'package:yachtspot/widgets/boatcard.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore storage = FirebaseFirestore.instance;
User loggedInUser;

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String newPassword;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

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
          SettingsInfoCard(
            label: "My Boats",
            value: "Click to see your boat details, edit, add and remove.",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyBoatsPage(),
                ),
              );
            },
          ),
          SettingsInfoCard(
            label: 'Email',
            value: auth.currentUser.email,
          ),
          SettingsInfoCard(
            label: "Joined",
            value: auth.currentUser.metadata.creationTime.toLocal().toString(),
          ),
          SettingsInfoCard(
            label: "Reset Password",
            value: "Click Here",
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (_) => AlertDialog(
                  elevation: 4.0,
                  title: Text('Are you sure?'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          'Must Contain 8 charecters and 1 special charecter (Number, symbol etc.)'),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            newPassword = value.toString();
                          });
                        },
                        style: TextStyle(color: kBlueColor, fontSize: 20),
                        decoration: kTextFieldStyle.copyWith(
                          hintText: 'Type Here',
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: kBlueColor, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No'),
                    ),
                    FlatButton(
                      onPressed: () {
                        auth.currentUser.updatePassword(newPassword);
                        Navigator.popUntil(
                          context,
                          ModalRoute.withName('/welcome'),
                        );
                      },
                      child: Text('Yes'),
                    ),
                  ],
                ),
              );
            },
          ),
          SettingsInfoCard(
            label: "Log Out",
            value: "Click Here",
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (_) => AlertDialog(
                  elevation: 4.0,
                  title: Text('Are you sure?'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No'),
                    ),
                    FlatButton(
                      onPressed: () {
                        auth.signOut();
                        Navigator.popUntil(
                          context,
                          ModalRoute.withName('/welcome'),
                        );
                      },
                      child: Text('Yes'),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class SettingsInfoCard extends StatelessWidget {
  SettingsInfoCard({this.label, this.value, this.onTap});
  final String label;
  final value;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                label,
                style: kBoatCardNameStyle.copyWith(color: kBlueColor),
              ),
              Text(
                value,
                style: kBoatCardModelStyle.copyWith(color: kBlueColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyBoatsPage extends StatefulWidget {
  @override
  _MyBoatsPageState createState() => _MyBoatsPageState();
}

class _MyBoatsPageState extends State<MyBoatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Boats',
          style: kBoatCardNameStyle.copyWith(fontSize: 25),
        ),
        backgroundColor: kBlueColor,
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewBoatScreen(),
                ),
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: storage
              .collection('boats')
              .where('email', isEqualTo: auth.currentUser.email)
              .snapshots(),
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
                  scrollDirection: Axis.vertical,
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Dismissible(
                      key: ValueKey(
                        document.id.toString(),
                      ),
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => AlertDialog(
                            elevation: 4.0,
                            title: Text(
                                "Are you sure you want to delete ${document.data()['name'].toString()}?"),
                            actions: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('No'),
                              ),
                              FlatButton(
                                onPressed: () {
                                  storage.doc('boats/${document.id}').delete();
                                  Navigator.pop(context);
                                },
                                textColor: Colors.red,
                                child: Text(
                                  'Delete',
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: BoatCard(
                        image: document.data()['image'],
                        name: document.data()['name'],
                        manufacturer: document.data()['manufacturer'],
                        model: document.data()['model'],
                        owner: document.data()['owner'],
                        location: document.data()['location'],
                        email: document.data()['email'],
                        price: document.data()['price'],
                      ),
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }
}
