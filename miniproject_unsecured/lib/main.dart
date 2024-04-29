import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:miniproject_unsecured/authentication/auth/auth_page.dart';
import 'package:miniproject_unsecured/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ADYPKC',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const AuthPage(),
    );
  }
}
