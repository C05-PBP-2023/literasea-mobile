import 'package:flutter/material.dart';
import 'package:literasea_mobile/json/const.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2))),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            bottomNavBarIcons.length,
            (idx) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(bottomNavBarIcons[idx]["icon"],
                            color:
                                _activeTab == idx ? Colors.blue : Colors.black),
                        Text(
                          bottomNavBarIcons[idx]["name"],
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: _activeTab == idx
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: _activeTab == idx
                                  ? Colors.blue
                                  : Colors.black),
                        ),
                      ],
                    ),
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
}
