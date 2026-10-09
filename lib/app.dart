import 'package:akkas_app_store/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:akkas_app_store/services/json_service.dart';

class AuthorBookApp extends StatelessWidget {
  const AuthorBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: JsonService.loadJson('app'),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        // Error
        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text(
                  'App data load করতে সমস্যা হয়েছে',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        }

        // JSON data
        final appData = snapshot.data;

        final appName = appData['name'];

        final primaryColor = _hexToColor(appData['theme']['primaryColor']);

        final backgroundColor = _hexToColor(
          appData['theme']['backgroundColor'],
        );

        final cardColor = _hexToColor(appData['theme']['cardColor']);

        return MaterialApp(
          debugShowCheckedModeBanner: false,

          // App name comes from JSON
          title: appName,

          theme: ThemeData(
            useMaterial3: true,

            // Main Color
            colorScheme: ColorScheme.fromSeed(
              seedColor: primaryColor,
              brightness: Brightness.light,
            ),

            // Background
            scaffoldBackgroundColor: backgroundColor,

            // AppBar
            appBarTheme: AppBarTheme(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
            ),

            // Card
            cardTheme: CardThemeData(
              color: cardColor,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            // Elevated Button
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          home: const MainScreen(),
        );
      },
    );
  }

  // Convert HEX color to Flutter Color
  static Color _hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');

    return Color(int.parse('FF$hex', radix: 16));
  }
}
