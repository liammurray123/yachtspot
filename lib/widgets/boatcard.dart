import 'package:flutter/material.dart';
import 'package:yachtspot/widgets/boatdetailpage.dart';

const kBoatCardNameStyle = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: Colors.white);
const kBoatCardModelStyle = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w300,
  fontSize: 16,
  color: Colors.white,
);

class BoatCard extends StatelessWidget {
  BoatCard(
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BoatDetailPage(
              image: image,
              name: name,
              manufacturer: manufacturer,
              model: model,
              owner: owner,
              location: location,
              email: email,
              price: price,
            ),
          ),
        );
      },
      child: Container(
        width: 257,
        height: 380,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: NetworkImage(image.toString()),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: kBoatCardNameStyle,
              ),
              Text(
                '$manufacturer $model',
                style: kBoatCardModelStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
