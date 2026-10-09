import 'package:flutter/material.dart';
import 'package:akkas_app_store/screens/book_reading_screen.dart';
import 'package:akkas_app_store/services/json_service.dart';

class AllBooksScreen extends StatefulWidget {
  const AllBooksScreen({super.key});

  @override
  State<AllBooksScreen> createState() => _AllBooksScreenState();
}

class _AllBooksScreenState extends State<AllBooksScreen> {
  final TextEditingController searchController = TextEditingController();

  String selectedCategory = 'সকল বই';

  // =========================
  // BOOK DATA
  // =========================

  List<Map<String, dynamic>> books = [];

  // =========================
  // CATEGORY DATA
  // =========================

  List<Map<String, dynamic>> categories = [];

  // =========================
  // AUTHOR DATA
  // =========================

  Map<String, dynamic> author = {};

  bool isLoading = true;
  String? errorMessage;

  // =========================
  // LOAD API DATA
  // =========================

  Future<void> loadData() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final data = await JsonService.loadJson('api');

      final apiData = data['data'];

      if (apiData == null) {
        throw Exception('API data পাওয়া যায়নি');
      }

      // =========================
      // LOAD BOOKS
      // =========================

      final List bookData = apiData['books'] as List? ?? [];

      // =========================
      // LOAD CATEGORIES
      // =========================

      final List categoryData = apiData['categories'] as List? ?? [];

      // =========================
      // LOAD AUTHOR
      // =========================

      final Map<String, dynamic> authorData = apiData['author'] != null
          ? Map<String, dynamic>.from(apiData['author'])
          : {};

      if (!mounted) return;

      setState(() {
        books = bookData
            .map<Map<String, dynamic>>(
              (book) => Map<String, dynamic>.from(book),
            )
            .toList();

        categories = categoryData
            .map<Map<String, dynamic>>(
              (category) => Map<String, dynamic>.from(category),
            )
            .toList();

        author = authorData;

        isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage = error.toString();
      });

