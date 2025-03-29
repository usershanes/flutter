import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loggedIn = false;
  String? name;

  final _nameController = TextEditingController();
  final _emailControlle = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: loggedIn ? _buildSuccess() : _buildLoginForm(),
      ),
    );
  }

  Widget _buildSuccess() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.check, color: Colors.orangeAccent),
        Text('Hi $name')
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Runner'
              ),
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Enter the runner\'s name.';
                }
                return null;
              },
            ),

            TextFormField(
              controller: _emailControlle,
              decoration: InputDecoration(
                  labelText: 'Email'
              ),
              validator: (text) {
               if (text == null || text.isEmpty) {
                 return 'Enter the runner\'s email.';
               }

               final regex = RegExp('[^@]+@[^\.]+\..+');
               if ( !regex.hasMatch(text) ){
                 return 'Enter a valid email';
               }
               return null;
            },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Continue'),
              onPressed: _validate,
            ),
          ],
        ),
      ),
    );
  }
  void _validate() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        loggedIn = true;
        name = _nameController.text;
      });
    }
  }
}

