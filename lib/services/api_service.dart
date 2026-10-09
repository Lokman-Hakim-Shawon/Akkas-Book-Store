import 'dart:convert';

import 'package:akkas_app_store/models/books_model.dart';
import 'package:flutter/services.dart';

import '../models/post_model.dart';

class ApiService {
  // ============================================
  // Load API JSON
  // ============================================

  static Future<Map<String, dynamic>> loadApi() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/api.json',
    );

    return jsonDecode(jsonString);
  }

  // ============================================
  // Get Posts
  // ============================================

  static Future<List<PostModel>> getPosts() async {
    final apiData = await loadApi();

    final List posts = apiData['data']['posts'];

    return posts.map((post) => PostModel.fromJson(post)).toList();
  }

  // ============================================
  // Get Books
  // ============================================

  static Future<List<BookModel>> getBooks() async {
    final apiData = await loadApi();

    final List books = apiData['data']['books'];

    return books.map((book) => BookModel.fromJson(book)).toList();
  }
}
