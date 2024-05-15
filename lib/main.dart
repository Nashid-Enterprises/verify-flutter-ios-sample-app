import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const platformChannel = MethodChannel('test.flutter.methodchannel/iOS');

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> getScanDocument() async {
    String model;
    try {
      // 1
      final String result = await platformChannel.invokeMethod('scanDocument');
      // 2
      model = result;
      print(model);
    } catch (e) {
      model = "Can't fetch the method: '$e'.";
    }
  }

  Future<void> getScanPassport() async {
    String model;
    try {
      // 1
      final String result = await platformChannel.invokeMethod('scanPassport');
      // 2
      model = result;
      print(model);
    } catch (e) {
      model = "Can't fetch the method: '$e'.";
    }
  }

  Future<void> scanResult() async {
    String model;
    try {
      // 1
      final String result = await platformChannel.invokeMethod('scanResult');

      // 2
      model = result;
      print(model);
    } catch (e) {
      // 3
      model = "Can't fetch the method: '$e'.";
    }
  }

  @override
  void initState() {
    super.initState();
    scanResult();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                getScanDocument();
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.green,
                ),
              ),
              child: const Text(
                'Scan Id Card',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                getScanPassport();
              },
              style: const ButtonStyle(
                side: MaterialStatePropertyAll(
                  BorderSide(
                    color: Colors.red,
                    width: 1.5,
                  ),
                ),
              ),
              child: const Text(
                'Scan Passport',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
