import 'package:first_app/pages/home_page.dart';
import 'package:first_app/pages/signup_page.dart';
import 'package:first_app/services/auth_methods.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<String> loginUser() async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    var res = await AuthMethods().LoginUser(
        email: _emailController.text, password: _passwordController.text);
    return res;
  }

  void pushHomeScreen() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invalid Credentials -__-'),
        duration: Duration(seconds: 10),
      ),
    );
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('First App'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                        decorationStyle: TextDecorationStyle.double,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: 'Enter your email',
                          prefixIcon: const Icon(Icons.text_fields),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          labelText: 'Enter your password',
                          prefixIcon: const Icon(Icons.password),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          String res = await loginUser();
                          setState(() {
                            isLoading = false;
                          });
                          if (res == "success") {
                            pushHomeScreen();
                          } else {
                            showSnackBar();
                          }
                        },
                        child: const Text('Log In')),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                            child: Text('''Dont't have an account?''')),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen()));
                            },
                            child: const Text('Sign Up'))
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
