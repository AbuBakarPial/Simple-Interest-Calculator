import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: "Simple Interest Calculator",
      home: SIform(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.yellowAccent,
        accentColor: Colors.yellowAccent,
      ),
    ));

class SIform extends StatefulWidget {
  @override
  _SIformState createState() => _SIformState();
}

class _SIformState extends State<SIform> {
  var _formkey = GlobalKey<FormState>();
  var _currencies = ['Taka', 'Pounds', 'Riyal'];
  var _currentitemselected = 'Taka';
  TextEditingController principalControlled = TextEditingController();
  TextEditingController iControlled = TextEditingController();
  TextEditingController termControlled = TextEditingController();

  var displayresult = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('SI UI'),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Image.asset(
                'images/download.png',
                width: 125.0,
                height: 125.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: principalControlled,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter principal amount';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Principle',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      hintText: 'Enter Principle',
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      errorStyle:
                          TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: iControlled,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter interest amount';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      hintText: 'Enter Interest',
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      errorStyle:
                          TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: termControlled,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter terms';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Term',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            hintText: 'Time in Years',
                            hintStyle: TextStyle(fontWeight: FontWeight.bold),
                            errorStyle: TextStyle(
                                color: Colors.yellowAccent, fontSize: 15.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0))),
                      ),
                    ),
                    //Spacer(),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currentitemselected,
                        onChanged: (String newvalue) {
                          _ondropdownitemselected(newvalue);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      highlightElevation: 6.0,
                      color: Colors.yellowAccent,
                      child: Text(
                        'Calculate',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_formkey.currentState.validate()) {
                            this.displayresult = _calculateTotal();
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      highlightElevation: 6.0,
                      color: Colors.black12,
                      child: Text('Reset',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(this.displayresult,
                    style: TextStyle(fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _ondropdownitemselected(String newvalue) {
    setState(() {
      this._currentitemselected = newvalue;
    });
  }

  String _calculateTotal() {
    double principal = double.parse(principalControlled.text);
    double interest = double.parse(iControlled.text);
    double term = double.parse(termControlled.text);

    double total = principal + (principal * interest * term) / 100;

    String result =
        'After $term years, your investment will be worth $total $_currentitemselected';
    return result;
  }

  void _reset() {
    principalControlled.text = '';
    iControlled.text = '';
    termControlled.text = '';
    displayresult = '';
    _currentitemselected = _currencies[0];
  }
}
