import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/Katalog/Screens/reader.dart';
import 'package:literasea_mobile/forum/screens/forum.dart';
import 'package:literasea_mobile/json/const.dart';
import 'package:literasea_mobile/review/screens/review.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Image.asset('assets/images/tes_gambar.png'),
            ),
            ...List.generate(
              3,
              (index) {
                return Container(
                  padding: const EdgeInsets.only(
                      right: 20.0, left: 20.0, bottom: 20.0),
                  height: 100,
                  width: double.infinity,
                  child: Material(
                    child: InkWell(
                      child: Container(
                        width: 65,
                        height: 25,
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade100,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Icon(homePageButtons[index]["icon"]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                homePageButtons[index]["name"],
                                style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        if (homePageButtons[index]["name"] == "Catalogue") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProductPage()));
                        } else if (homePageButtons[index]["name"] ==
                            "Reviews") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ReviewPage()));
                        } else if (homePageButtons[index]["name"] == "Q & A") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const QNAPage()));
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
