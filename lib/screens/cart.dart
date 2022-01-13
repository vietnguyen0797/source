import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {


  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference order = firestore.collection('order');
    getid()
    {
      return user.uid.toString();
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Hello, Viet',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text('Welcome to Hamburger Store ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  )),
              const SizedBox(
                height: 32,
              ),
              const Text(
                  'Giỏ Hàng',

                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
              const SizedBox(
                height: 32,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: order.where("ID",isEqualTo: getid()).snapshots(),
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: (snapshot.data! as QuerySnapshot)
                                .docs
                                .map(
                                  (e) =>
                                      Card(
                                        child: Row(
                                          children: [
                                            Container(
                                              child: Text('Tên Món:'+e['name']),
                                            ),
                                            SizedBox(width: 24),

                                            Container(
                                              child: Text('Số Lượng:${e['quantity']}'),
                                            ),
                                            SizedBox(width: 24),
                                            Container(
                                              child: Text('Giá:${e['price']}'),
                                            ),
                                          ],
                                        ),
                                      ),
                            ).toList(),
                          );
                        } else {
                          return const Center(child: CircularProgressIndicator());
                        }
                      }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
