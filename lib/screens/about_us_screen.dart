import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8F7),

      // AppBar with Back Button
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'অ্যাপ সম্পর্কে',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Logo and Name
              Center(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,

                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(25),
                      ),

                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.transparent,
                        backgroundImage: const AssetImage(
                          'assets/author/author.png',
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'আক্কাছ আলী বুক স্টোর',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'বই হোক জ্ঞানের আলো',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 7,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: const Text(
                        'ভার্সন ১.০.০',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // About App
              sectionTitle('আমাদের সম্পর্কে'),

              const SizedBox(height: 10),

              const Text(
                'আক্কাছ আলী বুক স্টোর একটি বাংলা বই ও '
                'সাহিত্যভিত্তিক মোবাইল অ্যাপ। '
                'পাঠকদের কাছে বই ও সাহিত্যকে '
                'সহজভাবে পৌঁছে দেওয়াই এই অ্যাপের '
                'মূল উদ্দেশ্য।',

                style: TextStyle(
                  fontSize: 16,
                  height: 1.8,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'এই অ্যাপের মাধ্যমে পাঠকরা কবিতা, '
                'গল্প, উপন্যাস, সাহিত্য এবং '
                'বিভিন্ন ধরনের বইয়ের সংগ্রহ '
                'দেখতে পারবেন। আমরা চাই, '
                'প্রযুক্তির সাহায্যে বই পড়ার '
                'অভ্যাস আরও সহজ ও আনন্দদায়ক হোক।',

                style: TextStyle(
                  fontSize: 16,
                  height: 1.8,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 25),

              // App Features
              sectionTitle('অ্যাপের বিশেষ বৈশিষ্ট্য'),

              const SizedBox(height: 12),

              featureItem(
                Icons.menu_book_rounded,
                'বাংলা কবিতা, গল্প ও সাহিত্যের সংগ্রহ',
              ),

              featureItem(Icons.person_outline, 'বিভিন্ন লেখকের বই ও পরিচিতি'),

              featureItem(Icons.search, 'বই খোঁজার সহজ সুবিধা'),

              featureItem(Icons.phone_android, 'সহজ ও ব্যবহারবান্ধব ডিজাইন'),

              featureItem(
                Icons.bookmark_outline,
                'প্রিয় বই পড়ার ও আবিষ্কারের সুযোগ',
              ),

              const SizedBox(height: 25),

              // Mission
              sectionTitle('আমাদের লক্ষ্য'),

              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),

                child: const Text(
                  'বই মানুষের জ্ঞান, চিন্তা ও '
                  'সৃজনশীলতার বিকাশ ঘটায়। '
                  'আমাদের লক্ষ্য হলো বাংলা ভাষা, '
                  'সাহিত্য ও বইয়ের প্রতি পাঠকদের '
                  'আগ্রহ বাড়ানো এবং একটি '
                  'সহজ ডিজিটাল পাঠপরিবেশ তৈরি করা।',

                  style: TextStyle(
                    fontSize: 16,
                    height: 1.8,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Developer Information
              sectionTitle('অ্যাপ নির্মাতা'),

              const SizedBox(height: 12),

              Card(
                elevation: 2,
                color: Colors.white,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                child: const Padding(
                  padding: EdgeInsets.all(16),

                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.green,
                        backgroundImage: AssetImage('assets/lokman.png'),
                      ),

                      SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              'লোকমান হাকিম',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              'অ্যাপ ডেভেলপার',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),

                            SizedBox(height: 5),

                            Text(
                              'বাংলা বই ও প্রযুক্তির প্রতি '
                              'আগ্রহ থেকে তৈরি এই অ্যাপ।',
                              style: TextStyle(fontSize: 14, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // App Information
              sectionTitle('অ্যাপের তথ্য'),

              const SizedBox(height: 10),

              infoItem('অ্যাপের নাম', 'আক্কাছ আলী বুক স্টোর'),

              infoItem('অ্যাপের ধরন', 'বই ও সাহিত্য'),

              infoItem('ভার্সন', '১.০.০'),

              infoItem('ভাষা', 'বাংলা'),

              const SizedBox(height: 25),

              // Privacy Policy
              sectionTitle('গোপনীয়তা ও নীতিমালা'),

              const SizedBox(height: 10),

              const Text(
                'ব্যবহারকারীদের গোপনীয়তা আমাদের '
                'কাছে গুরুত্বপূর্ণ। অ্যাপটি কী ধরনের '
                'তথ্য সংগ্রহ করে এবং কীভাবে ব্যবহার '
                'করে, তা আমাদের Privacy Policy-তে '
                'বিস্তারিত উল্লেখ থাকবে।',

                style: TextStyle(
                  fontSize: 15,
                  height: 1.8,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'নিয়ম এবং শর্তাবলী মেনে চলা আমাদের জন্য গুরুত্বপূর্ণ। ',

                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 25),

              // Copyright
              const Divider(),

              const SizedBox(height: 10),

              const Center(
                child: Text(
                  '© ২০২৬ আক্কাছ আলী বুক স্টোর',

                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Center(
                child: Text(
                  'সর্বস্বত্ব সংরক্ষিত',

                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  // Section Title Widget
  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }

  // Feature Item Widget
  Widget featureItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 24),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 15, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  // Information Item Widget
  Widget infoItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),

      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 15, color: Colors.black54),
            ),
          ),

          const SizedBox(width: 10),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
