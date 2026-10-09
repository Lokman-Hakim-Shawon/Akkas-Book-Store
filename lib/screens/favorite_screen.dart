import 'package:flutter/material.dart';
import 'package:akkas_app_store/services/json_service.dart';
import 'package:akkas_app_store/screens/book_reading_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Map<String, dynamic>> favoriteBooks = [];

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
      final data = await JsonService.loadJson('api');

      final List books = data['data']['books'] as List? ?? [];

      final List<Map<String, dynamic>> loadedBooks = books
          .where((book) => book['is_favorite'] == true)
          .map((book) => Map<String, dynamic>.from(book))
          .toList();

      if (!mounted) return;

      setState(() {
        favoriteBooks = loadedBooks;
        isLoading = false;
      });
    } catch (error) {
      debugPrint('Favorite books load error: $error');

      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage = 'পছন্দের বই লোড করা যাচ্ছে না।';
      });
    }
  }

  // =========================
  // CATEGORY NAME
  // =========================

  String getCategoryName(int categoryId) {
    switch (categoryId) {
      case 1:
        return 'কবিতা';

      case 2:
        return 'উপন্যাস';

      case 3:
        return 'গল্প';

      case 4:
        return 'শিক্ষামূলক';

      case 5:
        return 'ইসলামিক';

      case 6:
        return 'অন্যান্য';

      default:
        return 'অন্যান্য';
    }
  }

  // =========================
  // OPEN BOOK
  // =========================

  void openBook(BuildContext context, Map<String, dynamic> book) {
    final String pdfPath = book['pdf']?.toString() ?? '';
    final String title = book['title']?.toString() ?? 'বই পড়ুন';

    if (pdfPath.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('এই বইয়ের PDF পাওয়া যায়নি।')),
      );

      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            BookReadingScreen(pdfPath: pdfPath, bookTitle: title),
      ),
    );
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
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
              const Icon(Icons.error_outline, color: Colors.red, size: 55),

              const SizedBox(height: 15),

              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.red),
              ),

              const SizedBox(height: 20),

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
              ),
            ],
          ),
        ),
      );
    }

    if (favoriteBooks.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite_border, size: 80, color: Colors.grey),

              SizedBox(height: 20),

              Text(
                'আমার পছন্দের বই এখনো যুক্ত করা হয়নি।',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              SizedBox(height: 10),

              Text(
                'API থেকে পছন্দের বই যোগ করলে এখানে দেখা যাবে।',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      color: Colors.green,
      onRefresh: loadFavoriteBooks,
      child: CustomScrollView(
        slivers: [
          // =========================
          // HEADER
          // =========================
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.shade100),
              ),
              child: Row(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'আমার পছন্দের বই',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          '${favoriteBooks.length}টি পছন্দের বই',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // =========================
          // BOOK GRID
          // =========================
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                final book = favoriteBooks[index];

                final String title = book['title']?.toString() ?? '';

                final String description =
                    book['description']?.toString() ?? '';

                final String cover = book['cover']?.toString() ?? '';

                final String pdf = book['pdf']?.toString() ?? '';

                final int categoryId = book['category_id'] ?? 0;

                final String category = getCategoryName(categoryId);

                return _buildBookCard(
                  context,
                  title: title,
                  description: description,
                  cover: cover,
                  pdf: pdf,
                  category: category,
                  book: book,
                );
              }, childCount: favoriteBooks.length),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 16,
                childAspectRatio: 0.58,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // BOOK CARD
  // =========================

  Widget _buildBookCard(
    BuildContext context, {
    required String title,
    required String description,
    required String cover,
    required String pdf,
    required String category,
    required Map<String, dynamic> book,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
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
            flex: 6,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: cover.isNotEmpty
                  ? Image.asset(
                      cover,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          color: Colors.grey.shade100,
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey.shade100,
                      child: const Center(
                        child: Icon(
                          Icons.menu_book,
                          color: Colors.grey,
                          size: 45,
                        ),
                      ),
                    ),
            ),
          ),

          // =========================
          // BOOK INFORMATION
          // =========================
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      const Icon(
                        Icons.category_outlined,
                        size: 14,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 4),

                      Expanded(
                        child: Text(
                          category,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Expanded(
                    child: Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                  ),

                  // =========================
                  // READ BUTTON
                  // =========================
                  SizedBox(
                    width: double.infinity,
                    height: 34,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        openBook(context, book);
                      },
                      icon: const Icon(Icons.menu_book, size: 16),
                      label: const Text(
                        'পড়ুন',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
