import 'package:google_fonts/google_fonts.dart';
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
      margin: const EdgeInsets.fromLTRB(14, 8, 14, 8),
      padding: const EdgeInsets.fromLTRB(30, 20, 15, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100,
            margin: EdgeInsets.all(5),
            color: Colors.transparent,
            child: Image.network(
              "${itemImage}",
              errorBuilder:
                ((context, error, stackTrace) {
                return Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
                width: 64,
                );
                }),
              ),
          ),
          SizedBox(width: 20,),
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
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text(
                      "${itemName}",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                        )
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ),
                  Text(
                    "${itemAuthor}",
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400
                        )
                      ),
                  ),
                  Text(
                    "${itemYear}",
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600
                        )
                      ),
                  ),
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
                        Uri.parse("https://literasea.live/cart/remove-flutter/${UserInfo.data["id"]}/${pk}"),
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
