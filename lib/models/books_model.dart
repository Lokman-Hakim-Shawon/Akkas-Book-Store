class BookModel {
  final int id;
  final String title;
  final int authorId;
  final int categoryId;
  final String description;
  final String cover;
  final String pdf;
  final String publishedDate;
  final bool isNew;

  BookModel({
    required this.id,
    required this.title,
    required this.authorId,
    required this.categoryId,
    required this.description,
    required this.cover,
    required this.pdf,
    required this.publishedDate,
    required this.isNew,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'],
      authorId: json['author_id'],
      categoryId: json['category_id'],
      description: json['description'],
      cover: json['cover'],
      pdf: json['pdf'],
      publishedDate: json['published_date'],
      isNew: json['is_new'],
    );
  }
}
