import 'package:flutter/material.dart';
import 'package:logintest/signup_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailFocus;
  late FocusNode passwordFocus;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                focusNode: emailFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(passwordFocus);
                },
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a valid email";
                  } else if (!value.contains('@')) {
                    return "Email is not valid";
                  }
                },
                decoration: InputDecoration(
                    label: Text("Enter the email"),
                    hintText: "@examples",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                        ))),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                focusNode: passwordFocus,
                obscureText: isVisible,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a valid password";
                  } else if (value.length < 6) {
                    return "Password shoudl be 6 character long";
                  }
                },
                decoration: InputDecoration(
                    isDense: true,
                    alignLabelWithHint: true,
                    label: Text("Enter the password"),
                    hintText: "******",
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: Icon(
                        isVisible ? Icons.visibility_off : Icons.visibility,
                        size: 20,
                      ),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                        ))),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Alert!"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Your email is: ${emailController.text}"),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "Your password is: ${passwordController.text}"),
                          ],
                        ),
                      ),
                    );
                  }
                },
                child: Text("Sign In"),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Future<void> launchPhoneDialer(BuildContext context) async {

                  String phoneNumber =
                      '+923023147342'; // Replace with the desired phone number

                  final Uri phoneUri = Uri(scheme: "tel", path: phoneNumber);
                  try {
                    await launchUrl(phoneUri);
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error.toString()),
                      ),
                    );
                  }
                  // }
                },
                child: Text("Open Dialer"),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpScreen(),
              ),
            );
          },
          child: Text("Sign Up"),
        ),
      ),
    );
  }
}
