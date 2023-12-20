import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/authentication/screens/logout_page.dart';
import 'package:literasea_mobile/cart/screens/history.dart';
import 'package:literasea_mobile/cart/screens/cart.dart';
import 'package:literasea_mobile/json/const.dart';
import 'package:literasea_mobile/main.dart';
import 'package:literasea_mobile/screens/home_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _activeTab == 0 || _activeTab == 2
          ? null
          : AppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 60,
              title: Text(
                _activeTab == 0
                    ? "Hello, ${UserInfo.data["fullname"]}!"
                    : bottomNavBarIcons[_activeTab]["name"],
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              elevation: 0.0,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    color: Colors.black,
                    tooltip: "Open shopping cart",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CartPage()));
                    },
                  ),
                )
              ],
            ),
      body: getBody(),
      bottomNavigationBar: customBottomNavbar(),
      backgroundColor: _activeTab == 0 ? const Color(0xff3992c6) : Colors.white,
    );
  }

  Widget customBottomNavbar() {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.1))),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            bottomNavBarIcons.length,
            (idx) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(bottomNavBarIcons[idx]["icon"],
                          color: _activeTab == idx
                              ? const Color(0xff3992c6)
                              : Colors.black),
                      const SizedBox(height: 4),
                      Text(
                        bottomNavBarIcons[idx]["name"],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: 12,
                              fontWeight: _activeTab == idx
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: _activeTab == idx
                                  ? const Color(0xff3992c6)
                                  : Colors.black),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(
                      () {
                        _activeTab = idx;
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: _activeTab,
      children: const [
        MyHomePage(title: "Literasea"),
        Center(child: Text("Page 2")),
        HistoryPage(homePage: true,),
        LogoutPage()
      ],
    );
  }
}
