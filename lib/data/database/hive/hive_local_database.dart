import 'package:hive_ce/hive.dart';

import '../no_sql_local_database.dart';

class HiveLocalDatabase<T> implements NoSqlLocalDatabase<T> {
  final String collectionName;

  HiveLocalDatabase(this.collectionName);

  Future<Box<T>> _openBox() async {
    if (!Hive.isBoxOpen(collectionName)) {
      return await Hive.openBox<T>(collectionName);
    }
    return Hive.box<T>(collectionName);
  }

  @override
  Future<T> insert(T document) async {
    final box = await _openBox();
    final key = _getDocumentKey(document);
    if (box.containsKey(key)) {
      throw Exception('Document with the same key already exists.');
    }
    await box.put(key, document);
    return document;
  }

  @override
  Future<T?> getById(String id) async {
    final box = await _openBox();
    return box.get(id);
  }

  @override
  Future<T> update(String id, T updatedDocument) async {
    final box = await _openBox();
    if (!box.containsKey(id)) {
      throw Exception('Document with the given ID does not exist.');
    }
    await box.put(id, updatedDocument);
    return updatedDocument;
  }

  @override
  Future<bool> delete(String id) async {
    final box = await _openBox();
    if (box.containsKey(id)) {
      await box.delete(id);
      return true;
    }
    return false;
  }

  @override
  Future<List<T>> getAll() async {
    final box = await _openBox();
    return box.values.toList();
  }

  @override
  Future<bool> clearCollection() async {
    final box = await _openBox();
    await box.clear();
    return true;
  }

  /// Helper method to extract a unique key for the document.
  /// Assumes that the document has a `String id` field.
  String _getDocumentKey(T document) {
    if (document is Map && document.containsKey('id')) {
      return document['id'] as String;
      // ignore: unnecessary_type_check
    } else if (document is dynamic && document.id is String) {
      return document.id;
    } else {
      throw Exception('Document must have an "id" field of type String.');
    }
  }
}
