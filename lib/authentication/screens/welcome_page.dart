import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  stops: [0.2, 0.9],
                  end: Alignment.bottomCenter,
                  colors: [Colors.white, Color(0xff3992C6)])),
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Text(
                    "Welcome to Literasea!",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 30),
                      color: const Color(0xff00134E),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Literasea is a platform for you to buy your favorite books in the vast sea of knowledge. Dive into knowledge, sail with Literasea!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  MaterialButton(
                    elevation: 0.0,
                    color: Colors.white,
                    height: 60,
                    minWidth: double.infinity,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Login",
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    elevation: 0.0,
                    color: const Color(0xffd7e9f4),
                    height: 60,
                    minWidth: double.infinity,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Register",
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
