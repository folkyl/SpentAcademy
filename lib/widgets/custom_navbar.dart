// main.dart atau app.dart
import 'package:flutter/material.dart';
import 'package:spentacademy/app/modules/home/views/home_view.dart';
import 'package:spentacademy/pages/quiz/quiz_view.dart';
import 'package:spentacademy/pages/profile/profile_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpentAcademy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Daftar halaman yang akan ditampilkan
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeView(),
      QuizView(),
      const MaterialPage(),
      const ProfileView(),
    ];
  }

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

// Material Page (placeholder untuk sementara)
class MaterialPage extends StatelessWidget {
  const MaterialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A4DA2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.folder_rounded,
                      size: 80,
                      color: Color(0xFF1E3A8A),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Learning Materials',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF002560),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Access your study materials and resources',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom bottom navigation bar with floating active indicator
class BottomNavbar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  static const double _floatingIconSize = 60;
  static const double _regularIconSize = 28;
  static const double _barHeight = 70;
  static const double _floatingOffset = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _barHeight + _floatingOffset,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main navigation bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: _barHeight,
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A8A),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) => _buildNavItem(index)),
              ),
            ),
          ),
          // Floating active indicator
          _buildFloatingIndicator(),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final bool isActive = index == widget.currentIndex;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTap(index),
        child: Container(
          height: _barHeight,
          alignment: Alignment.center,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isActive ? 0.0 : 1.0,
            child: Icon(
              _getIconData(index),
              color: Colors.white,
              size: _regularIconSize,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingIndicator() {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double sectionWidth = screenWidth / 4;
    final double leftPosition = (sectionWidth * widget.currentIndex) + 
                                (sectionWidth / 2) - (_floatingIconSize / 2);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      left: leftPosition,
      top: 0,
      child: Container(
        width: _floatingIconSize,
        height: _floatingIconSize,
        decoration: BoxDecoration(
          color: const Color(0xFF3B82F6),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          _getIconData(widget.currentIndex),
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  IconData _getIconData(int index) {
    const List<IconData> icons = [
      Icons.home_rounded,
      Icons.quiz_rounded,
      Icons.folder_rounded,
      Icons.person_rounded,
    ];
    
    return index < icons.length ? icons[index] : Icons.help_rounded;
  }
}