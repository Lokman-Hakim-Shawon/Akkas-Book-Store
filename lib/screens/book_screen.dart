import 'package:akkas_app_store/screens/book_reading_screen.dart';
import 'package:akkas_app_store/services/api_service.dart';
import 'package:flutter/material.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      // api.json থেকে পুরো data load হবে
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
                'বইয়ের তথ্য লোড করতে সমস্যা হয়েছে\n\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
          );
        }

        // =========================
        // JSON DATA CHECK
        // =========================

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text(
              'কোনো তথ্য পাওয়া যায়নি।',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        final data = snapshot.data!;

        // =========================
        // API DATA
        // =========================

        final apiData = data['data'];

        if (apiData == null) {
          return const Center(
            child: Text(
              'API data পাওয়া যায়নি।',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          );
        }

        // =========================
        // BOOKS
        // =========================

        final List books = apiData['books'] as List? ?? [];

        // =========================
        // EMPTY DATA
        // =========================

        if (books.isEmpty) {
          return const Center(
            child: Text(
              'এখনো কোনো বই যুক্ত করা হয়নি।',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          );
        }

        // =========================
        // BOOK LIST
        // =========================

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: books.length,

          itemBuilder: (context, index) {
            final book = books[index];

            final String title = book['title']?.toString() ?? 'বইয়ের নাম নেই';

            final String description = book['description']?.toString() ?? '';

            final String cover = book['cover']?.toString() ?? '';

            final String pdf = book['pdf']?.toString() ?? '';

            final String publishedDate =
                book['published_date']?.toString() ?? '';

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),

              child: Padding(
                padding: const EdgeInsets.all(12),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    // =========================
                    // BOOK COVER
                    // =========================
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),

                      child: Image.asset(
                        cover,
                        width: 90,
                        height: 120,
                        fit: BoxFit.cover,

                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 90,
                            height: 120,
                            color: Colors.grey.shade200,
                            child: const Icon(
                              Icons.menu_book_rounded,
                              size: 40,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 16),

                    // =========================
                    // BOOK INFORMATION
                    // =========================
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          // BOOK TITLE
                          Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,

                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),

                          const SizedBox(height: 7),

                          // AUTHOR
                          const Text(
                            'লেখক: আক্কাস',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 6),

                          // DESCRIPTION
                          if (description.isNotEmpty)
                            Text(
                              description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,

                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                                height: 1.4,
                              ),
                            ),

                          const SizedBox(height: 6),

                          // PUBLISHED DATE
                          if (publishedDate.isNotEmpty)
                            Text(
                              'প্রকাশকাল: $publishedDate',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),

                          const SizedBox(height: 10),

                          // READ BUTTON
                          SizedBox(
                            height: 40,

                            child: ElevatedButton.icon(
                              onPressed: pdf.isEmpty
                                  ? null
                                  : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BookReadingScreen(
                                                pdfPath: pdf,
                                                bookTitle: title,
                                              ),
                                        ),
                                      );
                                    },

                              icon: const Icon(
                                Icons.menu_book_rounded,
                                size: 18,
                              ),

                              label: const Text(
                                'পড়ুন',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1B5E20),

                                foregroundColor: Colors.white,

                                disabledBackgroundColor: Colors.grey.shade300,

                                disabledForegroundColor: Colors.grey.shade600,

                                elevation: 0,

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
              ),
            );
          },
        );
      },
    );
  }
}
