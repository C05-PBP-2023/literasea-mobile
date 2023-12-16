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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Center(
        child: MaterialButton(
          elevation: 0.0,
          color: Colors.blue,
          height: 60,
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
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
