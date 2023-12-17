import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/authentication/screens/welcome_page.dart';
import 'package:literasea_mobile/main.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final navigator = Navigator.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.account_circle_rounded,
          size: 150,
          color: Color(0xff3992c6),
        ),
        Text(
          UserInfo.data["username"],
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: Colors.black
            ),
          ),
        ),
        Text(
          "READER",
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 14,
              color: Colors.black
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Name",
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Colors.black
                ),
              ),
            ),
            Text(
              UserInfo.data["fullname"],
              style: GoogleFonts.inter(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xff3992c6)
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Center(
            child: MaterialButton(
              elevation: 0.0,
              color: const Color(0xff3894c8),
              height: 55,
              minWidth: double.infinity,
              onPressed: () async {
                final response = await request
                    .logout("https://literasea.live/auth/logout-mobile/");
                if (response["status"]) {
                  UserInfo.logout();
                  navigator.pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return const WelcomePage();
                      },
                    ),
                  );
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                "Logout",
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
