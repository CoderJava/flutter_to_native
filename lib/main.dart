import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform = const MethodChannel('flutter.native/helper');
  String greeting;

  @override
  void initState() {
    greeting = 'Greeting from Flutter Code';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter to Native'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Call Native Code'),
              onPressed: () async {
                try {
                  final String result = await platform.invokeMethod(
                    'greetingFromNativeCode',
                    {"name": "Yudi Setiawan"},
                  );
                  greeting = result;
                } on PlatformException catch (e) {
                  greeting = 'Failed to invoke: ${e.message}.';
                }
                setState(() {});
              },
            ),
            SizedBox(height: 16.0),
            Text(greeting),
          ],
        ),
      ),
    );
  }
}