      debugPrint('API data load error: $error');
    }
  }

  // =========================
  // INIT STATE
  // =========================

  @override
  void initState() {
    super.initState();

    loadData();
  }

  // =========================
  // FILTER BOOKS
  // =========================

  List<Map<String, dynamic>> get filteredBooks {
    final query = searchController.text.trim().toLowerCase();

    return books.where((book) {
      final String title = book['title']?.toString().toLowerCase() ?? '';

      final int? categoryId = book['category_id'] is int
          ? book['category_id']
          : int.tryParse(book['category_id']?.toString() ?? '');

      final bool matchesSearch = title.contains(query);

      final bool matchesCategory =
          selectedCategory == 'সকল বই' || _categoryMatch(categoryId);

      return matchesSearch && matchesCategory;
    }).toList();
  }

  // =========================
  // CATEGORY MATCH
  // =========================

  bool _categoryMatch(int? categoryId) {
    if (categoryId == null) {
      return false;
    }

    final selectedCategoryData = categories.where((category) {
      return category['name']?.toString() == selectedCategory;
    });

    if (selectedCategoryData.isEmpty) {
      return false;
    }

    final int? selectedCategoryId = selectedCategoryData.first['id'] is int
        ? selectedCategoryData.first['id']
        : int.tryParse(selectedCategoryData.first['id']?.toString() ?? '');

    return categoryId == selectedCategoryId;
  }

  // =========================
  // CATEGORY NAMES
  // =========================

  List<String> get categoryNames {
    return [
      'সকল বই',
      ...categories.map((category) => category['name']?.toString() ?? ''),
    ];
  }

  // =========================
  // AUTHOR NAME
  // =========================

  String get authorName {
    return author['name']?.toString() ?? 'আক্কাস';
  }

  // =========================
  // DISPOSE
  // =========================

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  // =========================
  // BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F7),

      // =========================
      // APP BAR
      // =========================
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
          'লেখকের সকল বই',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),

      // =========================
      // BODY
      // =========================
      body: SafeArea(child: _buildBody()),
    );
  }

  // =========================
  // BODY
  // =========================

  Widget _buildBody() {
    // =========================
    // LOADING
    // =========================

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.green),
      );
    }

    // =========================
    // ERROR
    // =========================

    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              const Icon(Icons.error_outline, size: 60, color: Colors.red),

              const SizedBox(height: 15),

              const Text(
                'বইয়ের তথ্য লোড করতে সমস্যা হয়েছে',
                textAlign: TextAlign.center,

                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(
                errorMessage!,
                textAlign: TextAlign.center,

                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: loadData,

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
    // MAIN CONTENT
    // =========================

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        // =========================
        // HEADER
        // =========================
        Container(
          width: double.infinity,
          color: Colors.white,

          padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text(
                'পছন্দের বই পড়ুন',

                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF183D25),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                '$authorName-এর সকল বই এখন আপনার হাতের মুঠোয়',

                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 20),

              // =========================
              // SEARCH BAR
              // =========================
              TextField(
                controller: searchController,

                onChanged: (value) {
                  setState(() {});
                },

                decoration: InputDecoration(
                  hintText: 'বইয়ের নাম লিখে খুঁজুন',

                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),

                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF2E7D32),
                  ),

                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            searchController.clear();

                            setState(() {});
                          },

                          icon: const Icon(Icons.close),
                        )
                      : null,

                  filled: true,

                  fillColor: const Color(0xFFF4F7F4),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),

                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // =========================
        // CATEGORY FILTER
        // =========================
        SizedBox(
          height: 52,

          child: ListView.builder(
            scrollDirection: Axis.horizontal,

            padding: const EdgeInsets.symmetric(horizontal: 16),

            itemCount: categoryNames.length,

            itemBuilder: (context, index) {
              final category = categoryNames[index];

              final isSelected = selectedCategory == category;

              return Padding(
                padding: const EdgeInsets.only(right: 10),

                child: ChoiceChip(
                  label: Text(category),

                  selected: isSelected,

                  showCheckmark: false,

                  onSelected: (value) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },

                  selectedColor: const Color(0xFF1B5E20),

                  backgroundColor: Colors.white,

                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF183D25),

                    fontWeight: FontWeight.w600,

                    fontSize: 13,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),

                    side: BorderSide(
                      color: isSelected
                          ? const Color(0xFF1B5E20)
                          : Colors.grey.shade200,
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 25),

        // =========================
        // BOOK COUNT
        // =========================
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),

          child: Row(
            children: [
              const Text(
                'বইয়ের সংগ্রহ',

                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF183D25),
                ),
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),

                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),

                  borderRadius: BorderRadius.circular(20),
                ),

                child: Text(
                  '${filteredBooks.length} টি বই',

                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF1B5E20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // =========================
        // BOOK GRID
        // =========================
        Expanded(
          child: filteredBooks.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Icon(
                        Icons.menu_book_outlined,
                        size: 65,
                        color: Colors.grey,
                      ),

                      SizedBox(height: 12),

                      Text(
                        'কোনো বই পাওয়া যায়নি',

                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),

                  itemCount: filteredBooks.length,

                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,

                    crossAxisSpacing: 14,

                    mainAxisSpacing: 16,

                    childAspectRatio: 0.40,
                  ),

                  itemBuilder: (context, index) {
                    final book = filteredBooks[index];

                    return BookReadingCard(
                      book: book,

                      authorName: authorName,

                      onRead: () {
                        final pdf = book['pdf']?.toString() ?? '';

                        final title = book['title']?.toString() ?? 'বই পড়ুন';

                        if (pdf.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('এই বইয়ের PDF পাওয়া যায়নি।'),
                            ),
                          );

                          return;
                        }

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
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// ======================================
// BOOK READING CARD
// ======================================

class BookReadingCard extends StatelessWidget {
  final Map<String, dynamic> book;

  final String authorName;

  final VoidCallback onRead;

  const BookReadingCard({
    super.key,
    required this.book,
    required this.authorName,
    required this.onRead,
  });

  @override
  Widget build(BuildContext context) {
    final String title = book['title']?.toString() ?? 'বইয়ের নাম নেই';

    final String cover = book['cover']?.toString() ?? '';

    final String description = book['description']?.toString() ?? '';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),

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

              decoration: BoxDecoration(
                color: Colors.green,

                borderRadius: BorderRadius.circular(12),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),

                child: cover.isNotEmpty
                    ? Image.asset(
                        cover,

                        width: double.infinity,

                        fit: BoxFit.cover,

                        errorBuilder: (context, error, stackTrace) {
                          return _buildBookPlaceholder(title);
                        },
                      )
                    : _buildBookPlaceholder(title),
              ),
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
                  'লেখক: $authorName',

                  maxLines: 1,

                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),

                if (description.isNotEmpty) ...[
                  const SizedBox(height: 5),

                  Text(
                    description,

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                ],

                const SizedBox(height: 12),

                // =========================
                // READ BUTTON
                // =========================
                SizedBox(
                  width: double.infinity,

                  height: 40,

                  child: ElevatedButton.icon(
                    onPressed: onRead,

                    icon: const Icon(Icons.menu_book_rounded, size: 18),

                    label: const Text(
                      'পড়ুন',

                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B5E20),

                      foregroundColor: Colors.white,

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
  // BOOK PLACEHOLDER
  // =========================

  Widget _buildBookPlaceholder(String title) {
    return Container(
      width: double.infinity,

      height: double.infinity,

      color: Colors.green,

      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10,

            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white54, width: 1.2),

                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const Icon(
                    Icons.menu_book_rounded,
                    size: 42,
                    color: Colors.white,
                  ),

                  const SizedBox(height: 14),

                  Text(
                    title,

                    textAlign: TextAlign.center,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(width: 35, height: 2, color: Colors.white70),

                  const SizedBox(height: 10),

                  Text(
                    authorName,

                    textAlign: TextAlign.center,

                    style: const TextStyle(color: Colors.white, fontSize: 13),
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
