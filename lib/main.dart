import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/exercise_screen.dart';
import 'screens/tracker_screen.dart';
import 'screens/knowledge_screen.dart';
import 'screens/profile_screen.dart';
import 'providers/user_provider.dart';
import 'providers/exercise_provider.dart';

void main() {
  runApp(const FatBurnCoachApp());
}

class FatBurnCoachApp extends StatelessWidget {
  const FatBurnCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ExerciseProvider()),
      ],
      child: MaterialApp(
        title: '燃脂助手',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
          primaryColor: const Color(0xFFFF6B35),
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFFF6B35),
            elevation: 0,
          ),
          cardTheme: CardTheme(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFFFF6B35),
            unselectedItemColor: Colors.grey,
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ExerciseScreen(),
    const TrackerScreen(),
    const KnowledgeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: '运动',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: '统计',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: '知识',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
