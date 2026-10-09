class PostModel {
  final int id;
  final int authorId;
  final String type;
  final String title;
  final String content;
  final String? image;
  final int? bookId;
  final String createdAt;
  final int likes;
  final int comments;

  PostModel({
    required this.id,
    required this.authorId,
    required this.type,
    required this.title,
    required this.content,
    this.image,
    this.bookId,
    required this.createdAt,
    required this.likes,
    required this.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      authorId: json['author_id'],
      type: json['type'],
      title: json['title'],
      content: json['content'],
      image: json['image'] as String?,
      bookId: json['book_id'],
      createdAt: json['created_at'],
      likes: json['likes'],
      comments: json['comments'],
    );
  }
}
