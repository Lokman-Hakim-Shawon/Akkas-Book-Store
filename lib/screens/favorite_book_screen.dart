import 'package:akkas_app_store/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:akkas_app_store/screens/book_reading_screen.dart';

class FavoriteBooksScreen extends StatefulWidget {
  const FavoriteBooksScreen({super.key});

  @override
  State<FavoriteBooksScreen> createState() => _FavoriteBooksScreenState();
}

class _FavoriteBooksScreenState extends State<FavoriteBooksScreen> {
  List<Map<String, dynamic>> books = [];

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadFavoriteBooks();
  }

  // =========================
  // LOAD FAVORITE BOOKS
  // =========================

  Future<void> loadFavoriteBooks() async {
    try {
      final data = await ApiService.loadApi();

      final apiData = data['data'];

      final List bookData = apiData['books'] as List? ?? [];

      final favoriteBooks = bookData
          .where((book) => book['is_favorite'] == true)
          .map<Map<String, dynamic>>((book) => Map<String, dynamic>.from(book))
          .toList();

      if (!mounted) return;

      setState(() {
        books = favoriteBooks;
        isLoading = false;
      });
    } catch (error) {
      debugPrint('Favorite books load error: $error');

      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage = 'বইগুলো লোড করা যাচ্ছে না।';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F7),

      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),

        title: const Text(
          'লেখকের পছন্দের বই',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
      ),

      // =========================
      // BODY
      // =========================
      body: _buildBody(),
    );
  }

  // =========================
  // BODY BUILDER
  // =========================

  Widget _buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.green),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 50),

              const SizedBox(height: 15),

              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15, color: Colors.grey),
              ),

              const SizedBox(height: 15),

              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                    errorMessage = null;
                  });

                  loadFavoriteBooks();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('আবার চেষ্টা করুন'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (books.isEmpty) {
      return _buildEmptyState();
    }

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================
            // HEADER BANNER
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(22),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.favorite_rounded,
                    color: Colors.white,
                    size: 40,
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'লেখকের প্রিয়\nবইয়ের সংগ্রহ',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'লেখকের নিজের পছন্দের '
                    'বইগুলো পড়ুন এবং '
                    'সাহিত্যের নতুন জগৎ আবিষ্কার করুন।',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.8,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.20),
                      borderRadius: BorderRadius.circular(25),
                    ),

                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.menu_book_rounded,
                          color: Colors.white,
                          size: 18,
                        ),

                        const SizedBox(width: 8),

                        Text(
                          '${books.length} টি পছন্দের বই',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =========================
            // SECTION TITLE
            // =========================
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'লেখকের পছন্দের বই',
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
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            const Text(
              'লেখকের নির্বাচিত সাহিত্যকর্ম',

              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // =========================
            // BOOK GRID
            // =========================
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: books.length,

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 16,
                childAspectRatio: 0.62,
              ),

              itemBuilder: (context, index) {
                final book = books[index];

                return _buildBookCard(book);
              },
            ),

            const SizedBox(height: 25),

            // =========================
            // FOOTER
            // =========================
            Center(
              child: Text(
                'সাহিত্যের সঙ্গে থাকুন, বই পড়তে থাকুন',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // =========================
  // BOOK CARD
  // =========================

  Widget _buildBookCard(Map<String, dynamic> book) {
    final String title = book['title']?.toString() ?? '';

    final String description = book['description']?.toString() ?? '';

    final String cover = book['cover']?.toString() ?? '';

    final String pdf = book['pdf']?.toString() ?? '';

    final String publishedDate = book['published_date']?.toString() ?? '';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =========================
          // BOOK COVER
          // =========================
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(8),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),

              child: cover.isNotEmpty
                  ? Image.asset(
                      cover,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,

                      errorBuilder: (context, error, stackTrace) {
                        return _buildCoverFallback(title);
                      },
                    )
                  : _buildCoverFallback(title),
            ),
          ),

          // =========================
          // BOOK INFORMATION
          // =========================
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF183D25),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    height: 1.5,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 7),

                if (publishedDate.isNotEmpty)
                  Text(
                    'প্রকাশনা: $publishedDate',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                const SizedBox(height: 10),

                // =========================
                // READ BUTTON
                // =========================
                SizedBox(
                  width: double.infinity,
                  height: 38,

                  child: ElevatedButton.icon(
                    onPressed: pdf.isEmpty
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookReadingScreen(
                                  pdfPath: pdf,
                                  bookTitle: title,
                                ),
                              ),
                            );
                          },

                    icon: const Icon(Icons.menu_book_rounded, size: 17),

                    label: const Text(
                      'পড়ুন',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey.shade300,
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
    );
  }

  // =========================
  // COVER FALLBACK
  // =========================

  Widget _buildCoverFallback(String title) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.green.shade700, Colors.green.shade400],
        ),
      ),

      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.menu_book_rounded,
                color: Colors.white,
                size: 42,
              ),

              const SizedBox(height: 14),

              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // EMPTY STATE
  // =========================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border,
                color: Colors.green,
                size: 45,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'কোনো পছন্দের বই পাওয়া যায়নি',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'api.json-এ কোনো বইয়ের '
              'is_favorite true নেই।',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
