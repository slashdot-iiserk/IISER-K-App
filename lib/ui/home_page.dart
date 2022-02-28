import 'package:flutter/material.dart';
import 'package:iiserk_app/helpers/app_futures.dart';
import 'package:iiserk_app/models/Token.dart';
import 'package:iiserk_app/models/base/EventObject.dart';
import 'package:iiserk_app/utils/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IISER K'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Login Page'),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}

// Create a Form widget.
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class LoginFormState extends State<LoginForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
              style: TextStyle(fontSize: 21.0),
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: InputBorder.none,
                  labelText: 'User Name',
                  labelStyle: TextStyle(fontSize: 20.0)),
              keyboardType: TextInputType.text,
              onChanged: (String value) async {
                setState(() {
                  _username = value;
                });
              }),
          TextFormField(
              style: TextStyle(fontSize: 21.0),
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: InputBorder.none,
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 20.0)),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              onChanged: (String value) async {
                setState(() {
                  _password = value;
                });
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  EventObject<Token> token =
                      await getTokenByLogin(_username, _password);
                  if (token.object!.token.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(SnackBarText.LOGIN_SUCCESSFUL)),
                    );
                  }
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
