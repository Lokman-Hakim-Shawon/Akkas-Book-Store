import 'package:akkas_app_store/services/api_service.dart';
import 'package:flutter/material.dart';

import 'package:akkas_app_store/screens/about_us_screen.dart';
import 'package:akkas_app_store/screens/all_books_screen.dart';
import 'package:akkas_app_store/screens/author_screen.dart';
import 'package:akkas_app_store/screens/categoriey_book_screen.dart';
import 'package:akkas_app_store/screens/contact_screen.dart';
import 'package:akkas_app_store/screens/favorite_book_screen.dart';
import 'package:akkas_app_store/screens/main_screen.dart';
import 'package:akkas_app_store/screens/new_publication.dart';
import 'package:akkas_app_store/screens/settings_screen.dart';

import 'package:akkas_app_store/widgets/drawer_footer.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<Map<String, dynamic>>(
        // =========================
        // LOAD API.JSON
        // =========================
        future: ApiService.loadApi(),

        builder: (context, snapshot) {
          // =========================
          // LOADING
          // =========================

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }

          // =========================
          // ERROR
          // =========================

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Text(
                  'Navigation data load করতে সমস্যা হয়েছে\n\n'
                  '${snapshot.error}',

                  textAlign: TextAlign.center,

                  style: const TextStyle(fontSize: 15, color: Colors.red),
                ),
              ),
            );
          }

          // =========================
          // CHECK DATA
          // =========================

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text(
                'Navigation data পাওয়া যায়নি।',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          // =========================
          // API DATA
          // =========================

          final data = snapshot.data!;

          final apiData = data['data'];

          if (apiData == null) {
            return const Center(
              child: Text(
                'API data পাওয়া যায়নি।',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          // =========================
          // NAVIGATION DATA
          // =========================

          final List navigation = apiData['navigation'] as List? ?? [];

          // =========================
          // AUTHOR DATA
          // =========================

          final Map<String, dynamic> author = apiData['author'] != null
              ? Map<String, dynamic>.from(apiData['author'])
              : {};

          final String authorName = author['name']?.toString() ?? 'আক্কাস';

          final String authorImage =
              author['image']?.toString() ?? 'assets/images/author.png';

          // =========================
          // DRAWER
          // =========================

          return ListView(
            padding: EdgeInsets.zero,

            children: [
              // =========================
              // DRAWER HEADER
              // =========================
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: Colors.green),

                accountName: Text(
                  'Akkas Book Store',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                accountEmail: Text(authorName),

                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,

                  backgroundImage: AssetImage(authorImage),
                ),
              ),

              // =========================
              // NAVIGATION ITEMS
              // =========================
              ...navigation.map<Widget>((item) {
                final Map<String, dynamic> navigationItem =
                    Map<String, dynamic>.from(item);

                final String title = navigationItem['title']?.toString() ?? '';

                final String icon = navigationItem['icon']?.toString() ?? '';

                final String route = navigationItem['route']?.toString() ?? '';

                return ListTile(
                  leading: Icon(_getIcon(icon), color: Colors.green),

                  title: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  onTap: () {
                    Navigator.pop(context);

                    _navigate(context, route);
                  },
                );
              }).toList(),

              const Divider(height: 1),

              // =========================
              // FOOTER
              // =========================
              const DrawerFooter(),
            ],
          );
        },
      ),
    );
  }

  // =================================
  // ICON
  // =================================

  static IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home;

      case 'menu_book':
        return Icons.menu_book;

      case 'auto_stories':
        return Icons.auto_stories;

      case 'book':
        return Icons.book;

      case 'person':
        return Icons.person;

      case 'category':
        return Icons.category;

      case 'new_releases':
        return Icons.new_releases;

      case 'favorite':
        return Icons.favorite;

      case 'info':
        return Icons.info;

      case 'contact_mail':
        return Icons.contact_mail;

      case 'settings':
        return Icons.settings;

      default:
        return Icons.circle;
    }
  }

  // =================================
  // NAVIGATION
  // =================================

  static void _navigate(BuildContext context, String route) {
    switch (route) {
      // =========================
      // HOME
      // =========================

      case '/':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
        break;

      // =========================
      // ALL BOOKS
      // =========================

      case '/all-books':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AllBooksScreen()),
        );
        break;

      // =========================
      // CATEGORY
      // =========================

      case '/categories':
      case 'poems':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CategoriesScreen()),
        );
        break;

      // =========================
      // AUTHOR
      // =========================

      case '/author':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AuthorScreen()),
        );
        break;

      // =========================
      // NEW PUBLICATION
      // =========================

      case '/new_publication':
      case 'new_books':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NewPublicationsScreen(),
          ),
        );
        break;

      // =========================
      // FAVORITE BOOK
      // =========================

      case 'favorite':
      case '/favorite_books':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FavoriteBooksScreen()),
        );
        break;

      // =========================
      // ABOUT
      // =========================

      case '/about':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AboutScreen()),
        );
        break;

      // =========================
      // CONTACT
      // =========================

      case '/contact':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ContactScreen()),
        );
        break;

      // =========================
      // SETTINGS
      // =========================

      case '/settings':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
        break;

      // =========================
      // UNKNOWN ROUTE
      // =========================

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('এই page এখনো তৈরি করা হয়নি: $route')),
        );
    }
  }
}
