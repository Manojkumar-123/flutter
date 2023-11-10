import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First App'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const Text(
                'Sign Up',
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Enter your password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(child: Text('''Already have an account?''')),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Log In'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
