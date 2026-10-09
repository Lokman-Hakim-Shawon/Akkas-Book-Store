import 'package:flutter/material.dart';

class DrawerFooter extends StatelessWidget {
  const DrawerFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),

      decoration: const BoxDecoration(
        color: Color(0xFFF7F5EF),

        border: Border(top: BorderSide(color: Color(0xFFE5E5E5), width: 1)),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // App Logo
          Container(
            height: 50,
            width: 50,

            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(15),
            ),

            child: const Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),

          const SizedBox(height: 10),

          // App Name
          const Text(
            'আক্কাছ আলী বুক স্টোর',

            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),

          const SizedBox(height: 4),

          // Author Name
          const Text(
            'লেখক: আক্কাছ আলী',

            style: TextStyle(fontSize: 13, color: Color(0xFF777777)),
          ),

          const SizedBox(height: 12),

          // Version
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),

            decoration: BoxDecoration(
              color: const Color(0xFFE5EFE9),
              borderRadius: BorderRadius.circular(20),
            ),

            child: const Text(
              'সংস্করণ ১.০.০',

              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            '© ২০২৬ আক্কাছ আলী বুক স্টোর',

            style: TextStyle(fontSize: 11, color: Color(0xFF999999)),
          ),
        ],
      ),
    );
  }
}
