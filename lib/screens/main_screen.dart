import 'package:akkas_app_store/screens/book_screen.dart';
import 'package:akkas_app_store/screens/favorite_screen.dart';
import 'package:akkas_app_store/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
// import 'books_screen.dart';
// import 'favorite_screen.dart';
// import 'profile_screen.dart';

import '../widgets/customAppBar.dart';
import '../widgets/cuustomDrawer.dart';
import '../widgets/bottom_navigation.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    BooksScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),

      drawer: CustomDrawer(),

      body: IndexedStack(index: currentIndex, children: pages),

      bottomNavigationBar: CustomBottomNavigation(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
