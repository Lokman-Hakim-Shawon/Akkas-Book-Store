import 'package:flutter/material.dart';

class NewPublicationsScreen extends StatelessWidget {
  const NewPublicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> books = [
      {
        'title': 'নীরব বিকেল',
        'author': 'আক্কাছ আলী',
        'category': 'কবিতা',
        'description': 'অনুভূতি, ভালোবাসা ও জীবনের গল্প নিয়ে কবিতার সংকলন।',
        'color': Colors.green.shade400,
        'date': 'নতুন প্রকাশনা',
      },
      {
        'title': 'জীবনের গল্প',
        'author': 'আক্কাছ আলী',
        'category': 'গল্প',
        'description': 'জীবনের নানা অভিজ্ঞতা ও মানুষের সম্পর্কের গল্প।',
        'color': Colors.teal.shade400,
        'date': 'নতুন প্রকাশনা',
      },
      {
        'title': 'অচেনা পথ',
        'author': 'আক্কাছ আলী',
        'category': 'উপন্যাস',
        'description': 'জীবনের পথচলা ও বাস্তবতার এক অনন্য উপাখ্যান।',
        'color': Colors.blue.shade400,
        'date': 'নতুন প্রকাশনা',
      },
      {
        'title': 'মনের আকাশ',
        'author': 'আক্কাছ আলী',
        'category': 'কবিতা',
        'description': 'মনের অনুভূতি ও স্বপ্ন নিয়ে সাজানো কবিতার বই।',
        'color': Colors.purple.shade400,
        'date': 'নতুন প্রকাশনা',
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
          'নতুন প্রকাশনা',
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
                      Icons.auto_stories_rounded,
                      size: 42,
                      color: Colors.white,
                    ),

                    SizedBox(height: 16),

                    Text(
                      'নতুন বইয়ের\nসাহিত্য জগৎ',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      'লেখকের নতুন প্রকাশিত বই ও '
                      'সাহিত্যকর্ম পড়ুন এক জায়গায়।',
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
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'সাম্প্রতিক প্রকাশনা',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF183D25),
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${books.length} টি বই',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade400,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Text(
                'নতুন বই আবিষ্কার করুন এবং পড়তে থাকুন',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 20),

              // PUBLICATION LIST
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: books.length,

                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },

                itemBuilder: (context, index) {
                  final book = books[index];

                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // BOOK COVER
                        Container(
                          height: 170,
                          width: 115,
                          decoration: BoxDecoration(
                            color: book['color'],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 8,
                                left: 8,
                                right: 8,
                                bottom: 8,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white54,
                                      width: 1.2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),

                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.menu_book_rounded,
                                        color: Colors.white,
                                        size: 35,
                                      ),

                                      const SizedBox(height: 12),

                                      Text(
                                        book['title'],
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          height: 1.5,
                                          color: Colors.white,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      Text(
                                        book['author'],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 14),

                        // BOOK INFORMATION
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  book['date'],
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green.shade400,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                book['title'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF183D25),
                                ),
                              ),

                              const SizedBox(height: 7),

                              Text(
                                'লেখক: ${book['author']}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                'বিভাগ: ${book['category']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green.shade400,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                book['description'],
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  height: 1.6,
                                  color: Colors.black54,
                                ),
                              ),

                              const SizedBox(height: 12),

                              // READ BUTTON
                              SizedBox(
                                width: double.infinity,
                                height: 38,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${book['title']} '
                                          'বইটি পড়ার জন্য প্রস্তুত',
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.menu_book, size: 17),
                                  label: const Text(
                                    'পড়ুন',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade400,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
