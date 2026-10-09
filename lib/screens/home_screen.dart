import "package:akkas_app_store/widgets/home_Banner.dart";

import "package:akkas_app_store/widgets/category_section.dart";
import "package:akkas_app_store/widgets/drawer_footer.dart";
import "package:akkas_app_store/widgets/post_card.dart";
import "package:akkas_app_store/services/api_service.dart";
import "package:akkas_app_store/models/post_model.dart";
import "package:flutter/material.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --------------------------------
            // Home Banner
            // --------------------------------
            const HomeBanner(),

            // --------------------------------
            // Categories
            // --------------------------------
            const CategorySection(),

            const SizedBox(height: 20),

            // --------------------------------
            // Author Posts
            // --------------------------------
            const AuthorPostsSection(),

            const SizedBox(height: 20),

            const SizedBox(height: 12),
            const DrawerFooter(),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// Author Posts Section
// =====================================================

class AuthorPostsSection extends StatelessWidget {
  const AuthorPostsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostModel>>(
      future: ApiService.getPosts(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          );
        }

        // Error
        if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'পোস্ট লোড করা যাচ্ছে না',
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        final posts = snapshot.data ?? [];

        // Empty
        if (posts.isEmpty) {
          return const SizedBox();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --------------------------------
            // Section Title
            // --------------------------------
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'লেখকের পোস্ট',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 30),

            // --------------------------------
            // Posts
            // --------------------------------
            ...posts.take(15).map((post) {
              return PostCard(
                post: post,
                authorName: 'আক্কাস',
                authorImage: 'assets/images/author.png',
              );
            }),
          ],
        );
      },
    );
  }
}
