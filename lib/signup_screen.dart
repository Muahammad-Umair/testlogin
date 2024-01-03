import 'package:flutter/material.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late FocusNode emailFocus;
  late FocusNode passwordFocus;
  late FocusNode phoneFocus;
  @override
  void initState() {
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    phoneFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    phoneFocus.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        title: const Text("SignUp"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                focusNode: emailFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(phoneFocus);
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
                    label: const Text("Enter the email"),
                    hintText: "@examples",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.blueAccent,
                        ))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: phoneController,
                focusNode: phoneFocus,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(passwordFocus);
                },
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a valid phone number";
                  }
                },
                decoration: InputDecoration(
                    label: const Text("Enter the phone"),
                    hintText: "+92302......",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.blueAccent,
                        ))),
              ),
              const SizedBox(
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
                    label: const Text("Enter the password"),
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
                        borderSide: const BorderSide(
                          color: Colors.blueAccent,
                        ))),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Alert!"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Your email is: ${emailController.text}"),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Your phone is: ${phoneController.text}"),
                            const SizedBox(
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
                child: const Text("Sign Up"),
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
                builder: (context) => LoginScreen(),
              ),
            );
          },
          child: Text("Sign In"),
        ),
      ),
    );
  }
}
