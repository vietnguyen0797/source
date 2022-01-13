import 'package:flutter/material.dart';
import 'package:foodsapp/models/menu.dart';
import 'package:foodsapp/screens/detail_screen.dart';

class MenuCard extends StatelessWidget {
  final Menu menu;

  // ignore: use_key_in_widget_constructors
  const MenuCard(this.menu);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailScreen(menu: menu)));
      },
      child: Container(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 130,
                height: 110,
                child: Image.network(
                  menu.image,
                  width: 130,
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                menu.isBestseller
                    ? Image.asset(
                        'assets/bestseller.jpg',
                        width: 100,
                        height: 50,
                      )
                    : Image.asset(
                        'assets/hot.png',
                        width: 100,
                        height: 50,
                      ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '${menu.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Giá ${menu.price} VNĐ',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
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
