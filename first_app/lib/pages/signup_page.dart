import 'package:first_app/pages/home_page.dart';
import 'package:first_app/services/auth_methods.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Something went wrong... CONNECTION ERROR or Try with correct email and Strong Password'),
        duration: Duration(seconds: 10),
      ),
    );
  }

  bool isLoading = false;

  Future<String> signUpUser() async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text, password: _passwordController.text);
    setState(() {
      isLoading = false;
    });
    return res;
  }

  void pushHomeScreen() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First App'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: 'Enter your email',
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
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          var res = await signUpUser();
                          if (res.toString() == "success") {
                            pushHomeScreen();
                          } else {
                            showSnackBar();
                          }
                        },
                        child: const Text('Creare Account')),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Center(
                            child: Text('''Already have an account?''')),
                        const SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
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
