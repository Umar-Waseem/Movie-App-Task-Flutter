import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app_task/models/movie_model.dart';

void main() {
  final movie = MovieModel.fromMap({
    "original_title": "original_title",
    "id": "id",
    "genre_ids": [1],
    "backdrop_path": "backdrop_path",
    "release_date": "release_date",
    "overview": "overview",
    "poster_path": "poster_path",
  });

  test('Checks if json from api converts to Movie Object properly', () {
    // test movie model

    expect(movie.original_title, "original_title");
    expect(movie.id, "id");
    expect(movie.genre_ids, [1]);
  });
}
