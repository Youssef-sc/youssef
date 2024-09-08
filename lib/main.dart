import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_provider.dart'; // تأكد من وجود هذا الملف في مجلد lib

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        title: 'Smart Consumption Advisor',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: const TextTheme(
            titleLarge:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(color: Colors.white70),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.teal[700], // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final TextEditingController _feature1Controller = TextEditingController();
  final TextEditingController _feature2Controller = TextEditingController();

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Consumption Advisor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _feature1Controller,
              decoration: const InputDecoration(
                labelText: 'Feature 1',
                prefixIcon: Icon(Icons.numbers),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _feature2Controller,
              decoration: const InputDecoration(
                labelText: 'Feature 2',
                prefixIcon: Icon(Icons.numbers),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a value';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (Form.of(context).validate()) {
                  final feature1 = double.parse(_feature1Controller.text);
                  final feature2 = double.parse(_feature2Controller.text);
                  Provider.of<DataProvider>(context, listen: false)
                      .analyzeData(feature1, feature2);
                }
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 24),
            Consumer<DataProvider>(
              builder: (context, dataProvider, child) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.teal[100],
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    'Result: ${dataProvider.result}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
