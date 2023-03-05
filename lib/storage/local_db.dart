import 'dart:async';
import 'dart:typed_data';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


import 'dao.dart';

part 'local_db.g.dart';

@Database(version: 1, entities: [MovieDatabaseModel])
abstract class LocalDatabase extends FloorDatabase {
  MovieDao get movieDao;
}