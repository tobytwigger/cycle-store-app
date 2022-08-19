import 'package:cycle_store_app/api/factory.dart';
import 'package:cycle_store_app/api/models.dart';
import 'package:cycle_store_app/api/repositories/user.dart';
import 'package:cycle_store_app/auth/auth.dart';
import 'package:cycle_store_app/auth/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _errorMessage = '';

  Future<void> submitForm() async {
    setState(() {
      _errorMessage = '';
    });
    bool result = await AuthProvider().login(_email, _password);
    if (result == false) {
      setState(() {
        _errorMessage = 'There was a problem with your credentials.';
      });
    }
    var client = await ClientFactory.create();
    var userRepository = UserRepository(client);
    User? currentUser = await userRepository.getCurrentUser();
    Provider.of<CurrentUser>(context, listen: false).user = currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the LoginScreen object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Sign In'),
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: ListView(children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Email',
                      icon: Icon(
                        Icons.mail,
                      )),
                  validator: (value) => value != null && value.isEmpty
                      ? 'Please enter an email address'
                      : null,
                  onSaved: (value) => _email = value ?? '',
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    icon: Icon(
                      Icons.lock,
                    ),
                  ),
                  obscureText: true,
                  validator: (value) => value != null && value.isEmpty
                      ? 'Please enter a password'
                      : null,
                  onSaved: (value) => _password = value ?? '',
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                  child: ElevatedButton(
                    child: Text('Login'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        submitForm();
                      }
                    },
                  ),
                ),
              ]),
            )),
      ),
    );
  }
}
