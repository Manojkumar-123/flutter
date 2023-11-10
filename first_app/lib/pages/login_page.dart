import 'package:first_app/pages/signup_page.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('First App'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
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
                decoration: InputDecoration(
                    labelText: 'Enter your password',
                    prefixIcon: const Icon(Icons.password),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(child: Text('''Dont't have an account?''')),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScreen()));
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
