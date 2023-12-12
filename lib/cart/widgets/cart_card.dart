import 'package:literasea_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartCard extends StatelessWidget {
  final int pk;
  final String itemName;
  final String itemAuthor;
  final String itemYear;
  final String itemImage;
  final void Function() refreshCart;

  const CartCard({super.key, required this.pk, required this.itemName, required this.itemAuthor, 
  required this.itemYear, required this.itemImage, required this.refreshCart});

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
                    onPressed: () async { 
                      // final response = await request.postJson(
                      //   "http://127.0.0.1:8080/cart/remove-flutter/${UserInfo.data["id"]}/${pk}",

                      // )
                      
                      final response = await http.post(
                        Uri.parse("http://127.0.0.1:8000/cart/remove-flutter/${UserInfo.data["id"]}/${pk}"),
                      );

                      if (response.statusCode == 200) {
                        refreshCart();
                      }
                    },
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
