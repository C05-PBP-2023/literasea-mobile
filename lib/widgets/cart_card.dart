import 'package:flutter/material.dart';

class CartCard extends StatelessWidget {
  final String itemName;
  const CartCard({super.key, required this.itemName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.fromLTRB(80, 12, 80, 12),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: 100,
              margin: EdgeInsets.all(5),
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              height: 100,
              margin: EdgeInsets.all(5),
              color: Colors.white,
              child: Column(
            
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 100,
              margin: EdgeInsets.all(5),
              color: Colors.white,
            ),
          ),
        ],
      )
    );
  }
}
