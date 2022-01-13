import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodsapp/models/menu.dart';
import 'package:foodsapp/models/size.dart';
import 'package:foodsapp/widgets/size_card.dart';

import 'home_screen.dart';


class DetailScreen extends StatefulWidget {
  final Menu menu;

  const DetailScreen({Key? key, required this.menu}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreen();
}

class _DetailScreen extends State<DetailScreen> {
  CollectionReference order = FirebaseFirestore.instance.collection('order');
  int price = 0;

  int i = 1 ;

  bool isNho = true;
  bool isVua = false;
  bool isLon = false;
  bool isDacBiet = false;

  void minus() {
    if (i > 1) {
      setState(() {
        i--;
        // if(isNho == false)
        // {price = widget.menu.price;}
        if(isNho == true){
          price = widget.menu.price;
        }else if(isVua == true){
          price = (widget.menu.price + 10000) * i;
        }
        else if(isLon == true){
          price = (widget.menu.price + 15000) * i;
        }
        else if(isDacBiet == true){
          price = (widget.menu.price + 20000) * i;
        }


      });
    }
  }

  void _plus() {
    setState(() {
      i++;
      if(isNho == true){
        price = widget.menu.price * i;
      }else if(isVua == true){
        price = (widget.menu.price + 10000) * i;
      }
      else if(isLon == true){
        price = (widget.menu.price + 15000) * i;
      }
      else if(isDacBiet == true){
        price = (widget.menu.price + 20000) * i;
      }
    });
  }

  void _clickNho() {
    setState(() {
      price = widget.menu.price * i;
      isNho = true;
      isVua = false;
      isLon = false;
      isDacBiet = false;
    });
  }

  void _clickVua() {
    setState(() {
      price = (widget.menu.price + 10000) * i;
      isNho = false;
      isVua = true;
      isLon = false;
      isDacBiet = false;
    });
  }

  void _clickLon() {
    setState(() {
      price = (widget.menu.price + 15000) * i;
      isNho = false;
      isVua = false;
      isLon = true;
      isDacBiet = false;
    });
  }

  void _clickDacBiet() {
    setState(() {
      price = (widget.menu.price + 20000) * i ;
      isNho = false;
      isVua = false;
      isLon = false;
      isDacBiet = true;
    });
  }
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Stack(
          children: [
            Image.network(
              widget.menu.image,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            InkWell(

              child: Image.asset(
                'assets/btn_back.png',
                width: 40,
              ),
              onTap: () {
                Navigator.pop(context);
              }
            ),
            ListView(
              children: [
                const SizedBox(height: 264),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.menu.isBestseller?
                            Image.asset(
                              'assets/bestseller.jpg',
                              width: 50,
                            ):
                            Image.asset(
                              'assets/hot.png',
                              width: 50,
                            ),

                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  widget.menu.name,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: minus,
                                  child: Image.asset(
                                    'assets/minus.png',
                                    width: 34,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Text('${i}',
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    )),
                                const SizedBox(
                                  width: 16,
                                ),
                                InkWell(
                                  onTap: _plus,
                                  child: Image.asset(
                                    'assets/plus.png',
                                    width: 34,
                                  ),
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              '$price''VNĐ',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            const Text(
                              'Chọn Size',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(children: [
                              InkWell(
                                onTap: _clickNho,
                                child: SizeCard(Size(
                                  id: 1,
                                  name: 'Nhỏ',
                                  isActive: isNho,
                                )),
                              ),
                              const SizedBox(width: 24),
                              InkWell(
                                onTap: _clickVua,
                                child: SizeCard(Size(
                                  id: 2,
                                  name: 'Vừa',
                                  isActive: isVua,
                                )),
                              ),
                              const SizedBox(width: 24),
                              InkWell(
                                onTap: _clickLon,
                                child: SizeCard(Size(
                                  id: 3,
                                  name: 'Lớn',
                                  isActive: isLon,
                                )),
                              ),
                              const SizedBox(width: 24),
                              InkWell(
                                onTap: _clickDacBiet,
                                child: SizeCard(Size(
                                  id: 4,
                                  name: 'Đặc Biệt',
                                  isActive: isDacBiet,
                                )),
                              ),
                            ]),
                            const SizedBox(height: 18),
                            const Text(
                              'Mô Tả',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                widget.menu.note,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 150),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                padding: const EdgeInsets.only(
                                  top: 12,
                                  bottom: 12,
                                ),
                                color: Colors.yellow,
                                onPressed: () {
                                  // FirebaseFirestore.instance.collection('order')
                                  order
                                  .add({'ID':user.uid,'name': widget.menu.name, 'price': price, 'quantity': i})
                                  .then((value) =>
                                      showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        content: Text('Đặt Thành Công'),
                                      ),

                                  ),
                                  )
                                      .catchError((error)=> AlertDialog(

                                    content: Text('Đặt Thành Công'),
                                  ),
                                  );
                                  },



                                child: const Text(
                                  'Thêm vào giỏ hàng',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
