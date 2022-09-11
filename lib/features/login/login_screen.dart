import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/session.dart';
import 'package:weather/models/user.dart';
import 'package:weather/services/login_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login',
            style: Theme.of(context).textTheme.headline6),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'toto@pop.com',
                border: OutlineInputBorder(),
              ),
              validator: (email) {
                if (email == null) {
                  return null;
                }
                return EmailValidator.validate(email) ? null : 'wrong format';
              },
              onSaved: (newEmail) => setState(() => _email = newEmail!),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              validator: (password) {
                if (password != null && password.length > 7) {
                  return null;
                }
                return 'wrong password format';
              },
              onSaved: (newPassword) => setState(() => _password = newPassword!),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            Consumer<Session>(
              builder: (context, session, _) {
                return ElevatedButton(onPressed: () {
                  final isValid = _formKey.currentState?.validate();
                  if (isValid == true) {
                    _formKey.currentState?.save();
                    User user = LoginService.login(_email, _password);
                    session.setUser(user);
                  }
                }, child: const Text('Validate'));
              },
            )
          ],
        ),
      ),
    );
  }
}

