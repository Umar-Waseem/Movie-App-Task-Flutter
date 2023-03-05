// use floor db to store movies

import 'package:floor/floor.dart';

@entity
class MovieDatabaseModel {
  @primaryKey
  final int id;
  final String original_title;
  final String? backdrop_path;
  final String? release_date;
  final String? overview;
  final String? poster_path;

  MovieDatabaseModel({
    required this.id,
    required this.original_title,
    this.backdrop_path,
    this.release_date,
    this.overview,
    this.poster_path,
  });
}

// store movies in local database

@dao
abstract class MovieDao {
  @Query('SELECT * FROM MovieDatabaseModel')
  Future<List<MovieDatabaseModel>> findAllMovies();

  @Query('SELECT * FROM MovieDatabaseModel WHERE id = :id')
  Future<MovieDatabaseModel?> findMovieById(int id);

  @insert
  Future<void> insertMovie(MovieDatabaseModel movie);

  @insert
  Future<void> insertMovies(List<MovieDatabaseModel> movies);
}
