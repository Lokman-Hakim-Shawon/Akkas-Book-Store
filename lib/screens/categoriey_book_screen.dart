import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'title': 'কবিতা সমূহ',
        'subtitle': 'কবিতার সুন্দর জগৎ',
        'icon': Icons.edit_note,
        'count': '১২ টি কবিতা',
        'color': Colors.green.shade400,
      },
      {
        'title': 'গল্প সমূহ',
        'subtitle': 'ছোট গল্প ও জীবনের কথা',
        'icon': Icons.auto_stories,
        'count': '৮ টি গল্প',
        'color': Colors.teal.shade400,
      },
      {
        'title': 'উপন্যাস',
        'subtitle': 'উপন্যাসের বিশাল জগৎ',
        'icon': Icons.menu_book,
        'count': '৫ টি উপন্যাস',
        'color': Colors.blue.shade400,
      },
      {
        'title': 'প্রবন্ধ',
        'subtitle': 'চিন্তা ও মননের প্রকাশ',
        'icon': Icons.article_outlined,
        'count': '৬ টি প্রবন্ধ',
        'color': Colors.orange.shade400,
      },
      {
        'title': 'অন্যান্য লেখা',
        'subtitle': 'বিবিধ সাহিত্যকর্ম',
        'icon': Icons.library_books_outlined,
        'count': '৪ টি লেখা',
        'color': Colors.purple.shade400,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F7),

      // APP BAR
      appBar: AppBar(
        backgroundColor: Colors.green,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
        ),

        title: const Text(
          'বইয়ের বিভাগ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      // BODY
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER BANNER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.local_library_rounded,
                      size: 42,
                      color: Colors.white,
                    ),

                    SizedBox(height: 16),

                    Text(
                      'সাহিত্যের জগতে\nস্বাগতম',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      'আপনার পছন্দের বিভাগ নির্বাচন করুন '
                      'এবং পড়তে থাকুন প্রিয় লেখকের '
                      'সাহিত্যকর্ম।',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.8,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // SECTION TITLE
              const Text(
                'সকল বিভাগ',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF183D25),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'আপনার পছন্দের বই খুঁজে নিন',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 20),

              // CATEGORY LIST
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),

                itemCount: categories.length,

                separatorBuilder: (context, index) {
                  return const SizedBox(height: 14);
                },

                itemBuilder: (context, index) {
                  final category = categories[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(16),

                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${category['title']} নির্বাচন করা হয়েছে',
                          ),
                        ),
                      );
                    },

                    child: Container(
                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Row(
                        children: [
                          // CATEGORY ICON
                          Container(
                            height: 60,
                            width: 60,

                            decoration: BoxDecoration(
                              color: category['color'].withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(15),
                            ),

                            child: Icon(
                              category['icon'],
                              color: category['color'],
                              size: 30,
                            ),
                          ),

                          const SizedBox(width: 16),

                          // CATEGORY DETAILS
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  category['title'],
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF183D25),
                                  ),
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  category['subtitle'],
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  category['count'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ARROW
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 17,
                            color: Colors.green.shade400,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),

              // FOOTER
              Center(
                child: Text(
                  'পড়ুন, জানুন এবং সাহিত্যের সঙ্গে থাকুন',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
