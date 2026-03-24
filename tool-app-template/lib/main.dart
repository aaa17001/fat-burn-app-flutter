import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'screens/home_screen.dart';
import 'screens/payment_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Tool App Template',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: const Color(0xFFFF6B35),
          scaffoldBackgroundColor: Colors.grey[50],
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
