import 'package:cycle_store_app/api/factory.dart';
import 'package:cycle_store_app/api/models/user.dart';
import 'package:cycle_store_app/api/repositories/user.dart';
import 'package:cycle_store_app/auth/auth.dart';
import 'package:cycle_store_app/auth/currentUser.dart';
import 'package:cycle_store_app/widgets/page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    if (!mounted) return;
    Provider.of<CurrentUser>(context, listen: false).user = currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return PageWidget(
      includeDrawer: false,
      header: 'Sign In',
      child: Center(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: ListView(children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
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
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      submitForm();
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
