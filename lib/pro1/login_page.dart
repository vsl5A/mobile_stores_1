import 'package:flutter/material.dart';


import 'item_screen.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: buildHomePage(),
    );
  }

  Widget buildHomePage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login final'),
      ),
      body:  _LoginForm(),
    );
  }
}

class _LoginForm extends StatefulWidget {
   _LoginForm({super.key});

  static const String email = "a";
  static const String password = "1";
  bool rememberMe = false;

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override

  Widget build(BuildContext context) {

    return
SingleChildScrollView(
              child: Container(
                // Màu xám
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200, // Màu xám
                  borderRadius: BorderRadius.circular(10), // Bo tròn góc
                ),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: emailController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Email",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: _passwordVisible,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: "Password",
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    icon: Icon(_passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),

                        Row(
                          children: [
                            const Icon(Icons.phone_android),
                            const SizedBox(width: 8),// Icon trước checkbox
                            const Expanded(child: Text("Remember Me")),
                            Checkbox(
                              value: widget.rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  widget.rememberMe = value!;
                                  print('Remember Me is now: ${widget.rememberMe}');
                                });
                              },
                            ),
                          ],
                        )
                        ,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: _submit,
                            child: const Text('Submit'),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),),);
  }




  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (emailController.text == _LoginForm.email &&
          passwordController.text == _LoginForm.password) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => HomePage(
        //         email: emailController.text,
        //       )),
        // );
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemsScreen(
                email: emailController.text,

              ),
              settings: RouteSettings(arguments:{'isRemember':widget.rememberMe,
                'password':passwordController.text})),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Credentials')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill input')),
      );
    }
  }
}
