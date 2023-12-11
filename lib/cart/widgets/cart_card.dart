import 'package:flutter/material.dart';

class CartCard extends StatelessWidget {
  final String itemName;
  final String itemAuthor;
  final String itemYear;
  final String itemImage;
  const CartCard({super.key, required this.itemName, required this.itemAuthor, 
  required this.itemYear, required this.itemImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.fromLTRB(80, 12, 80, 12),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100,
            margin: EdgeInsets.all(5),
            color: Colors.transparent,
            child: Image.network("${itemImage}"),
          ),
          Expanded(
            flex: 6,
            child: Container(
              height: 100,
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "${itemName}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ),
                  Text("${itemAuthor}"),
                  Text("${itemYear}"),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 100,
              margin: EdgeInsets.all(5),
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                    ), 
                    onPressed: () {  },
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
