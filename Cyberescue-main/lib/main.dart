import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
    print('dotenv loaded successfully');
  } catch (e) {
    print('Error loading dotenv: $e');
  }

  runApp(CyberEscueApp());
}

class CyberEscueApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cyberescue',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(), // This is enough to start
    );
  }
}
