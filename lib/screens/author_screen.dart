import 'package:flutter/material.dart';
import 'package:akkas_app_store/services/json_service.dart';

class AuthorScreen extends StatefulWidget {
  const AuthorScreen({super.key});

  @override
  State<AuthorScreen> createState() => _AuthorScreenState();
}

class _AuthorScreenState extends State<AuthorScreen> {
  Map<String, dynamic>? authorData;

  @override
  void initState() {
    super.initState();
    loadAuthor();
  }

  Future<void> loadAuthor() async {
    try {
      final data = await JsonService.loadJson('author');

      setState(() {
        authorData = data;
      });
    } catch (error) {
      debugPrint('Author data load error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (authorData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.green)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('লেখক পরিচিতি')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Author Image
            CircleAvatar(
              radius: 65,
              backgroundImage: AssetImage(authorData!['image']),
            ),

            const SizedBox(height: 16),

            // Author Name
            Text(
              authorData!['name'],
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            // Designation
            Text(
              authorData!['designation'],
              style: const TextStyle(fontSize: 17, color: Colors.green),
            ),

            const SizedBox(height: 24),

            // Biography
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'লেখক সম্পর্কে',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      authorData!['biography'],
                      style: const TextStyle(fontSize: 16, height: 1.6),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Address
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.green),
              title: const Text('ঠিকানা'),
              subtitle: Text(authorData!['address']),
            ),

            // Email
            ListTile(
              leading: const Icon(Icons.email, color: Colors.green),
              title: const Text('ইমেইল'),
              subtitle: Text(authorData!['email']),
            ),

            // Phone
            if (authorData!['phone'].toString().isNotEmpty)
              ListTile(
                leading: const Icon(Icons.phone, color: Colors.green),
                title: const Text('ফোন'),
                subtitle: Text(authorData!['phone']),
              ),
          ],
        ),
      ),
    );
  }
}
