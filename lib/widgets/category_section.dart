import 'package:akkas_app_store/services/api_service.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  // ==========================================
  // Selected Category
  // ==========================================

  int selectedIndex = -1;

  // ==========================================
  // Build
  // ==========================================

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: ApiService.loadApi(),

      builder: (context, snapshot) {
        // ==========================================
        // Loading
        // ==========================================

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 160,
            child: Center(
              child: CircularProgressIndicator(color: Colors.green),
            ),
          );
        }

        // ==========================================
        // Error
        // ==========================================

        if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'বিভাগ লোড করা যাচ্ছে না',
              style: TextStyle(color: Colors.red, fontSize: 15),
            ),
          );
        }

        // ==========================================
        // JSON Data
        // ==========================================

        final data = snapshot.data;

        if (data == null) {
          return const SizedBox();
        }

        // api.json structure:
        //
        // data
        //   └── categories
        //

        final List categories = data['data']['categories'] as List? ?? [];

        // ==========================================
        // Empty Category
        // ==========================================

        if (categories.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'কোনো বিভাগ পাওয়া যায়নি',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        // ==========================================
        // Category UI
        // ==========================================

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // Section Header
            // ==========================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  const Text(
                    'বইয়ের বিভাগ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('সকল বিভাগ')),
                      );
                    },

                    child: const Text(
                      'সব দেখুন',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ==========================================
            // Horizontal Category List
            // ==========================================
            SizedBox(
              height: 115,

              child: ListView.builder(
                scrollDirection: Axis.horizontal,

                padding: const EdgeInsets.symmetric(horizontal: 16),

                itemCount: categories.length,

                itemBuilder: (context, index) {
                  final category = categories[index] as Map<String, dynamic>;

                  final bool isSelected = selectedIndex == index;

                  // ==========================================
                  // Category Data
                  // ==========================================

                  final String name = category['name']?.toString() ?? '';

                  final String slug = category['slug']?.toString() ?? '';

                  final String description =
                      category['description']?.toString() ?? '';

                  final String iconName = category['icon']?.toString() ?? '';

                  final String colorValue = category['color']?.toString() ?? '';

                  // ==========================================
                  // Convert Icon
                  // ==========================================

                  final IconData icon = _getIcon(iconName);

                  // ==========================================
                  // Convert Color
                  // ==========================================

                  final Color color = _getColor(colorValue);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$name বিভাগ নির্বাচন করেছেন'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },

                    child: Container(
                      width: 100,

                      margin: const EdgeInsets.only(right: 12),

                      decoration: BoxDecoration(
                        color: color,

                        borderRadius: BorderRadius.circular(16),

                        border: Border.all(
                          color: isSelected ? Colors.green : Colors.transparent,

                          width: 2,
                        ),
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          // ==================================
                          // Category Icon
                          // ==================================
                          Container(
                            height: 48,
                            width: 48,

                            decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(14),
                            ),

                            child: Icon(icon, color: Colors.green, size: 28),
                          ),

                          const SizedBox(height: 10),

                          // ==================================
                          // Category Name
                          // ==================================
                          Text(
                            name,

                            textAlign: TextAlign.center,

                            maxLines: 1,

                            overflow: TextOverflow.ellipsis,

                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF242824),
                            ),
                          ),

                          // slug and description are
                          // loaded from JSON and available
                          // for future category navigation.
                          //
                          // Example:
                          // slug = poetry
                          // description = ...
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  // =====================================================
  // Convert JSON Icon String → Flutter IconData
  // =====================================================

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'Icons.auto_stories':
        return Icons.auto_stories;

      case 'Icons.menu_book':
        return Icons.menu_book;

      case 'Icons.import_contacts':
        return Icons.import_contacts;

      case 'Icons.school':
        return Icons.school;

      case 'Icons.child_care':
        return Icons.child_care;

      case 'Icons.mosque':
        return Icons.mosque;

      case 'Icons.book':
        return Icons.book;

      case 'Icons.library_books':
        return Icons.library_books;

      case 'Icons.article':
        return Icons.article;

      default:
        return Icons.menu_book;
    }
  }

  // =====================================================
  // Convert JSON Color String → Flutter Color
  // =====================================================

  Color _getColor(String colorValue) {
    try {
      // Example:
      // Color(0xFFF3E9D6)

      final match = RegExp(r'0x([0-9A-Fa-f]+)').firstMatch(colorValue);

      if (match != null) {
        final hexValue = match.group(1)!;

        return Color(int.parse(hexValue, radix: 16));
      }

      return const Color(0xFFF5F5F5);
    } catch (error) {
      debugPrint('Category color error: $error');

      return const Color(0xFFF5F5F5);
    }
  }
}
