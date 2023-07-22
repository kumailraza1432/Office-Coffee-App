import 'package:firebaseproject/home/shae_tile.dart';
import 'package:firebaseproject/models/shae.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class ShaeList extends StatefulWidget {
  const ShaeList({Key? key}) : super(key: key);

  @override
  State<ShaeList> createState() => _ShaeListState();
}

class _ShaeListState extends State<ShaeList> {
  @override
  Widget build(BuildContext context) {
    final Shaee = Provider.of<List<Shae>?>(context);
    return ListView.builder(
      itemCount: Shaee?.length,
      itemBuilder: (context,index){
        return ShaeTile(shae: Shaee![index]);
      });
  }
}
