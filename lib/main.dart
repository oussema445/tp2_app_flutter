import 'package:flutter/material.dart';
import 'package:numbers_to_text/numbers_to_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late double _numberFrom;
  String _resultEnglish = '';
  String _resultArabic = '';

  @override
  void initState() {
    _numberFrom = 0;
    super.initState();
  }

  void _validate(String language) {
    if (_numberFrom != 0) {
      setState(() {
        final converter = NumbersToTextConverter(language);

        final intPart = _numberFrom.toInt();
        final decimalPart = (_numberFrom - intPart) * 1000;

        if (language == 'en') {
          _resultEnglish = converter.fromInt(intPart);
          if (decimalPart > 0) {
            _resultEnglish += ' and ' + converter.fromInt(decimalPart.toInt()) + ' cents';
          }
        } else if (language == 'ar') {
          _resultArabic = converter.fromInt(intPart);
          if (decimalPart > 0) {
            _resultArabic += ' و ' + converter.fromInt(decimalPart.toInt()) + ' مليماً';
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Number to Text'),
          backgroundColor: Colors.blue[800],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    var rv = double.tryParse(text);
                    if (rv != null) {
                      setState(() {
                        _numberFrom = rv;
                      });
                    }
                  },
                ),
              ),
              Text(_numberFrom.toString()),
              ElevatedButton(
                onPressed: () => _validate('en'),
                child: Text('Convert to English'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
              ElevatedButton(
                onPressed: () => _validate('ar'), //
                child: Text('Convert to Arabic'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                ),
              ),
              Text(
                _resultEnglish.isNotEmpty ? 'English: $_resultEnglish' : '',
                style: TextStyle(fontSize: 24, color: Colors.blue),
              ),
              Text(
                _resultArabic.isNotEmpty ? 'Arabic: $_resultArabic' : '',
                style: TextStyle(fontSize: 24, color: Colors.yellow),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
