import 'package:flutter/material.dart';
import '../models/shae.dart';
class ShaeTile extends StatelessWidget {
  late final Shae shae;
  ShaeTile({required this.shae});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(top: 10),
    child: Card(
      margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.brown[shae.strength],
        ),
        title: Text(shae.name),
        subtitle: Text('Takes ${shae.sugars} sugars'),
      ),
    ),);
  }
}
