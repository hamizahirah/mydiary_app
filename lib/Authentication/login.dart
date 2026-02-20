import 'package:flutter/material.dart';
import 'package:mydiarylogin/Authentication/signup.dart';
import 'package:mydiarylogin/JsonModels/user.dart';
import 'package:mydiarylogin/SQLite/sqlite.dart';
import 'package:mydiarylogin/Views/notes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  bool isVisible = false;
  bool isLoginTrue = false;
  final db = DatabaseHelper();
  Future<void> login() async {
    var response = await db
        .login(Users(usrName: username.text, usrPassword: password.text));
    if (response == true) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Notes()),
      );
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              child: Column(
                children: [
                  Image.asset("assets/login.png", width: 210),
                  TextFormField(
                    controller: username,
                    decoration: const InputDecoration(
                        hintText: "Username", icon: Icon(Icons.person)),
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: !isVisible,
                    decoration: InputDecoration(
                      hintText: "Password",
                      icon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(isVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: login, child: const Text("Login")),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    child: const Text("Sign Up"),
                  ),
                  isLoginTrue
                      ? const Text("Invalid credentials",
                          style: TextStyle(color: Colors.red))
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
