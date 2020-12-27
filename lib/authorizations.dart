import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterbucketapp/homePage.dart';
import 'package:flutterbucketapp/user.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';



class AuthorizationScreen extends StatefulWidget {

  @override
  _AuthorizationScreen createState() => _AuthorizationScreen();
}

class _AuthorizationScreen extends State<AuthorizationScreen> {
  User user = new User(name: "my");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),


          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Login:",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your login';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      print("CHANGE!");
                        user.name = text;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password:",
                           ),
                    onChanged: (text) {
                    },
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.lightBlue)),
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState.validate()) {

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(user: user,)),);
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
