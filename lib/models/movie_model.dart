import 'dart:convert';

class MovieModel {
  final String title;
  final String imageUrl;
  final String releaseData;
  final String overView;
  MovieModel({
    required this.title,
    required this.imageUrl,
    required this.releaseData,
    required this.overView,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'imageUrl': imageUrl,
      'releaseData': releaseData,
      'overView': overView,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      releaseData: map['releaseData'] as String,
      overView: map['overView'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieModel.fromJson(String source) => MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
