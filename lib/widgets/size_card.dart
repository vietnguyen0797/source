import 'package:flutter/material.dart';
import 'package:foodsapp/models/size.dart';

class SizeCard extends StatelessWidget {
  final Size size;

  const SizeCard(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(

        child:


        size.isActive
            ? Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(
                color: Colors.grey,
                width: 1.5,
              )),
          child: Text(
            size.name,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          ),
        ) :

        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.5,
              )),
          child: Text(
            size.name,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          ),
        ) ,
    );
  }
}
