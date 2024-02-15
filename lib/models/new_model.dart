class NewModel {
  NewModel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });
  late final String author;
  late final String title;
  late final String description;
  late final String url;
  late final String urlToImage;
  late final String publishedAt;
  late final String content;

  NewModel.fromJson(Map<String, dynamic> json) {
    author = json['author'] ?? "";
    title = json['title'] ?? "";
    description = json['description'] ?? "";
    url = json['url'] ?? "";
    urlToImage = json['urlToImage'] ?? "";
    publishedAt = json['publishedAt'] ?? "";
    content = json['content'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['author'] = author;
    data['title'] = title;
    data['description'] = description;
    data['url'] = url;
    data['urlToImage'] = urlToImage;
    data['publishedAt'] = publishedAt;
    data['content'] = content;
    return data;
  }
}

class Source {
  Source({
    required this.id,
    required this.name,
  });
  late final String id;
  late final String name;

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
