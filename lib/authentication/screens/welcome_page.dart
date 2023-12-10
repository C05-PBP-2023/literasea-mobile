import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/authentication/screens/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
          child: Stack(
            children: <Widget>[
              Container(
                height:
                    keyboardOpen ? 0 : MediaQuery.of(context).size.height / 3,
                padding: const EdgeInsets.symmetric(vertical: 60.0),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/welcome-page.png',
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 48.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome to\nLiterasea!",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 32),
                            color: const Color(0xff00134E),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "Literasea is a platform for you to buy your favorite books in the vast sea of knowledge.\nDive into knowledge, sail with Literasea!",
                            textAlign: TextAlign.start,
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
                  ),
                  Column(
                    children: <Widget>[
                      MaterialButton(
                        elevation: 0.0,
                        color: const Color(0xff3992C6),
                        height: 56,
                        minWidth: double.infinity,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const LoginPage();
                              },
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Login",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        elevation: 0.0,
                        color: Colors.white,
                        height: 56,
                        minWidth: double.infinity,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: const BorderSide(
                            color: Color(0xff3992C6),
                          ),
                        ),
                        child: Text(
                          "Register",
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xff3992C6),
                            ),
                          ),
                        ),
                      ),
                    ],
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
