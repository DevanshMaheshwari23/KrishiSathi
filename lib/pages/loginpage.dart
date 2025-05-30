import 'package:krishi_sathi/firebase/auth.dart';
import 'package:krishi_sathi/pages/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class AgricultureLoginPage extends StatefulWidget {
  const AgricultureLoginPage({super.key});

  @override
  State<AgricultureLoginPage> createState() => _AgricultureLoginPageState();
}

class _AgricultureLoginPageState extends State<AgricultureLoginPage> {
  final bool _isLogin = true;
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _controllerEmail.value.text;
    final password = _controllerPassword.value.text;

    setState(() => _loading = true);

    if (_isLogin) {
      await Auth().signInWithEmailAndPassword(email, password);
    } else {
      await Auth().registerWithEmailAndPassword(email, password);
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 150,
                ),
                const SizedBox(height: 40.0),
                TextFormField(
                  controller: _controllerEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _controllerPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  obscureText: true,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.7),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Implement forgot password functionality here
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () => handleSubmit(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: _loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AgricultureSignPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  'or login with',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement login with Google functionality here
                      },
                      icon: const Icon(UniconsLine.google),
                      label: const Text('Google'),
                    ),
                    const SizedBox(width: 10.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement login with Facebook functionality here
                      },
                      icon: const Icon(UniconsLine.facebook_f),
                      label: const Text('Facebook'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
