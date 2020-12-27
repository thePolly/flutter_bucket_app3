import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'bucket.dart';

class EditScreen extends StatefulWidget {
  Bucket bucket;

  EditScreen({Key key, @required this.bucket}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String priority = 'medium';
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
                    initialValue: widget.bucket.name,
                    decoration: InputDecoration(
                      labelText: "Name:",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      widget.bucket.name = text;
                    },
                  ),
                  TextFormField(
                    initialValue: widget.bucket.date.day.toString() +
                        "-" +
                        widget.bucket.date.month.toString() +
                        "-" +
                        widget.bucket.date.year.toString(),
                    decoration: InputDecoration(
                      labelText: "Date:",
                      hintText: 'dd-MM-yyyy',
                    ),
                    inputFormatters: [
                      new MaskTextInputFormatter(
                          mask: '##-##-####', filter: {"#": RegExp(r'[0-9]')})
                    ],
                    onChanged: (text) {
                      if (text != null || text.length != 0) {
                        DateFormat dateFormat = DateFormat("dd-MM-yyyy");
                        widget.bucket.date = dateFormat.parse(text);
                      } else {
                        widget.bucket.date = new DateTime.now();
                      }
                    },
                  ),
                  DropdownButton<String>(
                    value: widget.bucket.priority,
                    isExpanded: true,
                    isDense: false,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 22,
                    elevation: 2,
                    underline: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        priority = newValue;
                        widget.bucket.priority = newValue;
                      });
                    },
                    items: <String>['low', 'medium', 'high', 'critical']
                        .map<DropdownMenuItem<String>>((String priority) {
                      return DropdownMenuItem<String>(
                        value: priority,
                        child: Text(priority),
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    initialValue: widget.bucket.description,
                    decoration: InputDecoration(
                        hintText: 'Enter a bucket description',
                        labelText: "Description"),
                    onChanged: (text) {
                      if (text != null || text.length != 0) {
                        widget.bucket.description = text;
                      } else {
                        widget.bucket.description = "";
                      }
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
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            widget.bucket.setIcon();
                            Navigator.pop(context);
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
