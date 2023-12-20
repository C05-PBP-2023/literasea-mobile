import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:literasea_mobile/authentication/screens/login_page.dart';
import 'package:literasea_mobile/authentication/widgets/text_field_form.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String? _userTypeController;
  String _usernameController = "";
  String _fullnameController = "";
  String _emailController = "";
  String _passwordController = "";
  String _passwordConfController = "";

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: _isLoading ? const Color(0xFFB1B1B1) : Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 24,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  children: [
                    Container(
                      height: 64,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/logo.png',
                            ),
                            fit: BoxFit.scaleDown),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Register",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Create an account to access Literasea",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[500],
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          getTextFields(),
                          const SizedBox(height: 32.0),
                          MaterialButton(
                            elevation: 0.0,
                            color: const Color(0xff3992C6),
                            height: 56,
                            minWidth: double.infinity,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                final navigator = Navigator.of(context);
                                String? usertype = _userTypeController;
                                String username = _usernameController;
                                String fullname = _fullnameController;
                                String email = _emailController;
                                String password = _passwordController;
                                String password2 = _passwordConfController;
                                setState(() {
                                  _isLoading = true;
                                });
                                final response = await request.postJson(
                                    "https://literasea.live/auth/register-mobile/",
                                    jsonEncode(<String, String>{
                                      'user_type': usertype!,
                                      'username': username,
                                      'full_name': fullname,
                                      'email': email,
                                      'password1': password,
                                      'password2': password2
                                    }));
                                await Future.delayed(
                                    const Duration(milliseconds: 1), () {
                                  if (response['status'] == true) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          "Your account has been successfully created!"),
                                    ));
                                    navigator.pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ),
                                    );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Register failed'),
                                        content: Text(response['message']),
                                        actions: [
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              navigator.pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                });
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Register",
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (_isLoading) ...[
              const Opacity(
                opacity: 0.3,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                  ),
                ),
              ),
              const Center(
                child: CircularProgressIndicator(
                  color: Color(0xff3992c6),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget getTextFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            errorStyle:
                GoogleFonts.inter(textStyle: const TextStyle(fontSize: 11)),
            prefixIcon: const Icon(
              Icons.book,
              size: 18,
              color: Color(0xff3992C6),
            ),
            filled: true,
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xff3992C6)),
            ),
            isDense: true,
            contentPadding:
                const EdgeInsets.only(top: 16.0, bottom: 16, right: 12.0),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
          value: _userTypeController,
          onChanged: (String? newValue) {
            setState(() {
              _userTypeController = newValue!;
            });
          },
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Choose an account type!";
            }
            return null;
          },
          hint: const Text(
            "Choose your account type...",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: "reader",
              child: Text("Reader"),
            ),
            DropdownMenuItem(
              value: "writer",
              child: Text("Writer"),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        TextFormFieldWidget(
          "Username",
          Icons.account_circle_outlined,
          false,
          (val) {
            setState(() {
              _usernameController = val;
            });
          },
          null,
        ),
        const SizedBox(height: 20.0),
        TextFormFieldWidget(
          "Name",
          Icons.assignment_ind,
          false,
          (val) {
            setState(() {
              _fullnameController = val;
            });
          },
          null,
        ),
        const SizedBox(height: 20.0),
        TextFormFieldWidget(
          "Email",
          Icons.email,
          false,
          (val) {
            setState(() {
              _emailController = val;
            });
          },
          (val) {
            String pattern =
                r'(^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$)';
            RegExp regExp = RegExp(pattern);
            if (val == null || val.isEmpty) {
              return "Email can't be empty!";
            } else if (!regExp.hasMatch(val)) {
              return 'Please enter a valid email.';
            }
            return null;
          },
        ),
        const SizedBox(height: 20.0),
        TextFormFieldWidget(
          "Password",
          Icons.key,
          true,
          (val) {
            setState(() {
              _passwordController = val;
            });
          },
          null,
        ),
        const SizedBox(height: 20.0),
        TextFormFieldWidget(
          "Password confirmation",
          Icons.key,
          true,
          (val) {
            setState(() {
              _passwordConfController = val;
            });
          },
          (String? val) {
            if (val == null || val.isEmpty) {
              return "The two passwords didn't match.";
            } else if (val != _passwordController) {
              return "The two passwords didn't match.";
            }
            return null;
          },
        ),
      ],
    );
  }
}
